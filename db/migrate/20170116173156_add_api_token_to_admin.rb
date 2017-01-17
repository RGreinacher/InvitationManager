class AddAPITokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :API_token, :string
  end
end
