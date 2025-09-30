class MainController < ApplicationController
  def index
    @contact = Contact.new
    @about = About.last
  end
end
