class AddIndexToProcedure < ActiveRecord::Migration[5.1]
  def change
    add_index :procedures, :fragment_ids, using: 'gin'
  end
end
