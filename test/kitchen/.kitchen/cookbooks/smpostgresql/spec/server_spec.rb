require 'spec_helper'
require 'chef/application'
require 'chef/config'

describe 'smpostgresql::server' do
  before do
    Fauxhai.mock(platform: 'centos', version: '6.3') 
  end
  let(:chef_run) {
      runner = ChefSpec::ChefRunner.new do |node|
        node.set['postgresql'] = Hash.new
        node.set['postgresql']['password'] = Hash.new
        node.set['postgresql']['password']['postgres'] = 'fake'
      end
      Chef::Config[:solo] = true
      runner.converge 'smpostgresql::server'
      runner
  }
  it 'should create a WAL archive directory' do
    chef_run.should create_directory "/var/lib/pgsql/9.0/archive"
  end
end
