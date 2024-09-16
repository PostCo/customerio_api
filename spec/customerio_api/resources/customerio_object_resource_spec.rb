# frozen_string_literal: true

RSpec.describe CustomerioAPI::CustomerioObjectResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
  end

  describe '#where(attributes:)' do
    let(:attributes) do
      {
        "object_type_id": '1',
        "filter": {
          "and": [
            {
              "object_attribute": {
                "field": 'name',
                "operator": 'eq',
                "type_id": '1',
                "value": 'PostCo'
              }
            }
          ]
        }
      }
    end
    let(:start) { nil }
    let(:limit) { nil }

    let(:response_body) do
      { identifiers: [{ cio_object_id: 'obd7a90a0102', object_id: 'PostCo' }], ids: ['PostCo'], next: '' }
    end

    before do
      stub_request(:post, "https://api.customer.io/v1/objects?limit=#{limit}&start=#{start}")
        .with(headers: { 'Authorization' => "Bearer #{ENV['CUSTOMERIO_API_KEY']}" }, body: attributes)
        .to_return_json(status: 200, body: response_body, headers: {})
    end

    it do
      objects = subject.where(attributes: attributes)
      expect(objects.identifiers.count).to eq(1)
      expect(objects.identifiers.first.cio_object_id).to eq('obd7a90a0102')
      expect(objects.identifiers.first.object_id).to eq('PostCo')
    end
  end
end
