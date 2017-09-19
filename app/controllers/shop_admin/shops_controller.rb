class ShopAdmin::ShopsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shop, only: [:show, :edit, :update]
  before_action :check_shop_existence, only: [:new, :create]

  def show
  end

  def create
  end

  def update
  end

  def edit
  end

  def new
  end

  private

  def check_shop_existence
    redirect_to shop_admin_shop_path(current_user.shop) if current_user.shop
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end
end
