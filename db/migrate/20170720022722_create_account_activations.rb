class CreateAccountActivations < ActiveRecord::Migration[5.1]
  def change
    create_table :account_activations do |t|
      t.integer :user_id
      t.boolean :activated
      t.datetime :activated_at

      t.timestamps
    end
  end
end
