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
host_ipaddress = node['host']['ipaddress']
elasticsearch_port = node['elasticsearch']['port']
mongodb_port = node['mongodb']['port']
password_secret = node['graylog']['password_secret']
password_sha2 = node['graylog']['password_sha2']
public_ipaddress = node['host']['public_ipaddress']
my_param_hash = {
  host_ipaddress: host_ipaddress,
  elasticsearch_port: elasticsearch_port,
  mongodb_port: mongodb_port,
  password_secret: password_secret,
  password_sha2: password_sha2,
  public_ipaddress: public_ipaddress
}

# deliver config files
template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'mongod'
  mode '0644'
  action :create
  notifies :restart, 'service[mongod]', :immediately
  variables (my_param_hash)
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'elasticsearch'
  mode '0644'
  action :create
  notifies :restart, 'service[elasticsearch]', :immediately
  variables (my_param_hash)
end

template '/etc/graylog/server/server.conf' do
  source 'server.conf.erb'
  owner 'elasticsearch'
  mode '0644'
  action :create
  notifies :restart, 'service[graylog-server]', :immediately
  variables (my_param_hash)
end

# create folders

# start and enable service
['mongod', 'elasticsearch', 'graylog-server'].each do |s|
  service s do
    action [:start, :enable]
  end
end

