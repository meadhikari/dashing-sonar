require 'net/http'
require 'openssl'
require 'json'
def getResult(jobname)
 uri = URI("https://jenkins-dev.medicanimal.com/job/#{jobname}/lastBuild/api/json")

 Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https', 
    :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|

   request = Net::HTTP::Get.new uri.request_uri
   request.basic_auth 'anjani.phuyal', 'Mulp@ni009'

   response = http.request request # Net::HTTPResponse object

   return  JSON.parse(response.body)["result"]
 end
end
def event_sender(jobname)
 sf = getResult(jobname)
 color = case sf
    when "FAILURE" then 'danger'
    when "SUCCESS" then 'ok'
 end
  send_event(jobname, {current: sf, status: color, title: jobname})
end

SCHEDULER.every '2s', :first_in => 0 do |job|
 event_sender('hybris5_feature_branch_build_manual')
 event_sender('Hybris5systest')
 event_sender('Restart%20SYSTEST')
end
