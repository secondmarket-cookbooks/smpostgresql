require 'chefspec'

describe 'smpostgresql::platform_db_creation' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::platform_db_creation' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
