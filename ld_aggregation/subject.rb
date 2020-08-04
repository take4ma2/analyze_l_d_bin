require './ld_aggregation/time_bin'
require 'pry'

module LdAggregation

  class Subject
    attr_reader :subject_id
    attr_reader :data
    # Total duration(sec)
    attr_reader :total_duration

    # Total distance of traveled(cm)
    attr_reader :distance_traveled
    # Latency to entering into light chamber(s)
    attr_reader :latency
    # N. of transition(times)
    attr_reader :transition
    # Time spent in light chamber(%)
    attr_reader :spent_in_light

    def initialize(rows)
      @subject_id = rows[0][0]
      @data = []
      rows.each { |row| @data << TimeBin.parse(row) }
      @latency = rows[0][10].to_f - @data[0].time_dark
      @total_duration = rows[0][9].to_f - 30.0
      @distance_traveled = 0.0
      @transition = 0
      @spent_in_light = 0.0
      @data[1..-1].each { |d| @distance_traveled += (d.distance_dark + d.distance_light) }
      @data[1..-1].each { |d| @transition += d.transition }
      @spent_in_light = @data[1..-1].map.each { |d| d.time_light }.sum / @total_duration * 100.0
    end
  end

end
