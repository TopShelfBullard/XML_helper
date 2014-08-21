require_relative 'options'
require_relative 'differences'
require_relative 'output'

module XmlHelper
  class Runner

    def initialize(argv)
      @options = XmlHelper::Options.new(argv)

      if @options.file_path
        @file_path_one = @options.file_path
        @file_path_two = argv[0]
      end
    end

    def run
      if @file_path_one && @file_path_two 
        run_xml_difference_finder  
      end
    end

    def run_xml_difference_finder
        xml_differences = XmlHelper::Differences.new(@file_path_one, @file_path_two)
        differences = xml_differences.get_hash_array_of_differences
        differences.each do |diffs|
          XmlHelper::Output.output_differences(diffs)
        end
    end

  end
end
