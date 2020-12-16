class AddCategoryIdToEmoneys < ActiveRecord::Migration[6.0]
  def change
    add_reference :emoneys, :category, foreign_key: true
  end
end
