#
# Cookbook Name:: smpostgresql
# Recipe:: slave
#
# Copyright (C) 2012-2013 SecondMarket Labs, LLC.
#
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

node.set['postgresql']['config']['hot_standby'] = true
# Slaves never need to generate their own WAL archive
node.override['postgresql']['config']['wal_level'] = 'minimal'

include_recipe "smpostgresql::server"

if Chef::Config['solo']
  Chef::Log.warn("Creating the recovery.conf requires search; Chef Solo doesn't support search.")
  return
end

master_members = search(:node, "role:#{node['smpostgresql']['slave']['master_role']} AND chef_environment:#{node.chef_environment}")

if master_members.nil?
  Chef::Log.error("Slave recipe loaded but no masters found in this environment")
  return
end

if master_members.length > 1
  Chef::Log.error("Slave recipe loaded but there is more than one master in this environment, which makes no sense")
  return
end

template "#{node['postgresql']['dir']}/recovery.conf" do
  source "recovery.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :restart, "service[postgresql]"
  variables(
    :master_member => master_members.slice(0)
  )
end
