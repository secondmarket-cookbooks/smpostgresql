#
# Cookbook Name:: smpostgresql
# Recipe:: platform_pg_hba
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

slave_members.each do |member|
  pg_hba << {:type => 'host', :db => 'replication', :user => 'postgres', :addr => member['ipaddress'] + '/32', :method => 'trust'}
end

# Rest of ACL recipe elided due to security reasons for publishing on Github

# Do not delete the following for obvious reasons!
node.set['postgresql']['pg_hba'] = pg_hba
