require 'chefspec'

describe 'smpostgresql::platform_postgresql_conf' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::platform_postgresql_conf' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
