module Indicators
  #
  # Simple Moving Average
  class Sma

    # SMA: (sum of closing prices for x period)/x
    def self.calculate data, parameters
      periods = parameters
      output = Array.new
      # Returns an array from the requested column and checks if there is enought data points.
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, periods)

      adj_closes.each_with_index do |adj_close, index|
        start = index+1-periods
      	if index+1 >= periods
      		adj_closes_sum = adj_closes[start..index].sum
      		output[index] = (adj_closes_sum/periods.to_f)
      	else
      		output[index] = nil
      	end
      end
      return output
      
    end

  end
end