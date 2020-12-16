class CreateEmoneys < ActiveRecord::Migration[6.0]
  def change
    create_table :emoneys do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.string :image, null: false
      t.string :link
      t.text :description, null: false

      t.timestamps
    end
  end
end
