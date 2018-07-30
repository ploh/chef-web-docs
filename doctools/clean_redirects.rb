## written by Jerry Aldrich 

require 'json'

REDIRECTS_FILE = ARGV[0]
DOCS_DIRECTORY = '/home/jerry/Projects/github.com/chef/chef-web-docs'

data = JSON.parse(File.read(REDIRECTS_FILE))

rst_files = File.join(DOCS_DIRECTORY, '/chef_master/source/*.rst')
data.each do |k, v|
  found_match = false
  Dir.glob(rst_files).each do |file|
    #File.read(file).gsub(k, v)
    contents = File.read(file)
    if contents.match(k) || contents.match(v)
      found_match = true
      break
    end
  end

  unless found_match
    data.delete(k)
  end
end

puts 'Finished, writing output2.json'
IO.write('output2.json', data.to_json)
