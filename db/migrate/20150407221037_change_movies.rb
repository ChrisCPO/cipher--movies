class ChangeMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.string :user_id
    end
  end
end
