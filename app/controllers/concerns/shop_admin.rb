module ShopAdmin
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :set_shop
    before_action :verify_shop_owner

    layout "shop_admin"
  end

  def set_shop
    @shop = Shop.find(params[:shop_id])
  end

  def verify_shop_owner
    authorize @shop, :user_owner?
  end
end