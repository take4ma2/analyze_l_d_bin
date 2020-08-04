require 'csv'
#require 'charlock_holmes'
require './ld_aggregation/subject'
require 'pry'

module LdAggregation

  class BinFile
    attr_accessor :data
    attr_accessor :path
    attr_accessor :subjects_data
    attr_accessor :encoding

    def initialize(f, encoding)
      @path = f
      enc = encoding.nil? ? '' : encoding
      @encoding = enc.size > 0 ? enc : 'UTF-8'
      #detection = CharlockHolmes::EncodingDetector.detect(File.read(@path))
      #encoding = detection[:encoding] == 'Shift_JIS' ? 'CP932' : detection[:encoding]
      #encoding = ['UTF-8', 'ASCII'].include?(detection[:encoding]) ? 'UTF-8' : 'CP932'
      @data = CSV.read(@path, :col_sep => "\t", :headers => false, :encoding => "#{@encoding}:UTF-8")
      @subjects_data = []
      subjects
    end

    def subjects
      heads = @data.map.each_with_index{ |d, i| d[0].match(/[0-9]{6}/) ? i : nil }.compact

      heads.each_with_index do |h, i|
        rows = []
        terminate = (i != heads.size - 1) ? heads[i+1] - 1 : @data.size - 1
        [*(h .. terminate)].each do |r|
          rows << @data[r]
        end
        @subjects_data << LdAggregation::Subject.new(rows)
      end
    end
  end
end
