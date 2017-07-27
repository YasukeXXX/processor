class CreateProcedures < ActiveRecord::Migration[5.1]
  def change
    create_table :procedures do |t|
      t.integer :user_id
      t.integer :fragment_ids, array: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
