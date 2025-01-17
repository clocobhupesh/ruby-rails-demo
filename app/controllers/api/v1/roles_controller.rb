class Api::V1::RolesController < ApplicationController
  include Paginatable

  before_action :authenticate
  before_action :authorize_role

  def initialize
    @role_service = RoleService.new
    super()
  end

    def index
      roles = @role_service.all_roles
      @roles = paginate(roles)

      render json: @roles,
             each_serializer: RoleSerializer,
             meta: paginate_meta(@roles),
             adapter: :json,
             status: :ok
    end

  def show
    role = @role_service.find_role(params[:id])
    raise ActiveRecord::RecordNotFound if role.nil?

    render json: role,
    serializer: RoleSerializer,
    adapter: :json,
    status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Role not found",
      message: "The role you're looking for doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end

  # create role
  def create
    role = @role_service.create_role(role_params)

    if role.errors.any?
      raise ActiveRecord::RecordInvalid.new(role)

    elsif role.persisted?
      render json: {
        status: :ok,
        data: RoleSerializer.new(role),
        message: "Role created successfully"
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


  def update
    role = @role_service.find_role(params[:id])
    raise ActiveRecord::RecordNotFound if role.nil?
    updated_role = @role_service.update_role(role, role_params)

    if updated_role.errors.any?
      raise ActiveRecord::RecordInvalid.new(updated_role)

    elsif updated_role.persisted?
      render json: {
        status: :ok,
        data: RoleSerializer.new(updated_role),
        message: "Role updated successfully"
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

  # delete role
  def destroy
    role = Role.find_by(id: params[:id])
    raise ActiveRecord::RecordNotFound if role.nil?
    @role_service.destroy_role(role)

    render json: {
      message: "Role deleted successfully"
    }, status: :no_content

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Role not found",
      message: "The role you're updating doesn't exist."
    }, status: :not_found

  rescue StandardError
    render json: {
      error: "Internal server error",
      message: "Something went wrong. Please try again later."
    }, status: :internal_server_error
  end


  def authorize_role
    policy = RolePolicy.new(current_user)
    action = action_name

    unless policy.public_send("#{action}?")
      render json: { error: "You do not have permission to perform this action" }, status: :forbidden
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :description)
  end
end
