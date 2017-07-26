class CreateFragments < ActiveRecord::Migration[5.1]
  def change
    create_table :fragments do |t|
      t.integer :user_id
      t.integer :video_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
