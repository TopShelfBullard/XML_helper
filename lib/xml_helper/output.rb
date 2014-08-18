require 'colorize'

module XmlHelper
  class Output
    class <<self

      def output_differences(data)
        puts self.intro(data[:element_one], data[:element_two])
        puts self.parent_data(data[:path_one], data[:parent_one])
        puts self.parent_data(data[:path_two], data[:parent_two])
        puts self.outro
      end

      def parent_data(path, parent)
        title = "In file [#{path}]:\nFrom parent element:\n".yellow
        body ="#{parent}\n"
        "#{title}#{body}\n"
      end

      def intro(node_one, node_two)
        separator = "\n*****************************************************\n".yellow
        title = "Differences:\n".yellow
        differences = "#{node_one}\n#{node_two}\n".red

        "#{separator}#{title}#{differences}"
      end

      def outro
        "*****************************************************\n\n".yellow
      end

    end
  end
end
