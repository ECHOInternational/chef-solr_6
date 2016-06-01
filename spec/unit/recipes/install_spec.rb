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

    it 'should include the Java installer' do
      expect(chef_run).to include_recipe('java')
    end

    it 'should default the Java version to 8' do
      expect(chef_run.node['java']['jdk_version']).to eq('8')
    end

    it 'should default the Solr version to 6.0.0' do
      expect(chef_run.node['solr']['version']).to eq('6.0.0')
    end

    it 'should have a properly formatted source url for the Solr install' do
      expect(chef_run.node['solr']['url']).to eq(
        'https://archive.apache.org/dist/lucene/solr/6.0.0/solr-6.0.0.tgz'
      )
    end

    it 'should download the source archive for Solr if they do not exist' do
      expect(chef_run).to create_remote_file_if_missing(
        "#{Chef::Config['file_cache_path']}/solr-6.0.0.tgz"
      )
    end

    it 'should ensure that the specified group is created' do
      expect(chef_run).to create_group('solr')
    end

    it 'should not modify a group if root is specified' do
      chef_run.node.set['solr']['group'] = 'root'
      chef_run.converge(described_recipe)
      expect(chef_run).to_not create_group('root')
    end

    it 'should ensure that the specified user is created' do
      expect(chef_run).to create_user('solr')
    end

    it 'should not modify a user if root is specified' do
      chef_run.node.set['solr']['user'] = 'root'
      chef_run.converge(described_recipe)
      expect(chef_run).to_not create_user('root')
    end

    it 'should create the installation directory with proper ownership' do
      expect(chef_run).to create_directory('/opt/solr').with(
        user: 'solr',
        group: 'solr'
      )
    end

    it 'should create the data directory with proper ownership' do
      expect(chef_run).to create_directory('/var/solr').with(
        user: 'solr',
        group: 'solr'
      )
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
end
