class UserSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :username, :firstname, :lastname, :email
end
