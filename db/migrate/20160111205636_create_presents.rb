class CreatePresents < ActiveRecord::Migration
  def change
    create_table :presents do |t|
      t.string :description

      t.timestamps null: false
    end
  end
end
