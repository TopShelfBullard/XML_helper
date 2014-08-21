require 'nokogiri'

module XmlHelper
  class Differences
    attr_reader :differences
    
    def initialize(file_path_one, file_path_two)
      @path_one = file_path_one
      @path_two = file_path_two
      document_one = read_file_to_document(file_path_one)
      document_two = read_file_to_document(file_path_two)

      @elements_one = get_array_of_elements(document_one)
      @elements_two = get_array_of_elements(document_two)
    end

    def read_file_to_document(file_path)
      file = File.new(file_path, "r")
      document = Nokogiri::XML::Document.parse(file) { |config| config.nonet }
    end

    def get_array_of_elements(doc)
      elements = []
      doc.traverse do |node|
        elements << node if node.class == Nokogiri::XML::Element
      end
      elements
    end
      
      def get_hash_array_of_differences(elements_one = @elements_one, elements_two = @elements_two, path_one = @path_one, path_two = @path_two)
        n = 0
        differences = []
        
        elements_one.each do |e_one|
          e_two = elements_two[n]
          if !(e_one.to_s == e_two.to_s) && e_one.children.length < 2
            differences << {path_one:path_one, element_one:e_one, parent_one:e_one.parent, path_two:path_two, element_two:e_two, parent_two:e_two.parent}
          end
          n += 1
        end

        differences
    end

  end
end
