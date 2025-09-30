class MainController < ApplicationController
  def index
    @about = About.last
  end
end
