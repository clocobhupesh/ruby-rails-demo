class Api::V1::SongsController < ApplicationController
  include Paginatable

  before_action :authenticate
  before_action :authorize_song

  def initialize
    @song_service = SongService.new
    super()
  end

  def index
    songs = @song_service.all_songs
    @songs = paginate(songs)

    render json: @songs,
           each_serializer: SongSerializer,
           meta: paginate_meta(@songs),
           adapter: :json,
           status: :ok
  end

  # get song detail
  def show
    song = @song_service.find_song(params[:id])

    raise ActiveRecord::RecordNotFound if song.nil?

    render json: song,
    serializer: SongSerializer,
    adapter: :json,
    status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Song not found",
      message: "The song you're looking for doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  # create song
  def create
    song = @song_service.create_song(song_params)

    if song.errors.any?
      raise ActiveRecord::RecordInvalid.new(song)
    elsif song.persisted?
      render json: {
        status: :ok,
        data: SongSerializer.new(song),
        message: "Song created successfully"
      }
    end

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      error: "Validation failed",
      message: "Please check the provided data.",
      details: e.record.errors.full_messages
    }, status: :unprocessable_entity

  rescue StandardError => e
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end


  # update song
  def update
    song = @song_service.find_song(params[:id])
    raise ActiveRecord::RecordNotFound if song.nil?
    updated_song = @song_service.update_song(song, song_params)

    if updated_song.errors.any?
      raise ActiveRecord::RecordInvalid.new(updated_song)

    elsif updated_song.persisted?
      render json: {
        status: :ok,
        data: SongSerializer.new(updated_song),
        message: "Song updated successfully"
      }

    end

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Song not found",
      message: "The song you're updating doesn't exist."
    }, status: :not_found

  rescue ActiveRecord::RecordInvalid => e
    render json: {
      error: "Validation failed",
      message: "Please check the provided data.",
      details: e.record.errors.full_messages
    }, status: :unprocessable_entity

  rescue StandardError => e
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  # delete song
  def destroy
    song = @song_service.find_song(params[:id])

    raise ActiveRecord::RecordNotFound if song.nil?

    @song_service.destroy_song(song)
    render json: {
      message: "Song deleted successfully"
    }, status: :no_content

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Song not found",
      message: "The song you're updating doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  def authorize_song
    policy = SongPolicy.new(current_user)
    action = action_name

    unless policy.public_send("#{action}?")
      render json: { error: "You do not have permission to perform this action" }, status: :forbidden
    end
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_id, :album_id, :genre, :duration, :release_date)
  end
end
