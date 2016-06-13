class ObjectRecordsController < ApplicationController
  include ApplicationHelper

  def index
    respond_to do |format|
      format.html
      format.json { render json: ObjectRecordsDatatable.new(view_context) }
    end
  end

  def import
    result = ObjectRecord.import(params[:file])

    if result
      redirect_to root_url, notice: "Records imported successfully.", alert: "alert-success"
    else
      redirect_to root_url, notice: "Unable to import: Invalid CSV or File!", alert: "alert-danger"
    end
  end

  def delete_all
    ObjectRecord.delete_all # Unsafe but only here for exercise testing convenience
    respond_to do |format|
      format.html { redirect_to root_url, notice: "All Records successfully deleted", alert: "alert-warning" }
    end
  end

  def search
    if params[:object_id] && params[:object_type] && params[:timestamp]
      object_id = params[:object_id].strip
      object_type = params[:object_type].strip

      begin
        timestamp_formatted = Time.at(Integer(params[:timestamp])).to_i
      rescue
        timestamp_formatted = Chronic.parse(params[:timestamp].strip).to_i
      end

      query_result = ObjectRecord.where(object_id: object_id, object_type: object_type).lte(timestamp: timestamp_formatted).order_by(timestamp: "desc")
      @object_record = query_result.first

      if @object_record
        @merged_properties = query_result.reverse.to_a.map(&:object_changes).inject(&:merge)
        @merged_properties = pretty_format_changes(@merged_properties)
      end
    else
      @object_record = nil
    end 

    respond_to do |format|
      format.js
    end
  end

end
