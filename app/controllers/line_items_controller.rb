class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    AddToCartCase.new(current_cart, product).add_to_cart
    redirect_to request.referer, notice: '已加入購物車'
  rescue ActiveRecord::RecordNotFound
    redirect_to request.referer, alert: '找不到該產品'
  end

  def destroy
    current_cart.line_items.find(params[:id]).destroy
    redirect_to cart_path
  rescue ActiveRecord::RecordNotFound
    redirect_to request.referer, alert: '購物車內找不到該產品'
  end
end
