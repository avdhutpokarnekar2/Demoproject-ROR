class ProfileController < ApplicationController
  
  def update_profile
    respond_to do |format|
    @user = current_user
      if @user.update( user_params )
        format.html { redirect_to profile_index_path(@user), notice:"User successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def set_user
    @user = current_user
  end

  def user_params
    params.permit( :first_name, :last_name, :mobile_no, :email )
  end
end
