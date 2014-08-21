require_relative '../lib/xml_helper/differences.rb'

describe XmlHelper::Differences do
  before(:all) do
    file_path_one = File.dirname(__FILE__) + '/resources/test_one.xml'
    file_path_two = File.dirname(__FILE__) + '/resources/test_two.xml' 
    
    @xml_diff = XmlHelper::Differences.new(file_path_one, file_path_two)

    @doc_one = @xml_diff.read_file_to_document(file_path_one)
    doc_two = @xml_diff.read_file_to_document(file_path_two)

    @elements_one = @xml_diff.get_array_of_elements(@doc_one)
    @elements_two = @xml_diff.get_array_of_elements(doc_two)
  end

  it "can reads file to a document" do
    elements = []
    @doc_one.traverse do |node|
      elements << node if node.class == Nokogiri::XML::Element
    end
    expect(elements.first.to_s).to eq("<test_node>test 1</test_node>")
  end

  it "returns an array of elements from an XML document" do
    elements = @xml_diff.get_array_of_elements(@doc_one)
    elements_string = "#{elements[0].to_s}#{elements[1].to_s}#{elements[2].to_s}#{elements[3].to_s}"

    expect(elements_string).to eq("<test_node>test 1</test_node><test_xml>\n  <test_node>test 1</test_node>\n</test_xml>")
  end

  it "returns the first path in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:path_one].to_s).to eq("my/testing/path/one.xml")
  end

  it "returns the first element in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:element_one].to_s).to eq("<test_node>test 1</test_node>")
  end
 
  it "returns the parent of the first element in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:parent_one].to_s).to eq("<test_xml>\n  <test_node>test 1</test_node>\n</test_xml>")
  end 

  it "returns the second path in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:path_two].to_s).to eq("my/testing/path/two.xml")
  end 

  it "returns the second element in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:element_two].to_s).to eq("<test_node>test 2</test_node>")
  end 

  it "returns the parent of the second element in the differences hash" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first[:parent_two].to_s).to eq("<test_xml>\n  <test_node>test 2</test_node>\n</test_xml>")
  end

    it "returns a differences hash with six key value pairs" do
    @diff_hash = @xml_diff.get_hash_array_of_differences(@elements_one, @elements_two, "my/testing/path/one.xml", "my/testing/path/two.xml")

    expect(@diff_hash.first.length).to eq(6)
  end 

end
