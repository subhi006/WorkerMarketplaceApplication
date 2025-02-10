require "twilio-ruby"

class TwilioClient
    attr_reader :client
    def initialize
            @client = Twilio::REST::Client.new "AC880628ac290278ba72c063ac93deaf33", "e6606410dde3186a0b31dcc9ed133aeb"
    end

    def send_text(user, message)
            @client.api.account.messages.create(
              from: +18457140730,
               to: user.phone_number,
               body: message
            )
    end
  # private
  # def account_sid
  #       Rails.application.initializers.twilio[:account_sid]
  # end
  # def account_token
  #       Rails.application.credentials.twilio[:account_token]
  # end
  # def phone_number
  #   Rails.application.credentials.twilio[:phone_number]
  # end
end
