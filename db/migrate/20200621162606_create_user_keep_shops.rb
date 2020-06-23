class CreateUserKeepShops < ActiveRecord::Migration[6.0]
  def change
    create_table :user_keep_shops do |t|
      t.references :user, null: false, foreign_key: true
      t.references :keep_shop, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :keep_shop_id], unique: true
    end
  end
end
