class Mailchimp
  def self.execute(email:)
    mailchimp = MailchimpMarketing::Client.new
    mailchimp.set_config({:api_key => "bb7c4fc91c190c3c0285b16bbfa69a9c",
                          :server => "us21"
                        })
    list_id = "2f712a62e2"
    response = mailchimp.lists.add_list_member list_id,
                { email_address: email,
                  status: "subscribed"
                }
  end
end
