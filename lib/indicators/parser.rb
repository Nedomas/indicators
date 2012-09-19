module Indicators

	# Class to parse a securities gem return hash.
	class Parser

		# Error handling.
		class ParserException < StandardError ; end

		def self.parse_data parameters
			
			usable_data = Hash.new
			transposed_hash = Hash.new
			# Such a hacky way to transpose an array.
			# FIXME: Now v.to_f converts date to float, it shouldn't.
			parameters.inject({}){|a, h| 
			  h.each_pair{|k,v| (a[k] ||= []) << v.to_f}
			  transposed_hash = a
			}
		 	usable_data = transposed_hash
		 	# usable data is {:close => [1, 2, 3], :open => []}

			return usable_data
		end

	end
end