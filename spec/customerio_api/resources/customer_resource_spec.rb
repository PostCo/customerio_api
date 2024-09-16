# frozen_string_literal: true

RSpec.describe CustomerioAPI::CustomerResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
  end

  describe '#where(email:)' do
    let(:email) { 'test@example.com' }
    let(:response_body) do
      { "results": [{ email: email, id: 'test1', cio_id: 'd7a90a000102' }] }
    end

    before do
      stub_request(:get, 'https://api.customer.io/v1/customers?email=test@example.com')
        .with(headers: { 'Authorization' => "Bearer #{ENV['CUSTOMERIO_API_KEY']}" })
        .to_return_json(status: 200, body: response_body, headers: {})
    end

    it do
      customers = subject.where(email: email)
      expect(customers.first.email).to eq(email)
    end
  end
end
