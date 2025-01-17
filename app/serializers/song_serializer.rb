class SongSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :title, :duration, :released_at, :genre
end
