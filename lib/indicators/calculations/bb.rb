module Indicators
  #
  # Bollinger Bands
  class Bb

    attr_reader :output, :output_abbr, :params     

    # Middle Band = 20-day simple moving average (SMA)
    # Upper Band = 20-day SMA + (20-day standard deviation of price x 2) 
    # Lower Band = 20-day SMA - (20-day standard deviation of price x 2)
    def initialize data, parameters
      @output_abbr = "BB"
      @params = Array.new
      @params[0] = periods = Indicators::Helper.get_parameters(parameters, 0, 20)
      @params[1] = multiplier = Indicators::Helper.get_parameters(parameters, 1, 2)
      @output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, periods)

      adj_closes.each_with_index do |adj_close, index|
        start = index+1-periods
        if index+1 >= periods
          middle_band = Indicators::Sma.new(adj_closes[start..index], periods).output.last
          upper_band = middle_band + (adj_closes[start..index].standard_deviation * multiplier)
          lower_band = middle_band - (adj_closes[start..index].standard_deviation * multiplier)
          # Output for each point is [middle, upper, lower].
          @output[index] = [middle_band, upper_band, lower_band]
        else
          @output[index] = nil
        end
      end
      
    end

  end
end