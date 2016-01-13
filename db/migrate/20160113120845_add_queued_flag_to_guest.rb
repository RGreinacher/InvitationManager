class AddQueuedFlagToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :queued, :boolean
  end
end
