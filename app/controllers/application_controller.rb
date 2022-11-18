class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def current_ability
	  @current_ability ||= Ability.new(current_user)
	end
end
