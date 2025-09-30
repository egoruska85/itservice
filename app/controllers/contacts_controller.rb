class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    @contact.sender = 'egoruska85@mail.ru'
    @contact.request = request

    if @contact.deliver
      flash.now[:error] = nil
      redirect_to request.referrer, info: "Отправлено"
    else
      flash.now[:error] != nil


      redirect_to request.referrer, info: "Не отправлено"
    end
  end
end
