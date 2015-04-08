class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user
      t.string :title, null: :false
      t.boolean :found, default: :false

      t.timestamps
    end
  end
end
