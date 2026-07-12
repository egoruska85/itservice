class ServicesController < ApplicationController
  def index
    @services = Service.all
    #@services_2 = Service.where(number: 1021...1040)
  end
  def show
    @service = Service.find(params[:id])
  end
end
