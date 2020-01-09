require 'sms_sender'

describe Sms do

  let(:sms_messages){double :sms_messages, :create => 'test'}
  let(:sms_client_instance){double :sms_client_instance, :messages => sms_messages}
  let(:sms_client){double :sms_client, :new => sms_client_instance}

  account_id = 'test'
  account_token = 'test'
  from_number = '+15005550006'
  to_number = '+15005550000'
  message = 'message'

  subject{Sms.new(sms_client, account_id, account_token, from_number)}

  describe '#send' do
    it 'sends sms' do
      expect(sms_messages).to receive(:create)
      subject.send(message, to_number)
    end
    it 'rescues from error' do
      error = StandardError.new('error message')
      allow(sms_messages).to receive(:create).and_raise(error)
      expect(subject.send(message, to_number)).to eq error
    end
  end
end
