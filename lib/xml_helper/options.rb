require 'optparse'

module XmlHelper
  class Options
    attr_reader :file_path

    def initialize(argv)
      parse(argv)
    end

    private

    def parse(argv)
      OptionParser.new do |opts|
        opts.banner = "Usage: xml_helper [ options ] [ args ]"

        opts.on("-d [ FILE_PATH_1  FILE_PATH_2 ]",  String, "Find the differences between XML documents at [ FILE_PATH_1  FILE_PATH_2 ]") do |p|
          @file_path = p
        end

        opts.on("-h", "--help", "Show this message") do |h|
          puts opts
        end

        begin
          argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        end

      end
    end

  end
end