class Sms
  def initialize(sms_client, sms_sid, sms_token, sms_number)
    @account_sid = sms_sid
    @auth_token = sms_token
    @from_number = sms_number
    @client = sms_client.new(@account_sid, @auth_token)
  end

  def send(message, client)
    begin
    @client.messages.create(
      from: @from_number,
      to: client,
      body: message
    )
    rescue => e
      puts 'test'
      e
    end
  end
end
