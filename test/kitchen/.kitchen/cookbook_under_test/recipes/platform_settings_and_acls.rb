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
# Set up ACLs (pg_hba) and postgresql server config for platform database servers.

include_recipe "smpostgresql::server"

if Chef::Config['solo']
  Chef::Log.warn("This recipe requires search; Chef Solo doesn't support search.")
  return
end

svc_members = search(:node, "role:services AND chef_environment:#{node.chef_environment}")
slave_members = search(:node, "role:postgresql-slave AND chef_environment:#{node.chef_environment}")
mon_members = search(:node, "role:monitoring-server")
sfi_members = search(:node, "role:jitterbit-server AND chef_environment:#{node.chef_environment}")
sm_gateway = data_bag_item("ips", "nyc")['gateway']

template "#{node['smpostgresql']['dir']}/pg_hba.conf" do
  source "pg_hba.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :reload, "service[smpostgresql]"
  variables(
    :svc_members => svc_members.uniq,
    :mon_members => mon_members.uniq,
    :slave_members => slave_members.uniq,
    :sfi_members => sfi_members.uniq,
    :sm_gateway => sm_gateway
  )
end

template "#{node['smpostgresql']['dir']}/postgresql.conf" do
  source "postgresql.conf.erb"
  owner "postgres"
  group "postgres"
  mode 0600
  notifies :restart, "service[smpostgresql]"
end
