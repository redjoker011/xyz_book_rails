class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn_thirteen
      t.decimal :price, precision: 8, scale: 2
      t.date :publicated_at
      t.references :publisher, index: true
      t.timestamps
    end
  end
end
