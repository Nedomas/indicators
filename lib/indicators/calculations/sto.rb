 module Indicators
  #
  # Full Stochastic Oscillator
  class Sto

    # %K = (Current Close - Lowest Low)/(Highest High - Lowest Low) * 100
    # %D = 3-day SMA of %K
    # Lowest Low = lowest low for the look-back period
    # Highest High = highest high for the look-back period
    # %K is multiplied by 100 to move the decimal point two places
    #
    # Full %K = Fast %K smoothed with X-period SMA
    # Full %D = X-period SMA of Full %K
    #
    # Input 14, 3, 5
    # Returns [full %K, full %D]
    def self.calculate data, parameters
      k1_periods = parameters[0]
      k2_periods = parameters[1]
      d_periods = parameters[2]
      output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, k1_periods)
      highs = Indicators::Helper.validate_data(data, :high, k1_periods)
      lows = Indicators::Helper.validate_data(data, :low, k1_periods)

      k1 = []
      k2 = []
      d = []
      adj_closes.each_with_index do |adj_close, index|
        start = index+1-k1_periods
        if index+1 >= k1_periods
          k1[index] = (adj_close - lows[start..index].min) / (highs[start..index].max - lows[start..index].min) * 100
          if index+2 >= k1_periods + k2_periods
            k2[index] = Indicators::Sma.calculate(k1[(k1_periods-1)..index], k2_periods).last
          else 
            k2[index] = nil
          end
          if index+3 >= k1_periods + k2_periods + d_periods
            d[index] = Indicators::Sma.calculate(k2[(k1_periods + k2_periods - 2)..index], d_periods).last
          else
            d[index] = nil
          end
        else
          k1[index] = nil
        end
        output[index] = [k1[index], k2[index], d[index]]
      end

      return output

    end

  end
end