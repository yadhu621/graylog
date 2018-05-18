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
  source 'mongo.repo'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/yum.repos.d/graylog.repo' do
  source 'mongo.repo'
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
# create folders

# start and enable service
['mongod', 'elasticsearch', 'graylog-server'].each do |s|
  service s do
    action [:start, :enable]
  end
end

