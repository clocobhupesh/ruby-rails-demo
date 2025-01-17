class AddFieldsToSongs < ActiveRecord::Migration[8.0]
  def change
    add_column :songs, :title, :string
    add_column :songs, :duration, :integer
    add_column :songs, :released_at, :datetime
    add_column :songs, :genre, :string
  end
end
