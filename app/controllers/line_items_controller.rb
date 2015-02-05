class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    AddToCartCase.new(current_cart, product).add_to_cart
    redirect_to request.referer, notice: '已加入購物車'
  rescue ActiveRecord::RecordNotFound
    redirect_to request.referer, alert: '找不到該產品'
  end
end
