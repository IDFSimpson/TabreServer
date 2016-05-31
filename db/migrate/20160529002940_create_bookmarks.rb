class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :name
      t.string :scraped_content

      t.timestamps null: false
    end
  end
end
