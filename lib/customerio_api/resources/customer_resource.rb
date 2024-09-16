# frozen_string_literal: true

module CustomerioAPI
  class CustomerResource < Resource
    # client.customer.where(email: "andy@postco.io")
    # Response:
    # [#<CustomerioAPI::Customer email="andy@postco.io", id="test1", cio_id="d7a90a000102">]

    def where(email:)
      response_body = get_request('customers', params: { email: email }).body
      response_body['results'].map { |customers| Customer.new(customers) }
    end
  end
end
