require 'rails_helper'

RSpec.describe "Fragments", type: :request do
  let(:user) { create(:user, :activated) }
  let(:other) { create(:user, :activated) }
  let(:video) { create(:video, user_id: user.id) }
  let(:login_user) { user }

  describe "#new" do
    before do
      login_as login_user
      get new_user_fragment_url user.id
    end
    subject { response }

    context 'when logged in' do
      it { is_expected.to be_success }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.to redirect_to login_url }
    end
  end

  describe "#create" do
    let(:video_id) { video.id }
    let(:title) { 'title' }
    let(:description) { 'description' }
    let(:user_id) { user.id }
    before { login_as login_user }

    subject do
      Proc.new do
        post user_fragments_url user_id, fragment: { video_id: video.id,
                                                     title: title,
                                                     description: description }
      end
    end

    context 'with correct user' do
      it { is_expected.to change { Fragment.count }.by(1) }
    end

    context 'with wrong user' do
      let(:user_id) { other.id }
      it { is_expected.not_to change { Fragment.count } }
      # it { expect(response).to redirect_to root_url }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.not_to change { Fragment.count } }
      # it { expect(response).to redirect_to login_url }
    end
  end

  describe "#edit" do
    let(:fragment) { create(:fragment, user_id: user.id, video_id: video.id) }
    before do
      login_as login_user
      get edit_user_fragment_path user.id, fragment.id
    end
    subject { response }

    context 'when logged in' do
      it { is_expected.to be_success }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.to redirect_to login_url }
    end
  end

  describe "#update" do
    let(:fragment) { create(:fragment, user_id: user.id, video_id: video.id) }
    let(:title) { 'new' + fragment.title }
    let(:description) { 'new' + fragment.description }
    before do
      login_as login_user
      patch user_fragment_url user.id, fragment.id, fragment: { title: title,
                                                                description: description }
      fragment.reload
    end

    context 'with correct user and info' do
      it { expect(fragment.title).to eq title }
      it { expect(fragment.description).to eq description }
    end

    context 'with wrong user' do
      let(:login_user) { other }
      it { expect(fragment.title).not_to eq title }
      it { expect(fragment.description).not_to eq description }
      it { expect(response).to redirect_to root_url }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { expect(fragment.title).not_to eq title }
      it { expect(fragment.description).not_to eq description }
      it { expect(response).to redirect_to login_url }
    end
  end

  describe "#destroy" do
    let!(:fragment) { create(:fragment, user_id: user.id, video_id: video.id) }
    before { login_as login_user }
    subject { Proc.new { delete user_fragment_url user.id, fragment.id } }

    context 'with correct user' do
      it { is_expected.to change { Fragment.count }.by(-1) }
    end

    context 'with wrong user' do
      let(:login_user) { other }
      it { is_expected.not_to change { Fragment.count } }
      # it { expect(response).to redirect_to root_url }
    end

    context 'when not logged in' do
      let(:login_user) { nil }
      it { is_expected.not_to change { Fragment.count } }
      # it { expect(response).to redirect_to login_url }
    end
  end
end
