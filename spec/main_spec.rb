require 'spec_helper'

describe Indicators::Main do

	context "should raise an exception if" do
		it "there was no data to work on" do
			@my_data = Indicators::Data.new([1, 2, 3, 4, 5])
			expect { @my_data.calc(:type => :sto, :params => 2) }.to raise_error('You cannot calculate Stochastic Oscillator on array. Highs and lows are needed. Feel free Securities gem hash instead.')
		end
	end

end