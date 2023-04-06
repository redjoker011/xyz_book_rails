class AddIndexForBookIsbn < ActiveRecord::Migration[5.2]
  def change
    add_index :books, :isbn_thirteen, unique: true
  end
end
