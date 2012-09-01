# Indicators

A gem for calculating technical analysis indicators.

Current functionality demo of Indicators and Securities gems synergy can be tested at http://strangemuseum.heroku.com.

## Installation

Add this line to your application's Gemfile:

    gem 'indicators'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install indicators

## Accepted Input

# Array

	my_data = Indicators::Data.new([1, 2, 3, 4, 5])

Then it returns data as an array with indicator values in index places:

	i.e. my_data.calc(:type => :sma, :variables => 2) => [nil, 1.5, 2.5, 3.5, 4.5]

# Securities gem hash

	my_data = Indicators::Data.new(Securities::Stock.new(["aapl", "yhoo"]).history(:start_date => '2012-08-25', :end_date => '2012-08-30').results)

Then it returns a hash so it can be quite powerful at calculating multiple stock indicators at once:

	{"aapl"=>[nil, 675.24, 674.0600000000001], "yhoo"=>[nil, 14.785, 14.821666666666667]}

## Supported Indicators

# Simple Moving Average => :sma

	my_data.calc(:type => :sma, :variables => 5)

#	Exponental Moving Average => :ema

	my_data.calc(:type => :ema, :variables => 5)

# Bollinger Bands => :bb

	my_data.calc(:type => :bb, :variables => [15, 3])

Variables have to be specified as an array [periods, multiplier]. If multiplier isn't specified, it defaults to 2.

	It returns output as an array for each data point [middle band, upper band, lower band].
	i.e. my_data.calc(:type => :bb, :variables => 3) => {"aapl"=>[nil, nil, [674.65, 676.8752190903368, 672.4247809096631]]} 

# Moving Average Convergence Divergence => :macd

	my_data.calc(:type => :macd, :variables => [12, 26, 9])

Variables have to be specified as an array [faster periods, slower periods, signal line]. If slower periods isn't specified, it defaults to 26 and signal line to 9.

	MACD output is [MACD line, signal line, MACD histogram].

# Relative Strength Index => :rsi

	my_data.calc(:type => :rsi, :variables => 14)

The more data it has, the more accurate RSI is.

## To Do

* Make defaults mechanism more versatile.
* Write specs.
* More validations.
* A strategy backtesting tool.

# Indicators:
* More moving averages (CMA, WMA, MMA).
* ROC.
* CCI.
* Stochastics.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
