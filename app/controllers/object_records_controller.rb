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
    if params.values_at(:object_id, :object_type, :timestamp).include?(nil)
      @object_record = nil
    else
      timestamp_formatted = timestamp_formatter(params[:timestamp])

      query_result = ObjectRecord.search(params[:object_id].strip, params[:object_type].strip, timestamp_formatted)
      @merged_properties = ObjectRecord.merged_properties(query_result) if (@object_record = query_result.first)
    end 

    respond_to do |format|
      format.js
    end
  end

end
