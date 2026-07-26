class MainController < ApplicationController
  def index
    @services = Service.all
    @contact = Contact.new
    @about = About.last
  end
end
