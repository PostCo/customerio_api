# frozen_string_literal: true

RSpec.describe CustomerioAPI::CustomerResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::V1Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
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

  describe '#search(attributes:)' do
    let(:attributes) do
      {
        "filter": {
          "and": [
            {
              "attribute": {
                "field": 'cio_id',
                "operator": 'eq',
                "value": 'd7a90a00002'
              }
            }
          ]
        }
      }
    end
    let(:response_body) do
      { identifiers: [{ cio_id: 'd7a90a00002', id: nil, email: 'test@example.con' }], ids: [''], next: '' }
    end

    before do
      stub_request(:post, 'https://api.customer.io/v1/customers?limit=&start')
        .with(headers: { 'Authorization' => "Bearer #{ENV['CUSTOMERIO_API_KEY']}" }, body: attributes).to_return_json(status: 200, body: response_body, headers: {})
    end

    it do
      result = subject.search(attributes: attributes)
      expect(result.identifiers.first.cio_id).to eq('d7a90a00002')
    end
  end
end
