# frozen_string_literal: true

RSpec.describe CustomerioAPI::ObjectRelationshipResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::V1Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
  end

  describe '#where(object_type_id:, object_id:, query_params: {})' do
    let(:object_type_id) { 1 }
    let(:object_id) { 'PostCo' }

    let(:response_body) do
      {
        'cio_relationships' =>
        [{
          'object_type_id' => '0',
          'identifiers' => { 'cio_id' => 'd7a90a000102', 'email' => 'andy@postco.io', 'id' => 'test1' },
          'attributes' => {}, 'timestamps' => {}
        }],
        'next' => ''
      }
    end

    before do
      stub_request(:get, "https://api.customer.io/v1/objects/#{object_type_id}/#{object_id}/relationships")
        .with(headers: { 'Authorization' => "Bearer #{ENV['CUSTOMERIO_API_KEY']}" })
        .to_return_json(status: 200, body: response_body)
    end

    it 'returns list object relationships associated with the object' do
      relationships = subject.where(object_type_id: object_type_id, object_id: object_id)
      expect(relationships.cio_relationships.count).to eq(1)
    end
  end
end
