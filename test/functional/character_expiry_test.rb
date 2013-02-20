require 'test_helper'

class CharacterExpiryTest < ActionMailer::TestCase
  test "contract_email" do
    mail = CharacterExpiry.contract_email
    assert_equal "Contract email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
