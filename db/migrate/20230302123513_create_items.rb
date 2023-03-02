class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :url
      t.integer :staus
      t.integer :after_buy_status
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
