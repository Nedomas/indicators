module Indicators
	class Data

		attr_reader :data, :results
		INDICATORS = [:sma, :ema, :bb, :macd, :rsi, :sto]
		# Error handling
		class DataException < StandardError
		end

		def initialize parameters
			@data = parameters

			# Check if data usable.
			if @data.nil? || @data.empty?
        raise DataException, "There is no data to work on."
      end
			unless @data.is_a?(Array) or @data.is_a?(Hash)
				raise DataException, "Alien data. Given data must be an array or a hash (got #{@data.class})."
			end

			if @data.is_a?(Hash)
				# Hacky, but a fast way to check if this is a dividends hash without the extra hassle.
				raise DataException, "Cannot use dividends values for technical analysis." if @data.to_s.include?(':dividends')
			end
		end

		def calc parameters
			# Check is parameters are usable.
			unless parameters.is_a?(Hash)
				raise DataException, 'Given parameters have to be a hash. FORMAT: .calc(:type => :ema, :params => 12)'
			end

			# If not specified, set default :type to :sma.
			parameters[:type] = :sma if parameters[:type].nil? or parameters[:type].empty?

			# Check if there is such indicator type supported.
			case
				when INDICATORS.include?(parameters[:type]) then @results = Indicators::Main.new(@data, parameters)
			else 
				raise DataException, "Invalid indicator type specified (#{parameters[:type]})."
			end
		end

	end
end