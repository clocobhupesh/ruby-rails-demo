class Api::V1::ArtistsController < ApplicationController
  include Paginatable

  before_action :authenticate
  before_action :authorize_artist

  def initialize
    @artist_service = ArtistService.new
    super()
  end


  # get all artists
  def index
    artists = @artist_service.all_artists
    @artists = paginate(artists)

    render json: @artists,
           each_serializer: ArtistSerializer,
           meta: paginate_meta(@artists),
           adapter: :json,
           status: :ok
  end

  # get artist detail
  def show
    artist = @artist_service.find_artist(params[:id])

    raise ActiveRecord::RecordNotFound if artist.nil?

    render json: artist,
    serializer: ArtistSerializer,
    adapter: :json,
    status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Artist not found",
      message: "The artist you're looking for doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end


  # create artist
  def create
    artist = @artist_service.create_artist(artist_params)

    if artist.errors.any?
      raise ActiveRecord::RecordInvalid.new(artist)

    elsif artist.persisted?
      render json: {
        status: :ok,
        data: ArtistSerializer.new(artist),
        message: "Artist created successfully"
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


  # update artist
  def update
    artist = @artist_service.find_artist(params[:id])

    raise ActiveRecord::RecordNotFound if artist.nil?

    updated_artist = @artist_service.update_artist(artist, artist_params)

    if updated_artist.errors.any?
      raise ActiveRecord::RecordInvalid.new(updated_artist)

    elsif updated_artist.persisted?
      render json: {
        status: :ok,
        data: ArtistSerializer.new(updated_artist),
        message: "Artist updated successfully"
      }

    end

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Artist not found",
      message: "The artist you're updating doesn't exist."
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

  # delete artist
  def destroy
    artist = @artist_service.find_artist(params[:id])

    raise ActiveRecord::RecordNotFound if artist.nil?

    @artist_service.destroy_artist(artist)
    render json: {
      message: "Artist deleted successfully"
    }, status: :no_content

  rescue ActiveRecord::InvalidForeignKey => e
    render json: {
      error: "Deletion failed",
      message: "Cannot delete artist because they have existing songs"
    }, status: :unprocessable_entity

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Artist not found",
      message: "The artist you're updating doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  def authorize_artist
    policy = ArtistPolicy.new(current_user)
    action = action_name
    puts "authorize artist"

    # unless policy.public_send("#{action}?")
    #   render json: { error: "You do not have permission to perform this action" }, status: :forbidden
    # end
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :bio, :genre)
  end
end
