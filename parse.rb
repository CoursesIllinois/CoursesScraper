require 'net/http'
require 'rexml/document'

url = "http://courses.illinois.edu/cis/2011/spring/schedule/index.xml"

xml_data = Net::HTTP.get_response(URI.parse(url)).body

puts xml_data

