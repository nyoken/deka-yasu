class CreateKeepShops < ActiveRecord::Migration[6.0]
  def change
    create_table :keep_shops do |t|
      t.string :shop_id

      t.timestamps
    end
  end
end
