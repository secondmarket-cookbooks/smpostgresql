#
# Cookbook Name:: smpostgresql
# Recipe:: pgdg
#
# Copyright 2012-2013 SecondMarket Labs, LLC.
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

# At SecondMarket we're still using PostgreSQL 9.0. If/when we upgrade, we can deprecate
# this entire recipe and just use the out-of-the-box postgresql::yum_pgdg_postgresql

node.set['postgresql']['enable_pgdg_yum'] = true
node.set['postgresql']['version'] = "9.0"
node.set['postgresql']['dir'] = "/var/lib/pgsql/#{node['postgresql']['version']}/data"
node.set['postgresql']['client']['packages'] = ["postgresql#{node['postgresql']['version'].split('.').join}-devel"]
node.set['postgresql']['server']['packages'] = ["postgresql#{node['postgresql']['version'].split('.').join}-server"]
node.set['postgresql']['contrib']['packages'] = ["postgresql#{node['postgresql']['version'].split('.').join}-contrib"]
node.set['postgresql']['server']['service_name'] = "postgresql-#{node['postgresql']['version']}"

include_recipe "postgresql::yum_pgdg_postgresql"
