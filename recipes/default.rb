#
# Cookbook Name:: zookeeper
# Recipe:: default
#
# Copyright 2013, Takeshi KOMIYA
#
# All rights reserved - Do Not Redistribute
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "java"


zk_basename = "zookeeper-#{node[:zookeeper][:version]}"

group node[:zookeeper][:group]

user node[:zookeeper][:user] do
  gid node[:zookeeper][:group]
end

remote_file "#{Chef::Config[:file_cache_path]}/#{zk_basename}.tar.gz" do
  action :create_if_missing
  source node[:zookeeper][:mirror]
  mode "0644"
end

directory "/var/log/zookeeper" do
  owner node[:zookeeper][:user]
  group node[:zookeeper][:group]
  mode 0755
end

bash "install zookeeper" do
  user "root"
  cwd node[:zookeeper][:install_dir]
  code <<-EOH
    tar xzf #{Chef::Config[:file_cache_path]}/#{zk_basename}.tar.gz
  EOH
  creates "#{node[:zookeeper][:install_dir]}/#{zk_basename}"
end

template "/etc/init.d/zookeeper" do
  source "init-script.erb"
  owner "root"
  mode 0755
end

template "#{node[:zookeeper][:install_dir]}/#{zk_basename}/conf/zoo.cfg" do
  owner "root"
  mode 0644
  notifies :restart, "service[zookeeper]"
end

service "zookeeper" do
  supports :status => true, :restart => true
  action [:enable, :start]
end
