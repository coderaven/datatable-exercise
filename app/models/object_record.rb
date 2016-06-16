class ObjectRecord
  include Mongoid::Document

  validates_presence_of :object_id, :object_type, :timestamp, :object_changes
  validates_uniqueness_of :timestamp, :scope => [:object_id, :object_type]

  field :object_id, type: Integer
  field :object_type, type: String
  field :timestamp, type: DateTime
  field :object_changes, type: Hash
  
  scope :search, -> (objectid, object_type, timestamp) { where(object_id: objectid, object_type: object_type).lte(timestamp: timestamp).order_by(timestamp: "desc") }

  def self.merged_properties(records_set)
    ApplicationController.helpers.pretty_format_changes(records_set.reverse.to_a.map(&:object_changes).inject(&:merge))
  end

  def self.import(file)
    begin
      File.open(file.path, "rb:UTF-8") do |f|
        options = {row_sep: :auto, col_sep: ",", user_provided_headers: [:object_id], headers_in_file: false}

        headers_exist = false
        SmarterCSV.process(f, options) { |header| headers_exist = true if header.first[:object_id].to_s.strip == "object_id"; break }

        options = {row_sep: :auto, col_sep: ",", user_provided_headers: [:object_id,:object_type,:timestamp,:object_changes], remove_empty_values: true, headers_in_file: headers_exist}

        SmarterCSV.process(f, options) do |array|
            array.first[:object_changes] = ApplicationController.helpers.generate_hash(array.first[:object_changes])
            ObjectRecord.create(array.first)
        end
      end
      
      true
    rescue StandardError
      false
    end
  end
end
