class ContactU < ApplicationRecord
  validates_presence_of :name, :message, :email
  validates :contact_no, presence: true, numericality: true, length: { minimum: 10, maximum: 12 }
  belongs_to :user
  after_save :contact_mail
  after_update :contact_update_mail
  def contact_mail
    UserMailer.contact_mail(self).deliver
  end

  def contact_update_mail
    UserMailer.contact_update_mail(self).deliver
  end
end
