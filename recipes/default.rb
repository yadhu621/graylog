#
# Cookbook:: graylog
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# deliver repo files
cookbook_file '/etc/yum.repos.d/mongo.repo' do
  source 'mongo.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/yum.repos.d/elasticsearch.repo' do
  source 'elasticsearch.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/yum.repos.d/graylog.repo' do
  source 'graylog.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# install software
['java-1.8.0', 'mongodb-org', 'elasticsearch', 'graylog-server'].each do |pkg|
  package pkg do
    action :install
  end
end


# config file parameters
host_ipaddress = node['graylog']['ipaddress']
elasticsearch_port = node['elasticsearch']['port']
mongodb_port = node['mongodb']['port']
my_hash = {
  host_ipaddress: host_ipaddress,
  elasticsearch_port: elasticsearch_port,
  mongodb_port: mongodb_port,
}

# deliver config files
template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'mongod'
  mode '0644'
  action :create
  variables (my_hash)
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'elasticsearch'
  mode '0644'
  action :create
  variables (my_hash)
end

# create folders

# start and enable service
['mongod', 'elasticsearch', 'graylog-server'].each do |s|
  service s do
    action [:start, :enable]
  end
end

