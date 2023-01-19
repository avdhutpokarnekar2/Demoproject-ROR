class ContactsController < ApplicationController
	def index
		@contact = ContactU.new
		@cont = current_user.contact_us.last
	end
	
	def contact_us
			@user = current_user
			@contact=@user.contact_us.new(contact_params)
		if @contact.save
      redirect_to contacts_path, notice: "Your Contact form saved successfully"
      else
       render :contact
     end
	end

	private
		def contact_params
		params.require(:contact_u).permit(:name,:email,:contact_no,:message)
	end

end
