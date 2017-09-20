# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    include Pundit
    
    before_action :authenticate_user!
    before_action :authenticate_admin

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def authenticate_admin
      authorize current_user, :admin_panel?
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    end
  end
end
