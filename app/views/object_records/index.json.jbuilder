json.array!(@object_records) do |object_record|
  json.extract! object_record, :id, :object_id, :object_type, :timestamp, :object_changes
  json.url object_record_url(object_record, format: :json)
end
