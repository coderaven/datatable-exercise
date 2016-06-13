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
    result = true

    begin
      f = File.open(file.path, "rb:UTF-8")
      options = {row_sep: :auto, col_sep: ","}

      SmarterCSV.process(f, options) do |array|
      array.first[:object_changes] = ApplicationController.helpers.generate_hash(array.first[:object_changes])
          ObjectRecord.create(array.first)
      end

    rescue StandardError
      result = false
    end

    f.close if f

    result
  end
end
