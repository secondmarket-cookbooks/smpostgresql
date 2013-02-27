require 'spec_helper'

describe 'smpostgresql::default' do
  before do
    Fauxhai.mock(platform: 'centos', version: '6.3') 
  end
  it 'should do nothing' do
    chef_run = ChefSpec::ChefRunner.new.converge 'smpostgresql::default'
    chef_run.should_not log 'anything'
  end
end
