class AddPresentsToGuest < ActiveRecord::Migration
  def change
    add_reference :presents, :guest, index: true, foreign_key: true
  end
end
