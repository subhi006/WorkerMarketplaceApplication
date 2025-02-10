class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update ]
  # before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /users or /users.json
  # def index
  #   @users = User.all
  # end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    puts "******************** NEW USER ****************************"
    puts user_params
    if @user.save
      puts "Sending email for create user"
      UserMailer.send_new_user_message(@user).deliver
      redirect_to @user, notice: "User was successfully created."
    else
      render action: "new"
    end
  end

  # DELETE /users/1 or /users/1.json
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :email, :password, :first_name, :last_name, :phone_number, :role ])
    end
end
