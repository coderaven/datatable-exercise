module ApplicationHelper
	def generate_hash(string)
		arr_sep=','
		key_sep=':'
		array = string.split(arr_sep)
		hash = {}

		array.each do |e|
		  key_value = e.split(key_sep)
		  hash[key_value[0].strip.gsub(/^{/,"")] = key_value[1].strip.gsub(/}$/,"")
		end

		hash
	end

	def pretty_format_changes(changes)
	    pretty = ""
	    changes.each do |key,value|
	      pretty << "#{key}: \"#{value}\", "
	    end
	    pretty.strip.gsub(/,$/,"")
  	end
end
