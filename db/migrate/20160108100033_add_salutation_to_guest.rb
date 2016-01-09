class AddSalutationToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :salutation, :string
  end
end
