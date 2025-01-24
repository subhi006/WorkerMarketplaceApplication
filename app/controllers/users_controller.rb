class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        if @user.role == "worker"
           format.html { redirect_to home_path, notice: "worker was successfully created." }
          #  format.json { render :show, status: :created, location: @user }
        else
          format.html { redirect_to home_path, notice: "contractor was successfully created." }
          # format.json { render :show, status: :created, location: @user }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.jso
  def edit
  end

  def update
    debugger
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
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
