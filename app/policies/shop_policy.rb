class ShopPolicy < ApplicationPolicy
  def new?
    !@user.shop
  end

  def create? 
    !@user.shop
  end
end