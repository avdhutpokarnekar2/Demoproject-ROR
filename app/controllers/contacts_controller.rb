class ContactsController < ApplicationController
  def index
    @contact = ContactU.new
    @cont = current_user.contact_us.last
  end
  
  #create the contact form
  def create
    @contact = current_user.contact_us.new(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: "Contact form saved successfully"
    else
      redirect_to :contacts_path, notice: "Contact form not saved"
    end
  end

private
  def contact_params
    params.require(:contact_u).permit(:name,:email,:contact_no,:message)
  end
end
