class UsersController < ApplicationController
  def profile
    @user = User.find(params[:id])
    # Additional logic for the profile action
  end

  def update
    if current_user.update(user_params)
      redirect_to profile_user_path(current_user), notice: "Profile updated successfully."
    else
      render :profile
    end
  end

  private

  def user_params
    params.require(:user).permit(:avatar, :full_name, :email, :phone, :website, :street, :city, :province, :postal_code)
  end
end
