class OrdersController < ApplicationController
  before_action :authenticate_user!
  def new
    @services = Service.all
  end
  def show
    @order = Order.find(params[:id])
    if current_user == nil or @order.user_id != current_user.id
      redirect_to root_path
    end
  end
  def create

    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @order.save
    flash[:alert] = "User not found."
    redirect_to @order
  end
  private
  def order_params
    params.require(:order).permit(:user_id, :service_id, :phone, :date, :time, :verificate, :done, :defect, :address, :images => [])
  end
end
