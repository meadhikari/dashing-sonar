require 'newrelic_api'

# Newrelic API key
key = 'fc0a984bcf5b4d18435db0fe742172d0ea8e4e060488bc7'

# Monitored application
app_name = 'Hybris-prd-ecom-app'

# Emitted metrics:
# - rpm_apdex
# - rpm_error_rate
# - rpm_throughput
# - rpm_errors
# - rpm_response_time
# - rpm_db
# - rpm_cpu
# - rpm_memory

NewRelicApi.api_key = key

SCHEDULER.every '10s', :first_in => 0 do |job|
  app = NewRelicApi::Account.find(:first).applications(:params =>
    {:conditions => {:name => app_name}}
  ).first

  app.threshold_values.each do |v|
    send_event("rpm_" + v.name.downcase.gsub(/ /, '_'), { value: v.metric_value })
  end

end
