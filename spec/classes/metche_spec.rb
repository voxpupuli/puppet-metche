require 'spec_helper'

describe 'metche', type: :class do
  let(:title) { 'metche' }

  let :params_set do
    {
      changelog: '/home/foobar/changelog',
      watchdir: '/etc',
      dodetail: 'yes',
      test_time: '42',
      stable_time: '12',
      email: 'foobar@fooboozoo.fr',
      send_stable: 'yes',
      excludes: 'git'
    }
  end

  let(:params) do
    {
      owner: 'root'
    }
  end

  it { is_expected.to contain_package('metche') }

  it {
    is_expected.to contain_file('/etc/metche.conf').with(
      owner: params[:owner],
      group: params[:owner],
      mode: '0644'
    )
  }

  context 'With dopkg enabled' do
    let(:params) { { dopkg: 'yes' } }

    it do
      is_expected.to contain_package('apt-show-versions')
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{DO_PACKAGES="yes"})
    end
  end

  context 'Custom params' do
    let(:params) { params_set }

    it 'Custom metche params' do
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{CHANGELOG_FILE="#{params_set[:changelog]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{WATCHED_DIR="#{params_set[:watchdir]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{DO_DETAILS="#{params_set[:dodetail]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{TESTING_TIME="#{params_set[:test_time]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{STABLE_TIME="#{params_set[:stable_time]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{EMAIL_ADDRESS="#{params_set[:email]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{SEND_STABLE_REPORTS="#{params_set[:send_stable]}"})
      is_expected.to contain_file('/etc/metche.conf').with_content(%r{EXCLUDES="#{params_set[:excludes]}"})
    end
  end
end
