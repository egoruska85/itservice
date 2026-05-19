class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    @contact.sender = 'egoruska85@mail.ru'
    @contact.subject = "Новое сообщение с сайта INTEK"
    @contact.request = request

    if @contact.deliver
      redirect_to root_path, notice: "Сообшение отправлено"
    else
      redirect_to root_path, alert: "Сообщение не отправлено"
    end
  end
end
