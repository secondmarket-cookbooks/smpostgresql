require 'spec_helper'

describe 'smpostgresql::pgbadger' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::pgbadger' }
  it 'should install pgbadger' do
    chef_run.should install_package 'pgbadger'
  end
end
