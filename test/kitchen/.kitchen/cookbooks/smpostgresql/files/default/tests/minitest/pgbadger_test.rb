require File.expand_path('../support/helpers.rb', __FILE__)

describe 'smpostgresql::pgbadger' do

  include Helpers::Smpostgresql

  it 'installs the pgbadger package' do
    package('pgbadger').must_be_installed
  end

end
