#
# Cookbook Name:: solr_6
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'solr_6::deploy' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'raises node value not specified error' do
      expect { chef_run }.to raise_error 'Required node value not specified'
    end
  end
  context 'When deploy_url is specified' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['solr']['deploy_url'] = 'http://www.nowhere.com/my_cores.tar'
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'does not have empty deploy_url' do
      expect(chef_run.node['solr']['deploy_url']).to_not eq('')
    end

    it 'to not raise warning' do
      expect(chef_run)
        .to_not write_log('solr_6::deploy was run with no deploy_url specified')
    end

    it 'downloads the core collection if it does not exist' do
      expect(chef_run).to create_remote_file_if_missing(
        "#{Chef::Config['file_cache_path']}/my_cores.tar"
      )
    end
  end
end
