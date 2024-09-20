# frozen_string_literal: true

RSpec.describe CustomerioAPI::CustomerEventResource do
  subject { described_class.new(client) }

  let!(:client) do
    CustomerioAPI::TrackV1Client.new(site_id: ENV['SITE_ID'], track_api_key: ENV['TRACK_API_KEY'])
  end

  describe '#create' do
    let(:identifier) { 'test@example.com' }
    let(:attributes) do
      {
        name: 'event_a',
        data: { 'key' => 'value' }
      }
    end
    let(:response_body) { '' } # CustomerEvent API returns an empty response on success

    before do
      stub_request(:post, "https://customer.io/api/v1/customers/#{identifier}/events")
        .with(
          headers: {
            'Authorization' => "Basic #{Base64.strict_encode64("#{ENV['SITE_ID']}:#{ENV['TRACK_API_KEY']}")}"
          },
          body: attributes
        )
        .to_return(status: 200, body: response_body, headers: {})
    end

    it 'creates a customer event and returns a success Faraday response' do
      result = subject.create(identifier: identifier, attributes: attributes)
      expect(result).to be_a(Faraday::Response)
      expect(result.success?).to be true
      expect(result.status).to eq(200)
      expect(result.body).to eq('')
    end

    context 'when using a numeric identifier' do
      let(:identifier) { 12_345 }

      it 'creates a customer event with a numeric identifier' do
        result = subject.create(identifier: identifier, attributes: attributes)
        expect(result).to be_a(Faraday::Response)
        expect(result.success?).to be true
      end
    end

    context 'when using a cio_id as identifier' do
      let(:identifier) { 'd7a90a000102' }

      it 'creates a customer event with a cio_id identifier' do
        result = subject.create(identifier: identifier, attributes: attributes)
        expect(result).to be_a(Faraday::Response)
        expect(result.success?).to be true
      end
    end
  end
end
