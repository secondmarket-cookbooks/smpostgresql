Description
===========

This is SecondMarket's PostgreSQL "library" cookbook, supporting PostgreSQL 9.0.

Use this cookbook on SecondMarket "platform" servers only. For generic PostgreSQL servers, use the Opscode "postgresql" cookbook instead. The two are mutually exclusive.

Special Note
============

This cookbook is being released publicly as an illustration of how to create "application" cookbooks to overlay community cookbooks as "library cookbooks".

Internal SecondMarket ACLs, feature flags, etc. have been removed for security reasons.

What's a Library Cookbook and What's An Application Cookbook?
=============================================================

Read [Bryan Berry's blog post](http://devopsanywhere.blogspot.com/2012/11/how-to-write-reusable-chef-cookbooks.html) to get an overview.

SecondMarket's platform uses PostgreSQL 9.x, but the underlying operating systems (CentOS 5, CentOS 6) generally ship with PostgreSQL 8.x. Additionally, on "platform" servers we need to set up ACLs, PostgreSQL settings for master/slave replication, etc. and other miscellaneous tuning flags.

Platform
========

Supported only on CentOS 5 and 6, which we use.

Usage
=====

Including `smpostgresql::server` gets you most of what you need.

Credits
=======

* Author:: Julian Dunn (<jdunn@secondmarket.com>)
* Author:: Chris Ferry (<cferry@secondmarket.com>)      

Copyright:: 2012-2013 SecondMarket Labs, LLC.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
