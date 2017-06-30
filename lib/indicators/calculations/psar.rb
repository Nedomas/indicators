# Parabolic Stop-and-Reversal
# http://stockcharts.com/school/doku.php?id=chart_school:technical_indicators:parabolic_sar
# 
# ------------------------------
# 
# [Rising SAR]
#
# Prior SAR: The SAR value for the previous period. 
#
# Extreme Point (EP): The highest high of the current uptrend. 
#
# Acceleration Factor (AF):
#   Starting at .02, AF increases by .02 each
#   time the extreme point makes a new high. AF can reach a maximum 
#   of .20, no matter how long the uptrend extends. 
#
# Current SAR = Prior SAR + Prior AF(Prior EP - Prior SAR)
#             = 48.13 + .14(49.20 - 48.13)
#             = 48.28
#
# The Acceleration Factor is multiplied by the difference between the 
# Extreme Point and the prior period's SAR. This is then added to the 
# prior period's SAR. Note however that SAR can never be above the
# prior two periods' lows. Should SAR be above one of those lows, use
# the lowest of the two for SAR. 
#
# ------------------------------
#
# [Falling SAR]
#
# Prior SAR: The SAR value for the previous period. 
#
# Extreme Point (EP): The lowest low of the current downtrend. 
#
# Acceleration Factor (AF):
#   Starting at .02, AF increases by .02 each 
#   time the extreme point makes a new low. AF can reach a maximum
#   of .20, no matter how long the downtrend extends. 
# 
# Current SAR = Prior SAR - Prior AF(Prior SAR - Prior EP)
#             = 43.84 - .16(43.84 - 42.07)
#             = 43.56
#
# The Acceleration Factor is multiplied by the difference between the 
# Prior period's SAR and the Extreme Point. This is then subtracted 
# from the prior period's SAR. Note however that SAR can never be
# below the prior two periods' highs. Should SAR be below one of
# those highs, use the highest of the two for SAR. 
#
# ------------------------------

module Indicators
  class Psar
    # Input 
    # Returns []
    def self.calculate data, parameters
      output = Array.new
      # initialize SAR
      # subscription start
      # new trade coming
      #   define rising_faling_flag by diff
      #   if condition rising_faling_flag
      #   Use "+ Prior AF(Prior EP - Prior SAR)" or "- Prior AF(Prior SAR - Prior EP)"

      return output
    end

  end
end