class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit]

  def show
    # Display user profile
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      redirect_to root_path, notice: "Profile was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to root_path, notice: "Profile was successfully updated."
    else
      render :edit
    end
  end
  def pdf
    pdf_filename = File.join(Rails.root, "tmp/my_document.pdf")
    send_file(pdf_filename, filename: "your_document.pdf", type: "application/pdf")
  end

  private

  def set_profile
    @profile = Profile.find_by!(user_id: params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :bio, :contact_info, :address, :avatar, :resume, :experience, :skill)
  end
end
