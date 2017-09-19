class ShopAdmin::ShopsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_shop_existence, only: [:new, :create]
  before_action :set_shop, only: [:show, :edit, :update]

  def show
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user = current_user

    if @shop.save
      redirect_to shop_admin_shop_path(@shop), notice: 'Shop was successfully created'
    else
      render action: :new
    end
  end

  def update
    if @shop.update(shop_params)
      redirect_to shop_admin_shop_path(@shop), notice: 'Shop was successfully updated'
    else
      render action: :edit
    end
  end

  def edit
  end

  def new
    @shop = Shop.new
  end

  private

  def check_shop_existence
    redirect_to shop_admin_shop_path(current_user.shop) if current_user.shop
  end

  def set_shop
    @shop = Shop.find(params[:id])
  end

  def shop_params
    params.require(:shop).permit(:title, :description)
  end
end
