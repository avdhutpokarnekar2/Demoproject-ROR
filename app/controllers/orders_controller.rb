class OrdersController < ApplicationController
  def index
    @orders = current_user.user_orders.all
  end

  # track order
  def show; end

  def track
    order = current_user.user_orders.all
    id = params[:user_order_id].to_i if params[:user_order_id].present?
    if order.ids.include?(id)
      user_order = UserOrder.find_by(id: id)
      @user_order = user_order.status
      render :show
    elsif id != 0 && order.ids.include?(id) == false
      flash[:alert] = 'Please enter correct order id'
      render :show
    end
  end
end
