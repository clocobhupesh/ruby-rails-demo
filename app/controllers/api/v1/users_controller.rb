class Api::V1::UsersController < ApplicationController
  include Paginatable

  before_action :authenticate
  before_action :authorize_user

  def initialize
    @user_service = UserService.new
    super()
  end


  def index
    users = @user_service.all_users
    @users = paginate(users)

    render json: @users,
           each_serializer: UserSerializer,
           meta: paginate_meta(@users),
           adapter: :json,
           status: :ok
  end

  def show
    user = @user_service.find_user(params[:id])

    raise ActiveRecord::RecordNotFound if user.nil?

    render json: user,
    serializer: UserSerializer,
    adapter: :json,
    status: :ok


  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "User not found",
      message: "The user you're looking for doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  # create user
  def create
    user = @user_service.create_user(user_params)
    if user.errors.any?
      raise ActiveRecord::RecordInvalid.new(user)

    elsif user.persisted?
      render json: {
        status: :ok,
        data: UserSerializer.new(user),
        message: "User created successfully"
      }
    end


  rescue ActiveRecord::RecordInvalid=> e
    render json: {
      error: "Validation failed",
      message: "Please check the provided data.",
      details: e.record.errors.full_messages
    }, status: :unprocessable_entity

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  # update user
  def update
    user = @user_service.find_user(params[:id])

    raise ActiveRecord::RecordNotFound if user.nil?

    updated_user = @user_service.update_user(user, user_update_params)

    if updated_user.errors.any?
      raise ActiveRecord::RecordInvalid.new(updated_user)

    elsif updated_user.persisted?
        render json: {
          status: :ok,
          data: UserSerializer.new(updated_user),
          message: "User updated successfully"
        }
    end

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "User not found",
      message: "The user you're updating doesn't exist."
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



  def destroy
    user = @user_service.find_user(params[:id])

    raise ActiveRecord::RecordNotFound if user.nil?

    @user_service.destroy_user(user)
    render json: {
      message: "User deleted successfully"
    }, status: :no_content

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "User not found",
      message: "The user you're updating doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  def authorize_user
    policy = UserPolicy.new(current_user)
    action = action_name

    unless policy.public_send("#{action}?")
      render json: { error: "You do not have permission to perform this action" }, status: :forbidden
    end
  end

  private

  def user_params
    params.permit(:username, :email, :firstname, :lastname, :password, :refresh_token)
  end

  def user_update_params
    params.permit(:username, :email, :firstname, :lastname)
  end
end
