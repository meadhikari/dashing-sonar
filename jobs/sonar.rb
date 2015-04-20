require 'net/http'
require 'json'
 
server = "http://logstashserver7.cloudapp.net:9000"
key = "java-sonar-runner-simple"
id = "id"
 
SCHEDULER.every '10s', :first_in => 0 do |job|
    uri = URI("#{server}/api/resources?resource=#{key}&metrics=ncloc,sqale_rating,classes,complexity,sqale_index&format=json")
	res = Net::HTTP.get(uri)
	j = JSON[res][0]['msr']
 
	send_event(id, { items: 
		[{ label: 'nloc', value: j[0]['frmt_val'] },
		{label:'Classes', value:j[1]['frmt_val']},
		{label:'Complexity', value:j[2]['frmt_val']},
		{label:'Debt', value:j[3]['frmt_val']},
		{label:'Rating', value:j[4]['frmt_val']}
		]})
end
