class ArtistService
  def initialize
  end

  def all_artists
    Artist.all
  end

  def find_artist(id)
    Artist.find_by(id: id)
  end

  def create_artist(params)
    Artist.new(params).tap do |artist|
      artist.save!
    end
  end

  def update_artist(artist, params)
    artist.update(params)
    artist
    
  end

  def destroy_artist(artist)
    artist.destroy
  end
end
