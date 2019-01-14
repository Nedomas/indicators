require "indicators/version"
require "indicators/data.rb"
require "indicators/parser.rb"
require "indicators/main.rb"

require "indicators/calculations/helper.rb"

# Lagging Indicators
require "indicators/calculations/sma.rb"
require "indicators/calculations/ema.rb"
require "indicators/calculations/bb.rb"
require "indicators/calculations/macd.rb"

# Leading Indicators
require "indicators/calculations/rsi.rb"
require "indicators/calculations/sto.rb"

module Indicators
end
