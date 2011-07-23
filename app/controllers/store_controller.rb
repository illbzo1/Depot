class StoreController < ApplicationController
  skip_before_filter :authorize
  
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      @products = Product.all
      @cart = current_cart
      @count = increment_count
    end
  end
  
  def increment_count
    session[:counter] = 0 if session[:counter].nil?
    session[:counter] += 1
    @counter = session[:counter] if session[:counter] > 5
  end

end
