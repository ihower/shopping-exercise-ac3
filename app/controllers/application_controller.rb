class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_cart

  around_action :setup_cart

  protected

  def current_cart
    @cart
  end

  def setup_cart
    if session[:cart]
      @cart = Marshal::load(session[:cart])
    else
      @cart = Cart.new
    end

    yield

    session[:cart] = Marshal::dump(@cart)
  end

end
