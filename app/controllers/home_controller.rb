class HomeController < ApplicationController
  def index
    # debugger
    # render
  end
  def show
    @user = User.find(params[:id])
  end
end
