class CharacterExpiry < ActionMailer::Base
  default from: "toombyinc@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.character_expiry.contract_email.subject
  #
  def contract_email (character, user)
    @contract = character
    @template = MessageTemplate.first
    mail(:to => character.email, :subject => "SBS Fence Rental Contract Expiring Soon", :from => user.email)
  end
end
