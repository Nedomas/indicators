module Indicators

	class Main

    attr_reader :output, :output_abbr, :params
    # Error handling.
    class MainException < StandardError
    end

		def initialize data, parameters
      type = parameters[:type]
      variables = parameters[:variables]
      @output_abbr = type.to_s.upcase
      if type == :sma
        @params = Indicators::Helper.get_parameters(variables, 0, 20)
      elsif type == :ema
        @params = Indicators::Helper.get_parameters(variables, 0, 20)
      elsif type == :bb
        @params = Array.new
        @params[0] = Indicators::Helper.get_parameters(variables, 0, 20)
        @params[1] = Indicators::Helper.get_parameters(variables, 1, 2)
      elsif type == :macd
        @params = Array.new
        @params[0] = Indicators::Helper.get_parameters(variables, 0, 12)
        @params[1] = Indicators::Helper.get_parameters(variables, 1, 26)
        @params[2] = Indicators::Helper.get_parameters(variables, 2, 9)
      elsif type == :rsi
        @params = Indicators::Helper.get_parameters(variables, 0, 14)
      elsif type == :sto
        @params = Array.new
        @params[0] = Indicators::Helper.get_parameters(variables, 0, 14)
        @params[1] = Indicators::Helper.get_parameters(variables, 1, 3)
        @params[2] = Indicators::Helper.get_parameters(variables, 2, 3)
      end

			if data.is_a?(Hash)
        @output = Hash.new
        data.each do |symbol, stock_data|
          # Check if this symbol was empty and don't go further with it.
          if stock_data.length == 0
            @output[symbol] = []
          else
            @output[symbol] = case type
                                when :sma then Indicators::Sma.calculate(Indicators::Parser.parse_data(stock_data), @params)
                                when :ema then Indicators::Ema.calculate(Indicators::Parser.parse_data(stock_data), @params)
                                when :bb then Indicators::Bb.calculate(Indicators::Parser.parse_data(stock_data), @params)
                                when :macd then Indicators::Macd.calculate(Indicators::Parser.parse_data(stock_data), @params)
                                when :rsi then Indicators::Rsi.calculate(Indicators::Parser.parse_data(stock_data), @params)
                                when :sto then Indicators::Sto.calculate(Indicators::Parser.parse_data(stock_data), @params)
                              end
            # Parser returns in {:date=>[2012.0, 2012.0, 2012.0], :open=>[409.4, 410.0, 414.95],} format
          end
        end
			else
				@output = case type
				            when :sma then Indicators::Sma.calculate(data, @params)
                    when :ema then Indicators::Ema.calculate(data, @params)
                    when :bb then Indicators::Bb.calculate(data, @params)
                    when :macd then Indicators::Macd.calculate(data, @params)
                    when :rsi then Indicators::Rsi.calculate(data, @params)
                    when :sto then raise MainException, "You cannot calculate Stochastic Oscillator on array. Highs and lows are needed. Feel free Securities gem hash instead."
				          end
			end
      return @output
    end

  end
end