#
# Cookbook Name:: smpostgresql
# Recipe:: platform_postgresql_conf
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
# Set up settings that we want in postgresql.conf on platform database servers.

node.set['postgresql']['config']['listen_addresses'] = '*'
node.set['postgresql']['config']['max_connections'] = '256'

# override this to 'minimal' in situations where you don't need full
# WAL archiving, e.g. the slave
node.set['postgresql']['config']['wal_level'] = 'hot_standby'
unless node['postgresql']['config']['wal_level'] == 'minimal'
  node.set['postgresql']['config']['archive_mode'] = true
  node.set['postgresql']['config']['max_wal_senders'] = '5'
  node.set['postgresql']['config']['wal_keep_segments'] = '32'
end

node.set['postgresql']['config']['archive_command'] = "cp %p /var/lib/pgsql/#{node['postgresql']['version']}/archive/%f"

# logging - we like to log to syslog
node.set['postgresql']['config']['log_destination'] = 'syslog'
node.set['postgresql']['config']['syslog_facility'] = 'LOCAL0'
node.set['postgresql']['config']['syslog_ident'] = 'postgres'
node.set['postgresql']['config']['client_min_messages'] = 'notice'
node.set['postgresql']['config']['log_min_messages'] = 'warning'
node.set['postgresql']['config']['log_min_duration_statement'] = '100'
node.set['postgresql']['config']['log_line_prefix'] = '%t %d %u %h '
# node.set['postgresql']['config']['track_counts'] = 'on' # already on by default
node.set['postgresql']['config']['autovacuum'] = true
node.set['postgresql']['config']['log_autovacuum_min_duration'] = '-1'

