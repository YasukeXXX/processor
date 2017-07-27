class CreateAccountActivations < ActiveRecord::Migration[5.1]
  def change
    create_table :account_activations do |t|
      t.belongs_to :user, index: true
      t.boolean :activated, default: false
      t.datetime :activated_at

      t.timestamps
    end
  end
end
