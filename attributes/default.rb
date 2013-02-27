#
# Cookbook Name:: smpostgresql
# Attributes:: postgresql
#
# Copyright (C) 2012-2013, SecondMarket Labs, LLC.
# Copyright 2008-2009, Opscode, Inc.
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

# Attributes specific to this cookbook
default['smpostgresql']['server']['wal_level']            = 'minimal'
default['smpostgresql']['server']['hot_standby']          = false
default['smpostgresql']['server']['enable_sm_lan_access'] = false
default['smpostgresql']['server']['enable_jenkins_access'] = false

default['smpostgresql']['pgfouine']['enabled'] = false
default['smpostgresql']['pgfouine']['email'] = 'dba@secondmarket.com'

default['smpostgresql']['slave']['master_role'] = 'postgresql-master'
