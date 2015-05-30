class ChangeMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.string :user_id
      t.boolean :subscribed, default: false
      t.boolean :notified, default: false
    end
  end
end
