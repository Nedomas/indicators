module Indicators

	class Main

    attr_reader :output, :abbr, :params
    # Error handling.
    class MainException < StandardError ; end

		def initialize data, parameters
      type = parameters[:type]
      all_params = parameters[:params]
      @abbr = type.to_s.upcase
      case type
      when :sma
        @params = Indicators::Helper.get_parameters(all_params, 0, 20)
      when :ema
        @params = Indicators::Helper.get_parameters(all_params, 0, 20)
      when :bb
        @params = Array.new
        @params << Indicators::Helper.get_parameters(all_params, 0, 20)
        @params << Indicators::Helper.get_parameters(all_params, 1, 2.0)
      when :macd
        @params = Array.new
        @params << Indicators::Helper.get_parameters(all_params, 0, 12)
        @params << Indicators::Helper.get_parameters(all_params, 1, 26)
        @params << Indicators::Helper.get_parameters(all_params, 2, 9)
      when :rsi
        @params = Indicators::Helper.get_parameters(all_params, 0, 14)
      when :sto
        @params = Array.new
        @params << Indicators::Helper.get_parameters(all_params, 0, 14)
        @params << Indicators::Helper.get_parameters(all_params, 1, 3)
        @params << Indicators::Helper.get_parameters(all_params, 2, 3)
      end

      # This is a Securities gem hash.
			if data[0].is_a?(Hash)
        data = Indicators::Parser.parse_data(data)
        # Parser returns in {:date=>[2012.0, 2012.0, 2012.0], :open=>[409.4, 410.0, 414.95],} format
			else
        # Don't let calculation start on a standard array for few instruments cause it needs more specific data.
        if type == :sto
          raise MainException, 'You cannot calculate Stochastic Oscillator on array. Highs and lows are needed. Feel free Securities gem hash instead.'
        end
      end
			@output = case type
			            when :sma then Indicators::Sma.calculate(data, @params)
                  when :ema then Indicators::Ema.calculate(data, @params)
                  when :bb then Indicators::Bb.calculate(data, @params)
                  when :macd then Indicators::Macd.calculate(data, @params)
                  when :rsi then Indicators::Rsi.calculate(data, @params)
                  when :sto then Indicators::Sto.calculate(data, @params)
			          end
      return @output
    end

  end
end