require 'net/http'
require 'openssl'
require 'json'
require 'uri'

username= 'meadhikari'
password = 'bmeadhikari1740425'
repository_name = 'test'

def getCount(username,password,repository_name)
	uri = URI("https://bitbucket.org/api/1.0/repositories/#{username}/#{repository_name}/changesets?&limit=0")


	Net::HTTP.start(uri.host, uri.port,
  		:use_ssl => uri.scheme == 'https', 
  		:verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

  	request = Net::HTTP::Get.new uri.request_uri
  	request.basic_auth username, password

  	response = http.request request # Net::HTTPResponse object
    puts response
  	return JSON.parse(response.body)["count"]
	end
end
#SCHEDULER.every '10s', :first_in => 0 do |job|
	count = getCount(username,password,repository_name)
 puts count
#	send_event('bitbucket_commit_count_all', current: count)
#end


