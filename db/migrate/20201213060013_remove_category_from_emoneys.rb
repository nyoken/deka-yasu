class RemoveCategoryFromEmoneys < ActiveRecord::Migration[6.0]
  def change
    remove_column :emoneys, :category, :string
  end
end
