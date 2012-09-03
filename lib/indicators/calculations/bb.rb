module Indicators
  #
  # Bollinger Bands
  class Bb     

    # Middle Band = 20-day simple moving average (SMA)
    # Upper Band = 20-day SMA + (20-day standard deviation of price x 2) 
    # Lower Band = 20-day SMA - (20-day standard deviation of price x 2)
    def self.calculate data, parameters
      periods = parameters[0] 
      multiplier = parameters[1]
      output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, periods)

      adj_closes.each_with_index do |adj_close, index|
        start = index+1-periods
        if index+1 >= periods
          middle_band = Indicators::Sma.calculate(adj_closes[start..index], periods).last
          upper_band = middle_band + (adj_closes[start..index].standard_deviation * multiplier)
          lower_band = middle_band - (adj_closes[start..index].standard_deviation * multiplier)
          # Output for each point is [middle, upper, lower].
          output[index] = [middle_band, upper_band, lower_band]
        else
          output[index] = nil
        end
      end

      return output
      
    end

  end
end