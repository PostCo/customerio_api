# frozen_string_literal: true

RSpec.describe CustomerioAPI::V2Client do
  subject do
    CustomerioAPI::V2Client.new(site_id: ENV['SITE_ID'], track_api_key: ENV['TRACK_API_KEY'])
  end

  it 'uses correct base url' do
    expect(CustomerioAPI::V2Client::BASE_URL).to eq('https://track.customer.io/api/v2/')
  end

  context '#track' do
    it { expect(subject.track).to be_a(CustomerioAPI::TrackResource) }
  end

  context '#connection' do
    it do
      connection = subject.connection
      expect(connection.builder.adapter).to eq(Faraday::Adapter::NetHttp)
      expect(connection.builder.handlers).to include(
        Faraday::Request::Json,
        Faraday::Response::Json,
        Faraday::Request::Authorization
      )
    end
  end
end
