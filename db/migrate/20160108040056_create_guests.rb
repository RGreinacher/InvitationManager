class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.integer :participating
      t.integer :companions
      t.integer :emails_sent

      t.timestamps null: false
    end
  end
end
