desc "Export existing Object records to export.csv in the root folder"
task export_records: :environment do
	begin
		File.open("export.csv","w") do |e|
			e.puts ObjectRecord.to_csv
		end
		puts "--- Successfully Exported ObjectRecord Model!"
	rescue Exception => e
		puts "--- There has been an Error in exporting: #{e}"
	end
end