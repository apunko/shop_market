class UserPolicy < ApplicationPolicy
  def admin_panel?
    @user.admin?
  end
end