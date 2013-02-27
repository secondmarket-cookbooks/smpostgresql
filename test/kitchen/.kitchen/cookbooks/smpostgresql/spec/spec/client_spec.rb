require 'chefspec'

describe 'smpostgresql::client' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::client' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
