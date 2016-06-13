class ObjectRecordsDatatable
  delegate :params, to: :@view
  include ApplicationHelper

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: ObjectRecord.count,
      iTotalDisplayRecords: object_records.total_entries,
      aaData: data
    }
  end

private

  def data
    object_records.map do |object_record|
      [
        object_record.object_id,
        object_record.object_type,
        "#{object_record.timestamp.strftime("%Y-%m-%d %H:%M:%S %Z")} (#{object_record.timestamp.to_i})",
        pretty_format_changes(object_record.object_changes)
      ]
    end
  end

  def object_records
    @object_records ||= fetch_object_records
  end

  def fetch_object_records
    object_records = ObjectRecord.order(generate_hash("#{sort_column}: '#{sort_direction}'"))

    if params[:search]['value'].present?
      search_value = params[:search]['value'].strip

      begin
        timestamp_formatted = Time.at(Integer(search_value)).to_i
      rescue
        timestamp_formatted = Chronic.parse(search_value).to_i
      end

      object_records = object_records.any_of( {object_id: search_value},{object_type: /#{Regexp.escape(search_value)}/}, {timestamp: timestamp_formatted}, { :"object_changes.#{search_value}".exists => true }  )
    end
    object_records = object_records.paginate( per_page: per_page, page: page)
    
    object_records
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[object_id object_type timestamp object_changes]
    columns[params[:order]["0"]["column"].to_i]
  end

  def sort_direction
    params[:order]["0"]["dir"]
  end
end
