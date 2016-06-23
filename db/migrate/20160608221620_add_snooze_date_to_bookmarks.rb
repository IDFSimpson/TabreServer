class AddSnoozeDateToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :snooze_until, :date
  end
end
