#
# Cookbook Name:: solr_6
# Recipe:: install
#
# Copyright (c) 2016 ECHO Inc, All Rights Reserved.

include_recipe 'java' if node['solr']['install_java']

# Solr Installation script reuquires lsof on Red Hat
yum_package 'lsof' if platform_family?('rhel')

src_filename = ::File.basename(node['solr']['url'])
src_filepath = "#{Chef::Config['file_cache_path']}/#{src_filename}"
# solr_home = "#{node['solr']['data_dir']}/data"

# Download Solr
remote_file src_filepath do
  source node['solr']['url']
  action :create_if_missing
end

# Create Group (unless it is root)
group node['solr']['group'] do
  not_if { node['solr']['group'] == 'root' }
end

# Create User (unless it is root)
user node['solr']['user'] do
  group node['solr']['group']
  not_if { node['solr']['user'] == 'root' }
end

# Create Data Dir
directory node['solr']['data_dir'] do
  owner node['solr']['user']
  group node['solr']['group']
  recursive true
  action :create
end

# Create Installation Dir
directory node['solr']['dir'] do
  owner node['solr']['user']
  group node['solr']['group']
  recursive true
  action :create
end

# Unpack Solr Install Script
bash 'unpack_solr_install_script' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
		tar xzf #{src_filename} solr-#{node['solr']['version']}/bin/install_solr_service.sh --strip-components=2
	EOH
  not_if { ::File.exist?('install_solr_service.sh') }
end

# Install and start Solr
bash 'install_and_start_solr' do
  cwd ::File.dirname(src_filepath)
  code <<-EOH
		./install_solr_service.sh #{src_filename} -u #{node['solr']['user']} -p #{node['solr']['port']} -d #{node['solr']['data_dir']} -i #{node['solr']['dir']} -f
	EOH
end
