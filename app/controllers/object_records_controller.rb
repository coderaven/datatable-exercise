class ObjectRecordsController < ApplicationController
  include ApplicationHelper

  def index
    respond_to do |format|
      format.html
      format.json { render json: ObjectRecordsDatatable.new(view_context) }
    end
  end

  def import
    if ObjectRecord.import(params[:file])
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
      begin
        timestamp_formatted = Time.at(Integer(params[:timestamp])).to_i
      rescue StandardError
        timestamp_formatted = Chronic.parse(params[:timestamp].strip).to_i
      end

      query_result = 
        ObjectRecord.where(object_id: params[:object_id]
          .strip, object_type: params[:object_type].strip)
          .lte(timestamp: timestamp_formatted)
          .order_by(timestamp: "desc")

      if (@object_record = query_result.first)
        @merged_properties = pretty_format_changes(query_result.reverse.to_a.map(&:object_changes).inject(&:merge))
      end
    else
      @object_record = nil
    end 

    respond_to do |format|
      format.js
    end
  end

end
