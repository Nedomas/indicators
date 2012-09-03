module Indicators

	class Main

    # Error handling.
    class MainException < StandardError
    end

		def self.calculate data, parameters
			if data.is_a?(Hash)
        results = Hash.new
        data.each do |symbol, stock_data|
          # Check if this symbol was empty and don't go further with it.
          if stock_data.length == 0
            results[symbol] = []
          else
            results[symbol] = case parameters[:type]
                                when :sma then Indicators::Sma.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                                when :ema then Indicators::Ema.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                                when :bb then Indicators::Bb.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                                when :macd then Indicators::Macd.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                                when :rsi then Indicators::Rsi.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                                when :sto then Indicators::Sto.new(Indicators::Parser.parse_data(stock_data), parameters[:variables])
                              end
            # Parser returns in {:date=>[2012.0, 2012.0, 2012.0], :open=>[409.4, 410.0, 414.95],} format
          end
        end
			else
				results = case parameters[:type]
				            when :sma then Indicators::Sma.new(data, parameters[:variables])
                    when :ema then Indicators::Ema.new(data, parameters[:variables])
                    when :bb then Indicators::Bb.new(data, parameters[:variables])
                    when :macd then Indicators::Macd.new(data, parameters[:variables])
                    when :rsi then Indicators::Rsi.new(data, parameters[:variables])
                    when :sto then raise MainException, "You cannot calculate Stochastic Oscillator on array. Highs and lows are needed. Feel free Securities gem hash instead."
				          end
			end
      return results
    end

  end
end