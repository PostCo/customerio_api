# frozen_string_literal: true

module CustomerioAPI
  class CustomerioObjectResource < Resource
    # attributes = {
    #   "object_type_id": '1',
    #   "filter": {
    #     "and": [
    #       {
    #         "object_attribute": {
    #           "field": 'name',
    #           "operator": 'eq',
    #           "type_id": '1',
    #           "value": 'PostCo'
    #         }
    #       }
    #     ]
    #   }
    # }
    # client.object.where(attributes: attributes)

    # Response:
    # #<CustomerioAPI::CustomerioObject identifiers=[#<OpenStruct cio_object_id="obd7a90a0102", object_id="PostCo">], ids=["PostCo"], next="">

    def where(attributes:, start: nil, limit: nil)
      response_body = post_request("objects?start=#{start}&limit=#{limit}", body: attributes).body
      CustomerioObject.new(response_body)
    end
  end
end
