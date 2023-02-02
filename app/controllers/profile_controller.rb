class ProfileController < ApplicationController
		before_action :set_user, only: %i[ show edit update destroy ]

	def index
	end
	def create
	    respond_to do |format|
	    @user = User.all
	      if @user.update(user_params)
	        format.html { redirect_to shop_account_url(@user), notice: "user was successfully updated." }
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
  		params.permit(:first_name,:last_name,:mobile_no,:email)
  	end
end
