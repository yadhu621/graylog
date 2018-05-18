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


# install softwares
# copy config files
# create folders
# start and enable service
