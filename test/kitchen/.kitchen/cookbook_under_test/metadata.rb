name              "smpostgresql"
maintainer        "SecondMarket Labs, based on Opscode cookbook"
maintainer_email  "systems@secondmarket.com"
license           "Apache 2.0"
description       "Overlay cookbook over Opscode postgresql for various things that we like"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.7"
recipe            "smpostgresql", "Empty, use one of the other recipes"
recipe            "smpostgresql::client", "Installs postgresql client package(s)"
recipe            "smpostgresql::server", "Installs postgresql server packages, templates"
recipe            "smpostgresql::platform_db_creation", "Create default users and dbs"
recipe            "smpostgresql::pgfouine", "Installs pgfouine query analysis software"
recipe            "smpostgresql::pgbadger", "Installs pgbadger query analysis software"

%w{rhel centos}.each do |os|
  supports os
end

depends           "postgresql", "~> 2.2.2"
