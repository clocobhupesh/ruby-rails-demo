class SongService
  def initialize
  end

  def all_songs
    Song.all
  end

  def find_song(id)
    Song.find_by(id: id)
  end

  def create_song(params)
    Song.new(params).tap do |song|
      song.save!
    end
  end

  def update_song(song, params)
    song.update(params)
    song
  end

  def destroy_song(song)
    song.destroy
  end
end
