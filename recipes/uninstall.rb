# stop services
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

# clean up
[
  '/etc/mongod.conf',
  '/etc/yum.repos.d/mongo.repo',
  '/etc/yum.repos.d/elasticsearch.repo',
  '/etc/yum.repos.d/graylog.repo',
].each do |f|
  file f do
    action :delete
  end
end

[
  '/etc/elasticsearch',
  '/etc/graylog/',
].each do |d|
  directory d do
    action :delete
    recursive true
  end
end
