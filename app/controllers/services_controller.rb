class ServicesController < ApplicationController
  def index
    @services_1 = Service.where(number: 1000...1020)
    @services_2 = Service.where(number: 1021...1040)
  end
  def show
    @service = Service.find(params[:id])
  end
end
