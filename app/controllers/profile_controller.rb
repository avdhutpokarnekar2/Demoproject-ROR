class ProfileController < ApplicationController
  
  def update_profile
    @user = current_user
    if @user.update( user_params )
      redirect_to profile_index_path(@user), notice: "User successfully updated." 
    else
      redirect_to profile_index_path(@user.errors), alert: @user.errors.full_messages
    end
  end

private

  def user_params
    params.permit( :first_name, :last_name, :mobile_no, :email )
  end

end
