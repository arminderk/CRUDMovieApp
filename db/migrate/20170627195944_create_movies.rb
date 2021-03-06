class CreateMovies < ActiveRecord::Migration[5.1]
  def up
    create_table :movies do |t|
      t.string "name"
      t.string "rated"
      t.integer "year"
      t.string "director"
      t.string "genre"
      t.string "description", :limit => 200
      t.string "image"

      t.timestamps
    end
  end
  
  def down
    drop_table :movies
  end
end
