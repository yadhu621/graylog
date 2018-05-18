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


# copy config files
self_ipaddress = node['graylog']['ipaddress']
elasticsearch_port = node['elasticsearch']['port']
my_hash = { self_ipaddress: self_ipaddress, elasticsearch_port: elasticsearch_port }

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml'
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

