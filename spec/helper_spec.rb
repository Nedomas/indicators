require 'spec_helper'

describe Indicators::Helper do

	before :all do
			@my_data = Indicators::Data.new([1, 2, 3, 4, 5])
		end
	context "should raise an exception if" do
		it "there was not enough data for specified periods" do
			expect { @my_data.calc(:type => :sma, :params => 6) }.to raise_error('Data point length (5) must be greater than or equal to the required indicator periods (6).')
		end
		it "unknown type is given for parameters" do
			expect { @my_data.calc(:type => :sma, :params => 'unknown_type') }.to raise_error('Parameters must be an integer, float, an array or nil.')
		end
	end
	it "BB should accept float as multiplier" do
		@my_data.calc(:type => :bb, :params => [2, 2.5]).output[4][1].should > @my_data.calc(:type => :bb, :params => [2, 2]).output[4][1]
		@my_data.calc(:type => :bb, :params => [2, 2.5]).output[4][2].should < @my_data.calc(:type => :bb, :params => [2, 2]).output[4][2]
	end
	it "BB should not accept float as periods" do
		@my_data.calc(:type => :bb, :params => [2.9, 2.5]).output.should == @my_data.calc(:type => :bb, :params => [2, 2.5]).output
		@my_data.calc(:type => :bb, :params => [2.9, 2.5]).output[4][1].should > @my_data.calc(:type => :bb, :params => [2, 2]).output[4][1]
	end

end