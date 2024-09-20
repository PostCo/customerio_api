# frozen_string_literal: true

module CustomerioAPI
  class CustomerEventResource < Resource
    # client.customer_event.create(identifier: id | email | cio_id, attributes: {name: "event_a", data: {"key": "value"}})
    def create(identifier:, attributes:)
      post_request("customers/#{identifier}/events", body: attributes)
    end
  end
end
