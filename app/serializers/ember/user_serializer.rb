class Ember::UserSerializer < ActiveModel::Serializer
  attributes :id, :name,  :email, :mobile, :franchise_id, :is_franchise_administrator, :is_franchise_administrator_or_super_user, :user_roles, :user_role


  def user_roles
    res = ['franchise','manager']
  end

  def is_franchise_administrator
    return @object.user_role == 'franchise_administrator'
  end

  def is_franchise_administrator_or_super_user
    return @object.user_role == 'franchise_administrator' ||  @object.user_role == 'super_user'
  end

end
