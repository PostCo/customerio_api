# frozen_string_literal: true

require 'faraday'

module CustomerioAPI
  class TrackV1Client
    BASE_URL = 'https://track.customer.io/api/v1/'
    attr_reader :site_id, :track_api_key, :adapter

    def initialize(site_id:, track_api_key:, adapter: Faraday.default_adapter)
      @site_id = site_id
      @track_api_key = track_api_key
      @adapter = adapter
    end

    def customer_event
      CustomerEventResource.new(self)
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: 'application/json'
        conn.adapter adapter
        conn.request :authorization, :basic, site_id, track_api_key
      end
    end
  end
end
