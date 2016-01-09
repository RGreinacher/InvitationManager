class AddNoticeToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :notice, :text
  end
end
