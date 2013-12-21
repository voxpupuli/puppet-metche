require 'spec_helper'

describe 'metche', :type => :class do
  let(:title) { 'metche' }

  let :params_set do
    {
      :changelog    => '/home/foobar/changelog',
      :watchdir     => '/etc',
      :dodetail     => 'yes',
      :test_time    => '42',
      :stable_time  => '12',
      :email        => 'foobar@fooboozoo.fr',
      :send_stable  => 'yes',
      :excludes     => 'git',
    }
  end

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
    let(:params) { params_set }
    it 'Custom metche params' do
      should contain_file('/etc/metche.conf').with_content(/CHANGELOG_FILE="#{params_set[:changelog]}"/)
      should contain_file('/etc/metche.conf').with_content(/WATCHED_DIR="#{params_set[:watchdir]}"/)
      should contain_file('/etc/metche.conf').with_content(/DO_DETAILS="#{params_set[:dodetail]}"/)
      should contain_file('/etc/metche.conf').with_content(/TESTING_TIME="#{params_set[:test_time]}"/)
      should contain_file('/etc/metche.conf').with_content(/STABLE_TIME="#{params_set[:stable_time]}"/)
      should contain_file('/etc/metche.conf').with_content(/EMAIL_ADDRESS="#{params_set[:email]}"/)
      should contain_file('/etc/metche.conf').with_content(/SEND_STABLE_REPORTS="#{params_set[:send_stable]}"/)
      should contain_file('/etc/metche.conf').with_content(/EXCLUDES="#{params_set[:excludes]}"/)
    end
  end

end
