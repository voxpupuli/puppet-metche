require 'spec_helper'

describe 'metche', :type => :class do
  let(:title) { 'metche' }
  let(:params) {{
    :owner => 'root',
  }}
  it { should contain_package('metche') }
  it { should contain_file('/etc/metche.conf').with(
        :owner => params[:owner],
        :group => params[:owner],
        :mode  => '0644'
  )}

  context 'With dopkg enabled' do
    let(:params) {{:dopkg => 'yes'}}
    it do
      should contain_package('apt-show-versions')
      should contain_file('/etc/metche.conf').with_content(/DO_PACKAGES="yes"/)
    end
  end

  context 'Custom params' do
    let(:params) do
      {
      :changelog    => '/home/foobar/changelog',
      :watchdir     => '/etc',
      :dodetail     => 'yes',
      :test_time    => '42',
      :stable_time  => '12',
      :email        => 'foobar@fooboozoo.fr',
      :send_stable  => 'yes',
      :excludes     => '*.git',
      }
    end
    it 'Custom metche params' do
      should contain_file('/etc/metche.conf').with_content(/CHANGELOG_FILE="\/home\/foobar\/changelog"/)
      should contain_file('/etc/metche.conf').with_content(/WATCHED_DIR="\/etc"/)
      should contain_file('/etc/metche.conf').with_content(/DO_DETAILS="yes"/)
      should contain_file('/etc/metche.conf').with_content(/TESTING_TIME="42"/)
      should contain_file('/etc/metche.conf').with_content(/STABLE_TIME="12"/)
      should contain_file('/etc/metche.conf').with_content(/EMAIL_ADDRESS="foobar@fooboozoo\.fr"/)
      should contain_file('/etc/metche.conf').with_content(/SEND_STABLE_REPORTS="yes"/)
      should contain_file('/etc/metche.conf').with_content(/EXCLUDES="\*.git"/)
    end
  end

end
