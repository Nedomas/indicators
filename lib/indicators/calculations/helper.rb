module Indicators
  # Main helper methods
  class Helper

    # Error handling.
    class HelperException < StandardError ; end

    def self.validate_data data, column, parameters
      # If this is a hash, choose which column of values to use for calculations.
      if data.is_a?(Hash)
        valid_data = data[column]
      else
        valid_data = data
      end

      if valid_data.length < parameters
        raise HelperException, "Data point length (#{valid_data.length}) must be greater than or equal to the required indicator periods (#{parameters})."
      end
      return valid_data
    end

    # Indicators::Helper.get_parameters([12, 1, 1], 0, 15)
    def self.get_parameters parameters, i=0, default=0

      # Single parameter is to choose from.
      if parameters.is_a?(Integer) || parameters.is_a?(NilClass)

        # Set all other to default if only one integer is given instead of an array.
        return default if i != 0

        # Check if no parameters are specified at all, if so => set to default.
        # Parameters 15, 0, 0 are equal to 15 or 15, nil, nil.
        if parameters == nil || parameters == 0
          if default != 0
            return default
          else
            raise HelperException, 'There were no parameters specified and there is no default for it.'
          end
        else
          return parameters
        end
      # Multiple parameters to choose from.
      elsif parameters.is_a?(Array)
        # In case array is given not like [1, 2] but like this ["1", "2"]. This usually happens when getting data from input forms.
        parameters = parameters.map(&:to_i)
        if parameters[i] == nil || parameters[i] == 0
          if default != 0
            return default
          else
            raise HelperException, 'There were no parameters specified and there is no default for it.'
          end
        else
          return parameters[i]
        end
      else
        raise HelperException, 'Parameters have to be a integer, an array or nil.'
      end

    end

  end
end

#
# Extra methods for mathematical calculations.
module Enumerable

  def sum
    return self.inject(0){|accum, i| accum + i }
  end

  def mean
    return self.sum / self.length.to_f
  end

  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum + (i - m) ** 2 }
    return sum / (self.length - 1).to_f
  end

  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end

end