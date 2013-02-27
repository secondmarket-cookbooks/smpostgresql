require 'spec_helper'

describe 'smpostgresql::pgfouine' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::pgfouine' }
  it 'should install pgfouine' do
    chef_run.should install_package 'pgfouine'
  end

end
