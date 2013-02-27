require File.expand_path('../support/helpers.rb', __FILE__)

describe 'smpostgresql::pgdg' do

  include Helpers::Smpostgresql

  it 'installs the pgdg key' do
    file("/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-#{node['smpostgresql']['version'].split('.').join}").must_exist
  end

  it 'installs the pgdg repo' do
    file("/etc/yum.repos.d/pgdg#{node['smpostgresql']['version'].split('.').join}.repo").must_exist
  end

end
