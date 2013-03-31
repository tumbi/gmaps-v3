class CharacterExpiry < ActionMailer::Base
  default from: "toombyinc@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.character_expiry.contract_email.subject
  
  def contract_email (character, user, template)
    @character = character
    @template = template
    @body = @template.body.gsub("&nbsp;","")
    @body = eval(@body)
    mail(:to => character.email, :subject => "SBS Fence Rental Contract Expiring Soon", :from => user.email,:body => @body, :content => "text/html")
  end

  def send_user_information(user)
    @user = user
    mail(:to => @user.email, :subject => "new user created")
  end



end