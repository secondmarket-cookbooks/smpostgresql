require 'chefspec'

describe 'smpostgresql::platform_pg_hba' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'smpostgresql::platform_pg_hba' }
  it 'should do something' do
    pending 'Your recipe examples go here.'
  end
end
