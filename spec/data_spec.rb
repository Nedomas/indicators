require 'spec_helper'

describe Data do

	context "should raise an exception if" do
	  it "nil or empty" do
	  	expect { Indicators::Data.new(nil) }.to raise_error
	  	expect { Indicators::Data.new('') }.to raise_error
	  end
	  it "not an array or hash" do
	  	expect { Indicators::Data.new('some string') }.to raise_error
	  end
	  it "contains dividends hash from securities gem" do
	  	expect { Indicators::Data.new(Securities::Stock.new(["aapl"]).history(:start_date => '2012-08-01', :end_date => '2012-08-10', :periods => :dividends).results) }.to raise_error
		end
	end

	context "should not raise an exception if" do
		it "is an array" do
			expect { Indicators::Data.new([1, 2, 3]) }.not_to raise_error
		end
		it "is a hash" do
			expect { Indicators::Data.new(Securities::Stock.new(["aapl"]).history(:start_date => '2012-08-01', :end_date => '2012-08-03', :periods => :daily).results) }.not_to raise_error
		end

	end

end