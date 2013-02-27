#
# Cookbook Name:: platform_settings_and_acls
# Recipe:: server
#
# Copyright 2012-2013, SecondMarket Labs, LLC.
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
#
# Set up ACLs (pg_hba) for SecondMarket platform database servers.

# This is similar to the default pg_hba array that postgresql::server uses, except
# that we use 'md5' instead of 'ident' in the second member (very important)
pg_hba = [
  {:type => 'local', :db => 'all', :user => 'postgres', :addr => nil, :method => 'ident'},
  {:type => 'local', :db => 'all', :user => 'all', :addr => nil, :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
  {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}
]

if Chef::Config['solo']
  Chef::Log.warn("This recipe requires search; Chef Solo doesn't support search.")
  return
end

slave_members = search(:node, "role:postgresql-slave AND chef_environment:#{node.chef_environment}")
svc_members = search(:node, "role:services AND chef_environment:#{node.chef_environment}")
mon_members = search(:node, "role:monitoring-server")
sfi_members = search(:node, "role:jitterbit-server AND chef_environment:#{node.chef_environment}")
sm_gateway = data_bag_item("ips", "nyc")['gateway']

slave_members.each do |member|
  pg_hba << {:type => 'host', :db => 'replication', :user => 'postgres', :addr => member['ipaddress'] + '/32', :method => 'trust'}
end

mon_members.each do |member|
  pg_hba << {:type => 'host', :db => 'postgres', :user => 'mon_user', :addr => member['ipaddress'] + '/32', :method => 'md5'}
end

svc_members.each do |member|
  %w{plat integration}.each do |db|
    pg_hba << {:type => 'host', :db => db + '_' + node.chef_environment, :user => db + '_' + node.chef_environment, :addr => member['ipaddress'] + '/32', :method => 'md5'}
  end
end

sfi_members.each do |member|
  pg_hba << {:type => 'host', :db => 'plat_' + node.chef_environment, :user => 'itg_admin', :addr => member['ipaddress'] + '/32', :method => 'md5'}
end

if node['smpostgresql']['server']['enable_sm_lan_access']
  %w{plat integration}.each do |db|
    pg_hba << {:type => 'host', :db => db + '_' + node.chef_environment, :user => db + '_' + node.chef_environment, :addr => '192.168.0.0/16', :method => 'md5'}
    pg_hba << {:type => 'host', :db => db + '_' + node.chef_environment, :user => db + '_' + node.chef_environment, :addr => sm_gateway + '/32', :method => 'md5'}
  end
end

if node['smpostgresql']['server']['enable_jenkins_access']
  %w{plat integration}.each do |db|
    pg_hba << {:type => 'host', :db => db + '_' + node.chef_environment, :user => db + '_' + node.chef_environment, :addr => '10.0.0.0/8', :method => 'md5'}
  end
end

# Do not delete the following for obvious reasons!
node.set['postgresql']['pg_hba'] = pg_hba
