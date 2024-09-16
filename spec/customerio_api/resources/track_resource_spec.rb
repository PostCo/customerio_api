# frozen_string_literal: true

RSpec.describe CustomerioAPI::TrackResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::V2Client.new(site_id: ENV['SITE_ID'], track_api_key: ENV['TRACK_API_KEY'])
  end

  describe 'entity(attributes)' do
    before do
      stub_request(:post, 'https://track.customer.io/api/v2/entity')
        .with(body: attributes, basic_auth: [ENV['SITE_ID'], ENV['TRACK_API_KEY']])
        .to_return_json(status: status_code, body: response_body)
    end

    context 'when sucessfully create a person' do
      let(:attributes) do
        { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'linh-us' },
          attributes: { name: 'linh-us' } }
      end
      let(:response_body) { {} }
      let(:status_code) { 200 }

      it do
        result = subject.entity(attributes)
        expect(result).to eq({})
      end
    end

    context 'when failed to create a person' do
      let(:attributes) do
        { type: 'object', identifiers: { object_type_id: '1', object_id: 'linh-us' }, attributes: { name: 'linh-us' } }
      end
      let(:response_body) do
        { 'errors': [{ 'reason': 'required', 'field': 'action',
                       'message': 'must be one of add_relationships, delete, delete_relationships, identify or identify_anonymous' }] }
      end
      let(:status_code) { 400 }

      it do
        expect { subject.entity(attributes) }.to raise_error(CustomerioAPI::Error)
      end
    end
  end

  describe 'batch(attributes)' do
    before do
      stub_request(:post, 'https://track.customer.io/api/v2/batch')
        .with(body: { batch: attributes }, basic_auth: [ENV['SITE_ID'], ENV['TRACK_API_KEY']])
        .to_return_json(status: status_code, body: response_body)
    end

    context 'when sucessfully batch update' do
      let(:attributes) do
        [
          { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'linh-us' },
            attributes: { name: 'linh-us' } },
          { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'PostCo' },
            attributes: { name: 'PostCo' } }
        ]
      end
      let(:response_body) { {} }
      let(:status_code) { 200 }

      it do
        result = subject.batch(attributes)
        expect(result).to eq({})
      end
    end

    context 'when failed to batch update' do
      let(:attributes) do
        { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'PostCo' },
          attributes: { name: 'PostCo' } }
      end
      let(:response_body) do
        { 'errors': [{ "reason": 'invalid', "field": 'body', "message": 'must be valid JSON' }] }
      end
      let(:status_code) { 400 }

      it do
        expect { subject.batch(attributes) }.to raise_error(CustomerioAPI::Error)
      end
    end
  end
end
