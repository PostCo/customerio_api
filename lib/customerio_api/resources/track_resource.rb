module CustomerioAPI
  class TrackResource < Resource
    # Example: Create/Update a Shop object
    # attributes = { type: 'object', action: 'identify', identifiers: { object_type_id: '2', object_id: 'linh-us'}, attributes: {name: "linh-us"} }
    # v2_client.track.entity(attributes)
    # Response: {}

    def entity(attributes)
      post_request('entity', body: attributes).body
    end

    # Example: Create/Update multiple objects
    # attributes: an array of people or objects
    # attributes = [
    #   { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'linh-us' }, attributes: { name: 'linh-us' } },
    #   { type: 'object', action: 'identify', identifiers: { object_type_id: '1', object_id: 'PostCo' }, attributes: { name: 'PostCo' } }
    #   ]

    # v2_client.track.batch(attributes)
    # Response: {}

    def batch(attributes)
      post_request('batch', body: { batch: attributes }).body
    end
  end
end
