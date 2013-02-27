#
# Cookbook Name:: smpostgresql
# Recipe:: pgfouine
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
# Install pgfouine on a server. You should probably use pgbadger on newer servers; this is for legacy.

include_recipe "smpostgresql::pgdg"

package "pgfouine" do
  action :install
end

template "/var/lib/pgsql/pgfouine_process" do
  source "pgfouine_process.erb"
  mode 00755
  owner "root"
  group "root"
end
