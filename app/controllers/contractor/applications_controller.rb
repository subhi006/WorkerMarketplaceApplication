class Contractor::ApplicationsController < ApplicationController
  def index
    @applied = Application.all
  end
  def show 
  end
end
