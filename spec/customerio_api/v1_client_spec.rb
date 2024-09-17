# frozen_string_literal: true

RSpec.describe CustomerioAPI::V1Client do
  subject do
    CustomerioAPI::V1Client.new(api_key: ENV['CUSTOMERIO_API_KEY'])
  end

  it 'uses correct base url' do
    expect(CustomerioAPI::V1Client::BASE_URL).to eq('https://api.customer.io/v1/')
  end

  context '#customer' do
    it { expect(subject.customer).to be_a(CustomerioAPI::CustomerResource) }
  end

  context '#object' do
    it { expect(subject.object).to be_a(CustomerioAPI::CustomerioObjectResource) }
  end

  context '#object_relationship' do
    it { expect(subject.object_relationship).to be_a(CustomerioAPI::ObjectRelationshipResource) }
  end

  context '#connection' do
    it do
      connection = subject.connection
      expect(connection.builder.adapter).to eq(Faraday::Adapter::NetHttp)
      expect(connection.builder.handlers).to include(
        Faraday::Request::Json,
        Faraday::Response::Json
      )
    end
  end
end
