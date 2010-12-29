require 'net/http'
require 'rexml/document'
require 'rubygems'
require 'xmlsimple'


# Build the URLs
semester = "2011/spring"
base_url = "http://courses.illinois.edu/cis/" + semester 
url = base_url + "/schedule/index.xml"

# Grab the response from the URL as a string
xml_data = Net::HTTP.get_response(URI.parse(url)).body

xml_data = "spring2011.xml"
# Turn the string into a hash of data 
catalog = XmlSimple.xml_in(xml_data)

# Iterate through the subjects found in the hash
catalog['subject'].each do |subject|
	print "-------\nSubject\n-------\n\n"

	# Build a url based off of the current subject code
	subjectURL = base_url + "/schedule/" + subject['subjectCode'].to_s + "/index.xml"
	
	# Fetch the courses for the subject and decrypt the data from the url
	subjectXML_data = Net::HTTP.get_response(URI.parse(subjectURL)).body
	subjectCourses = XmlSimple.xml_in(subjectXML_data)	

	# Iterate through the courses offered in the class 
	subjectCourses['subject'][0].each do |k, v|
		if not k == "course"
			print "\t\t<" + k + ">"+ v.to_s + "</"+ k+ ">\n"
		else
			v[0].each do |k, v|
#				print "\t\t<" + k + ">"+ v.to_s + "</"+ k+ ">\n"
			end
		end
	end

=begin
	# iterate through the elements of the subject 
	subject.each do |k,v|
		if (v.is_a?(Array))
			print "\t<" + k + ">"+ v.to_s + "</"+ k+ ">\n"
		end
	end
=end

	print "\n"
#	puts subject['subjectCode']
end
