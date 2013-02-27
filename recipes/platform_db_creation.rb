#
# Cookbook Name:: smpostgresql
# Recipe:: platform_db_creation
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

#On initial postgres install this recipe fails as postgres just initdb'd and is not up and listening yet.
# So we need to wait a bit until it comes online
ruby_block "netstat" do
  block do
    10.times do
      if IO.popen("netstat -lnt").entries.select { |entry|
          entry.split[3] =~ /:5432$/
        }.size > 0
        break
      end
      Chef::Log.debug("service[postgresql] still not listening (port 5432)")
      sleep 1
    end
  end
  action :create
end

# mon_user creation
mon_user_password = Chef::EncryptedDataBagItem.load("smpostgresql", "mon_user")['password']

execute "create-mon-database-user" do
    user "postgres"
    command "psql -U postgres -t -c \"CREATE ROLE mon_user PASSWORD '#{mon_user_password}' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;GRANT USAGE ON SCHEMA public TO mon_user\""
    not_if 'psql -U postgres -c "SELECT * FROM pg_user WHERE usename=\'mon_user\'" | grep mon_user', :user => "postgres"
end

plat_dbname   = "OBFUSCATED-FOR-GITHUB-PUBLISHING"
integration_dbname   = "OBFUSCATED-FOR-GITHUB-PUBLISHING"

# By default, the usernames for each database are the same as the DB, except in production and staging
plat_password = Chef::EncryptedDataBagItem.load("smpostgresql", plat_dbname)['password']
integration_password = Chef::EncryptedDataBagItem.load("smpostgresql", integration_dbname)['password']

# Plat
execute "create-plat-database-user" do
    user "postgres"
    command "psql -U postgres -t -c \"CREATE ROLE #{plat_dbname} PASSWORD '#{plat_password}' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;GRANT USAGE ON SCHEMA public TO #{plat_dbname}\""
    not_if  "psql -U postgres -c \"SELECT * FROM pg_user WHERE usename='#{plat_dbname}'\" | grep #{plat_dbname}", :user => "postgres"
end

execute "create-plat-database" do
    user "postgres"
    command "createdb -U postgres -O #{plat_dbname} -E utf8 -T template0 #{plat_dbname}"
    not_if  "psql -U postgres -c \"SELECT * FROM pg_database WHERE datname='#{plat_dbname}'\" | grep #{plat_dbname}", :user => "postgres"
end
    
# Integration
execute "create-integration-database-user" do
    user "postgres"
    command "psql -U postgres -t -c \"CREATE ROLE #{integration_dbname} password '#{integration_password}' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN; GRANT USAGE ON SCHEMA public TO #{integration_dbname}\""
    not_if  "psql -U postgres -c \"SELECT * from pg_user WHERE usename='#{integration_dbname}'\" | grep #{integration_dbname}", :user => "postgres"
end

execute "create-integration-database" do
    user "postgres"
    command "createdb -U postgres -O #{integration_dbname} -E utf8 -T template0 #{integration_dbname}"
    not_if  "psql -U postgres -c \"SELECT * from pg_database WHERE datname='#{integration_dbname}'\" | grep #{integration_dbname}", :user => "postgres"
end
