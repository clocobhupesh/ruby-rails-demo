
class RolePolicy < ApplicationPolicy
  include Constants

  def resource_name
    Constants::ROLE_RESOURCE
  end

  def index?
    has_permission?(Constants::ACTION_VIEW)
  end

  def show?
    has_permission?(Constants::ACTION_VIEW)
  end

  def create?
    has_permission?(Constants::ACTION_CREATE)
  end

  def update?
    has_permission?(Constants::ACTION_UPDATE)
  end

  def destroy?
    has_permission?(Constants::ACTION_DELETE)
  end
end
