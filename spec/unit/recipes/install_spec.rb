# frozen_string_literal: true
#
# Cookbook Name:: solr_6
# Spec:: install
#
# Copyright (c) 2016 ECHO Inc, All Rights Reserved.

require 'spec_helper'

describe 'solr_6::install' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'includes the yum package' do
      expect(chef_run).to include_recipe('yum')
    end

    it 'includes the Java installer' do
      expect(chef_run).to include_recipe('java')
    end

    it 'defaults the Java version to 8' do
      expect(chef_run.node['java']['jdk_version']).to eq('8')
    end

    it 'defaults the Solr version to 6.0.1' do
      expect(chef_run.node['solr']['version']).to eq('6.0.1')
    end

    it 'has a properly formatted source url for the Solr install' do
      expect(chef_run.node['solr']['url']).to eq(
        'https://archive.apache.org/dist/lucene/solr/6.0.1/solr-6.0.1.tgz'
      )
    end

    it 'downloads the source archive for Solr if they do not exist' do
      expect(chef_run).to create_remote_file_if_missing(
        "#{Chef::Config['file_cache_path']}/solr-6.0.1.tgz"
      )
    end

    it 'ensures that the specified group is created' do
      expect(chef_run).to create_group('solr')
    end

    it 'does not modify a group if root is specified' do
      chef_run.node.set['solr']['group'] = 'root'
      chef_run.converge(described_recipe)
      expect(chef_run).to_not create_group('root')
    end

    it 'ensures that the specified user is created' do
      expect(chef_run).to create_user('solr')
    end

    it 'does not modify a user if root is specified' do
      chef_run.node.set['solr']['user'] = 'root'
      chef_run.converge(described_recipe)
      expect(chef_run).to_not create_user('root')
    end

    it 'creates the data directory with proper ownership' do
      expect(chef_run).to create_directory('/var/solr').with(
        user: 'solr',
        group: 'solr'
      )
    end

    it 'creates the include file directory if it does not exist' do
      expect(chef_run).to create_directory('/etc/default').with(
        user: 'root'
      )
    end

    it 'creates proper solr.in.sh template' do
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_PID_DIR="/var/solr"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_HOME="/var/solr/data"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('LOG4J_PROPS="/var/solr/log4j.properties"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_LOGS_DIR="/var/solr/logs"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_PORT="8983"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_JAVA_MEM="-Xms512m -Xmx512m"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_HOST="chefspec.local"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_TIMEZONE="UTC"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#ZK_HOST=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#ZK_CLIENT_TIMEOUT="15000"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content("GC_LOG_OPTS=\"-verbose:gc \
-XX:+PrintHeapAtGC \
-XX:+PrintGCDetails \
-XX:+PrintGCDateStamps \
-XX:+PrintGCTimeStamps \
-XX:+PrintTenuringDistribution \
-XX:+PrintGCApplicationStoppedTime\"")
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('ENABLE_REMOTE_JMX_OPTS="false"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#RMI_PORT="18983"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content('SOLR_OPTS="-Xss256k"')
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content("GC_TUNE=\"-XX:NewRatio=3 \
-XX:SurvivorRatio=4 \
-XX:TargetSurvivorRatio=90 \
-XX:MaxTenuringThreshold=8 \
-XX:+UseConcMarkSweepGC \
-XX:+UseParNewGC \
-XX:ConcGCThreads=4 -XX:ParallelGCThreads=4 \
-XX:+CMSScavengeBeforeRemark \
-XX:PretenureSizeThreshold=64m \
-XX:+UseCMSInitiatingOccupancyOnly \
-XX:CMSInitiatingOccupancyFraction=50 \
-XX:CMSMaxAbortablePrecleanTime=6000 \
-XX:+CMSParallelRemarkEnabled \
-XX:+ParallelRefProcEnabled\"")
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_AUTHENTICATION_CLIENT_CONFIGURER=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_AUTHENTICATION_OPTS=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_KEY_STORE=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_KEY_STORE_PASSWORD=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_TRUST_STORE=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_TRUST_STORE_PASSWORD=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_NEED_CLIENT_AUTH=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_WANT_CLIENT_AUTH=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_CLIENT_KEY_STORE=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_CLIENT_KEY_STORE_PASSWORD=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_CLIENT_TRUST_STORE=""/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^#SOLR_SSL_CLIENT_TRUST_STORE_PASSWORD=""/)
    end
  end
  context 'when a zookeeper host is specified' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['zk_host'] = 'zk1,zk2,zk3'
      end
      runner.converge(described_recipe)
    end

    it 'creates proper solr.in.sh template' do
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^ZK_HOST="zk1,zk2,zk3"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^ZK_CLIENT_TIMEOUT="15000"/)
    end
  end
  context 'solr authentication settings are specified' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['solr_authentication_client_configurer'] = 'foo'
        node.set['solr']['solr_authentication_opts'] = 'bar'
      end
      runner.converge(described_recipe)
    end

    it 'creates proper solr.in.sh template' do
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_AUTHENTICATION_CLIENT_CONFIGURER="foo"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_AUTHENTICATION_OPTS="bar"/)
    end
  end
  context 'when ssl settings are specified' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['solr_ssl_key_store'] = 'abc'
        node.set['solr']['solr_ssl_key_store_password'] = 'def'
        node.set['solr']['solr_ssl_trust_store'] = 'ghi'
        node.set['solr']['solr_ssl_trust_store_password'] = 'jkl'
        node.set['solr']['solr_ssl_need_client_auth'] = true
        node.set['solr']['solr_ssl_want_client_auth'] = false
        node.set['solr']['solr_ssl_client_key_store'] = 'mno'
        node.set['solr']['solr_ssl_client_key_store_password'] = 'pqr'
        node.set['solr']['solr_ssl_client_trust_store'] = 'stu'
        node.set['solr']['solr_ssl_client_trust_store_password'] = 'vwx'
      end
      runner.converge(described_recipe)
    end

    it 'creates proper solr.in.sh template' do
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_KEY_STORE="abc"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_KEY_STORE_PASSWORD="def"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_TRUST_STORE="ghi"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_TRUST_STORE_PASSWORD="jkl"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_NEED_CLIENT_AUTH="true"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_WANT_CLIENT_AUTH="false"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_CLIENT_KEY_STORE="mno"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_CLIENT_KEY_STORE_PASSWORD="pqr"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_CLIENT_TRUST_STORE="stu"/)
      expect(chef_run)
        .to render_file('/etc/default/solr.in.sh')
        .with_content(/^SOLR_SSL_CLIENT_TRUST_STORE_PASSWORD="vwx"/)
    end
  end
  context 'when on RedHat' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'redhat', version: '6.3')
      runner.converge(described_recipe)
    end

    it 'should include the lsof installer' do
      expect(chef_run).to install_yum_package('lsof')
    end
  end
  context 'when on Ubuntu' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04')
      runner.converge(described_recipe)
    end

    it 'should not include the lsof installer' do
      expect(chef_run).to_not install_yum_package('lsof')
    end
  end
  context 'when on RedHat' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new(platform: 'redhat', version: '6.3')
      runner.converge(described_recipe)
    end

    it 'should include the lsof installer' do
      expect(chef_run).to install_yum_package('lsof')
    end
  end
  context 'when create_user is false' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['create_user'] = false
      end
      runner.converge(described_recipe)
    end

    it 'should not create the specified user' do
      expect(chef_run).to_not create_user('solr')
    end
  end
  context 'when create_group is false' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['create_group'] = false
      end
      runner.converge(described_recipe)
    end

    it 'should not create the specified user' do
      expect(chef_run).to_not create_group('solr')
    end
  end
end
