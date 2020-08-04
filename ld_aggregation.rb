require './ld_aggregation/bin_file'
require 'csv'

module LdAggregation

  def main(f, encoding)
    if f.nil? || !File.exist?(f) then
      puts "File Not found: #{f}"
      exit
    end

    unless f.match(/_bin\.txt$/)
      puts "#{f} is not bin file"
      exit
    else
      output = File.basename(f).gsub(/_bin\.txt/, '_ld.csv')
    end

    loaded = LdAggregation::BinFile.new f, encoding

    # CSV output
    lines = []
    lines << ['subject id', 'Distance', 'LEntry', 'Move', 'LStay']
    lines << [nil,
              'Distance traveled: total',
              'Latency for entering into light chamber', 
              'Number of transition',
              'Time spent in light chamber']
    loaded.subjects_data.each do |s|
      lines << [s.subject_id, s.distance_traveled, s.latency,
                s.transition, s.spent_in_light]
    end

    

    CSV.open(output, 'w') do |csv|
      lines.each { |l| csv << l }
    end
  end

  def VERSION
    "1.1.0 (Assigns output file name.)"
  end

  module_function :main, :VERSION
end

# --- main ---
puts "Light/Dark transition test data aggregation tool [v.#{LdAggregation.VERSION}]"
LdAggregation::main ARGV[0], ARGV[1]
