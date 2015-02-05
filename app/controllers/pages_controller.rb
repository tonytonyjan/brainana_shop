class PagesController < ApplicationController
  def index
    @products = Product.all
  end
end
