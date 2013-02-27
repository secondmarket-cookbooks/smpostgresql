require File.expand_path('../support/helpers.rb', __FILE__)

describe 'smpostgresql::server' do

  include Helpers::Smpostgresql

  it 'installs the correct postgresql packages' do
    node['smpostgresql']['server']['packages'].each do |package_name|
      package(package_name).must_be_installed
    end
  end
  it 'has a data directory' do
    directory(node['smpostgresql']['dir']).must_exist.with(:owner, 'postgres').and(:group, 'postgres')
  end
  it 'runs as a daemon' do
    service(node['smpostgresql']['server']['service_name']).must_be_running
  end

end
