# frozen_string_literal: true

require 'faraday'

module CustomerioAPI
  class V1Client
    BASE_URL = 'https://api.customer.io/v1/'
    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def customer
      CustomerResource.new(self)
    end

    def object
      CustomerioObjectResource.new(self)
    end

    def object_relationship
      ObjectRelationshipResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
        conn.headers['Authorization'] = "Bearer #{api_key}"
      end
    end
  end
end
