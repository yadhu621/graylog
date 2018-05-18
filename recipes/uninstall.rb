# stop service
['mongod', 'elasticsearch', 'graylog-server'].each do |s|
  service s do
    action :stop
  end
end

# remove software
['java-1.8.0', 'mongodb-org', 'elasticsearch', 'graylog-server'].each do |pkg|
  package pkg do
    action :remove
  end
end

# remove folders