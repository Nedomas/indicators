require 'spec_helper'

describe Indicators::Helper do

	context "should raise an exception if" do
		before :all do
			@my_data = Indicators::Data.new([1, 2, 3, 4, 5])
		end
		it "there was not enough data for specified periods" do
			expect { @my_data.calc(:type => :sma, :params => 6) }.to raise_error('Data point length (5) must be greater than or equal to the required indicator periods (6).')
		end
		it "unknown type is given for parameters" do
			expect { @my_data.calc(:type => :sma, :params => 'unknown_type') }.to raise_error('Parameters have to be a integer, an array or nil.')
		end
	end

end