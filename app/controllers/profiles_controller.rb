class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: %i[show edit]

  def show
    authorize! :show, Profile
  end

  def new
    authorize! :create, Profile
    @profile = Profile.new
  end

  def create
    authorize! :create, Profile
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to root_path, notice: "Profile was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize! :update, Profile
  end
  def update
    @profile = Profile.find(params[:id])
    authorize! :update, Profile
    if @profile.update(profile_params)
      redirect_to root_path, notice: "Profile was successfully updated."
    else
      render :edit
    end
  end


  private
  def set_profile
    @profile = Profile.find_by!(user_id: params[:id])
  end

  def profile_params
    params.expect(profile: [ :name, :bio, :contact_info, :address, :avatar, :resume, :experience, :skill, :myresume ])
  end
end
