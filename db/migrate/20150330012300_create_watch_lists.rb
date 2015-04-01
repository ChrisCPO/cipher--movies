class CreateWatchLists < ActiveRecord::Migration
  def change
    create_table :watch_lists do |t|
      t.references :movie
      t.references :user

      t.timestamps
    end
  end
end
