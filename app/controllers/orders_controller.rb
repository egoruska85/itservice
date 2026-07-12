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
    order_deliver_to_mail(@order.defect, @order.phone, @order)
    @order.save

  end
  private

  def order_deliver_to_mail(message, phone, order)
    @contact = Contact.new(params[:contact])
    @contact.sender = 'egoruska85@mail.ru'
    @contact.subject = "Новая заявка с сайта Intek"
    @contact.email = current_user.email
    @contact.name = current_user.username
    @contact.message = message
    @contact.phone = phone
    @contact.request = request

    if @contact.deliver
      redirect_to order, notice: "Сообшение отправлено"
    else
      redirect_to order, alert: "Сообщение не отправлено"
    end
  end

  def order_params
    params.require(:order).permit(:user_id, :service_id, :phone, :date, :time, :verificate, :done, :defect, :address, :images => [])
  end
end
