module Admin
  class ShopsController < Admin::ApplicationController
    def update
      shop = Shop.find(params[:id])
      shop.update(update_params)
      redirect_to admin_shops_path
    end

    private

    def update_params
      params.require(:shop).permit(:blocked)
    end
  end
end
