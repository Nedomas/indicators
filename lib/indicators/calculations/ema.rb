module Indicators
  #
  # Exponential Moving Average
  class Ema

    # Multiplier: (2 / (Time periods + 1) ) = (2 / (10 + 1) ) = 0.1818 (18.18%)
    # EMA: {Close - EMA(previous day)} x multiplier + EMA(previous day). 
    def self.calculate data, parameters
      periods = parameters
      output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, periods)

      k = 2.0/(periods+1)
      adj_closes.each_with_index do |adj_close, index|
        start = index+1-periods
        if start == 0
          output[index] = Indicators::Sma.calculate(adj_closes[start..index], periods).last
        elsif start > 0
          output[index] = ((adj_close - output[index-1]) * k + output[index-1])
        else
          output[index] = nil
        end
      end
      
      return output

    end

  end

end