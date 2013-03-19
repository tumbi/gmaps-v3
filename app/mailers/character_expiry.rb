class CharacterExpiry < ActionMailer::Base
  default from: "toombyinc@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.character_expiry.contract_email.subject
  
  def contract_email (character, user)
    @character = character
    @template = MessageTemplate.last
    @body = @template.body
    mail(:to => character.email, :subject => "SBS Fence Rental Contract Expiring Soon", :from => user.email,:body => @body, :content => "text/html")
  end

end