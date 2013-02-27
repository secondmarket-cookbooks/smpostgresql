#
# Cookbook Name:: smpostgresql
# Recipe:: server
#
# Copyright 2012-2013, SecondMarket Labs, LLC.
# Copyright 2009-2010, Opscode, Inc.
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

# Ordering here is very important.
# 1. pgdg is to set up the attributes to overlay Opscode's postgresql cookbook
#    with the version of PostgreSQL we want
# 2. then invoke the platform_postgresql and platform_pg_hba recipes to
#    override Opscode attributes with results from our searches
# 3. once all attribs are set, then call Opscode's recipe

include_recipe "smpostgresql::pgdg"
include_recipe "smpostgresql::platform_pg_hba"
include_recipe "smpostgresql::platform_postgresql_conf"
include_recipe "postgresql::server"
include_recipe "postgresql::contrib"

# For WAL archives. Maybe we can turn it off eventually if we parameterize WAL archiving
directory "/var/lib/pgsql/#{node['postgresql']['version']}/archive" do
   action :create
   owner "postgres"
   group "postgres"
   mode 00700
end

# Logrotate setup - consider invoking logrotate cookbook and LWRP down the road
template "/etc/logrotate.d/postgresql" do
  source "postgresql.logrotate.erb"
  mode 00644
  owner "root"
  group "root"
end
