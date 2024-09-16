# frozen_string_literal: true

module CustomerioAPI
  class ObjectRelationshipResource < Resource
    # query_params = {start: string, limit: integer, id_type: "object_id" | "cio_object_id"}
    # client.object_relationship.where(object_type_id: 1, object_id: 'PostCo', query_params: query_params)

    # Response:
    # #<CustomerioAPI::ObjectRelationship cio_relationships=[#<OpenStruct object_type_id="0", identifiers=#<OpenStruct cio_id="d7a90a000102", email="andy@postco.io", id="test1">, attributes=#<OpenStruct>, timestamps=#<OpenStruct>>], next="">

    def where(object_type_id:, object_id:, query_params: {})
      response_body = get_request("objects/#{object_type_id}/#{object_id}/relationships", params: query_params).body
      ObjectRelationship.new(response_body)
    end
  end
end
