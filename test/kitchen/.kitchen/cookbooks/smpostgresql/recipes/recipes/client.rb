#
# Cookbook Name:: smpostgresql
# Recipe:: client
#
# Author:: Julian Dunn (<jdunn@secondmarket.com>)
# Author:: Joshua Timberman (<joshua@opscode.com>)
# Author:: Lamont Granquist (<lamont@opscode.com>)
#
# Copyright 2013 SecondMarket Labs, LLC.
# Copyright 2009-2011 Opscode, Inc.
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

include_recipe "smpostgresql::pgdg"
include_recipe "postgresql::client"
