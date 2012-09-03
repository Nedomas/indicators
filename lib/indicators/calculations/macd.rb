module Indicators
  #
  # Moving Average Convergence Divergence
  class Macd

    attr_reader :output, :output_abbr, :params  

    # MACD Line: (12-day EMA - 26-day EMA) 
    # Signal Line: 9-day EMA of MACD Line
    # MACD Histogram: MACD Line - Signal Line
    # Default MACD(12, 26, 9)
    def initialize data, parameters
      @output_abbr = "MACD"
      @params = Array.new
      @params[0] = faster_periods = Indicators::Helper.get_parameters(parameters, 0, 12)
      @params[1] = slower_periods = Indicators::Helper.get_parameters(parameters, 1, 26)
      @params[2] = signal_periods = Indicators::Helper.get_parameters(parameters, 2, 9)
      @output = Array.new
      adj_closes = Indicators::Helper.validate_data(data, :adj_close, slower_periods+signal_periods-1)
      # puts "faster=#{faster_periods}, slower=#{slower_periods}, signal=#{signal_periods}"

      macd_line = []

      adj_closes.each_with_index do |adj_close, index|
        if index+1 >= slower_periods
          # Calibrate me! Not sure why it doesn't accept from or from_faster.
          faster_ema = Indicators::Ema.new(adj_closes[0..index], faster_periods).output.last
          slower_ema = Indicators::Ema.new(adj_closes[0..index], slower_periods).output.last
          macd_line[index] = faster_ema - slower_ema
          if index+1 >= slower_periods+signal_periods
            signal_line = Indicators::Ema.new(macd_line[(-signal_periods)..index], signal_periods).output.last 
            # Output is [MACD, Signal, MACD Hist]
            macd_histogram = macd_line[index] - signal_line
            @output[index] = [macd_line[index], signal_line, macd_histogram]
          else 
            @output[index] = [macd_line[index], nil, nil]
          end
        else
          macd_line[index] = nil
          @output[index] = nil
        end
      end

    end

  end
end