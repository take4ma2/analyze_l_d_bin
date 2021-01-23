
module LdAggregation

  class TimeBin
    attr_reader :timebin_id
    # Distance traveled in D/L chambers(cm)
    attr_reader :distance_dark, :distance_light
    # Time spent in D/L chambers(s)
    attr_reader :time_dark, :time_light
    # N. of transition(times)
    attr_reader :transition
    # Time spent at border
    attr_reader :time_border
    
    def initialize(row)
      @timebin_id = row[2]
      @distance_dark = row[3].to_f
      @distance_light = row[4].to_f
      @time_dark = row[5].to_f
      @time_light = row[6].to_f
      @transition = row[7].to_f
      @time_border = row[8].to_f
    end

    def self.parse(row)
      self.new row
    end
  end

end
