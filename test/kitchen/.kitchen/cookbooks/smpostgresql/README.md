= DESCRIPTION:

This is SecondMarket's bespoke PostgreSQL cookbook, supporting PostgreSQL 9.0 and 9.2.

Use this cookbook on "platform" servers only (those supporting the Mercury application and its ilk). For generic PostgreSQL servers, use the Opscode "postgresql" cookbook instead. The two are mutually exclusive.

= WHY A BESPOKE POSTGRESQL COOKBOOK?

SecondMarket's platform uses PostgreSQL 9.x, but the underlying operating systems (CentOS 5, CentOS 6) generally ship with PostgreSQL 8.x. The Opscode cookbook doesn't have a good way of overriding this yet (supporting the library vs. application cookbook model)

== Platform:

Supported only on CentOS 5 and 6, which we use.

== Cookbooks:

= USAGE:

The client recipe has been ripped out of this cookbook. If it's needed, you can look in Git to put it back.
  
For server: 

  include_recipe "smpostgresql::server"
  
= CREDITS:

This was forked from an old version of Opscode's PostgreSQL cookbook and heavily modified by SecondMarket to handle Mercury platform features.

Author:: Julian Dunn (<jdunn@secondmarket.com>)
Author:: Chris Ferry (<cferry@secondmarket.com>)      
Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright:: 2009-2010, Opscode, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
