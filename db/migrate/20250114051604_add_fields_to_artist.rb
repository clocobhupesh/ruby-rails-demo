class AddFieldsToArtist < ActiveRecord::Migration[8.0]
  def change
    add_column :artists, :name, :string
    add_column :artists, :bio, :text
  end
end
