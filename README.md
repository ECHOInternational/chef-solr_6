# solr_6

Cookbook to install, configure, and start a Solr server (version 6).

There is no magic here, since 5.?.? Solr has come with its own installation script, this cookbook simply prepares an appropriate environment and executes that install script.

## Recipes

 - `install` - This will optionally install java, download Solr, install, and start the server.

## Attributes

```
 - node['solr']['install_java'] 	# Install the Java Virtual Machine - Default: True
 - node['solr']['version'] 			# Version of Solr to install - Default: '6.0.0'
 - node['solr']['url']     	 		# Location of the Solr source files. - Default: Determined from version specified.
 - node['solr']['dir']     	 		# Where to install Solr. Default:'/opt/solr'
 - node['solr']['user'] 			# User that owns the Solr Process. Default: 'solr'
 - node['solr']['group'] 			# User Group that owns the Solr Process. Default: 'solr'
 - node['solr']['data_dir'] 		# Solr Data Directory. Default: '/var/solr' (a 'data' folder will be appended)
 - node['solr']['port'] 			# Solr port. Default: '8983'
```
This recipe will automatically install JDK v1.8 from the community cookbook unless `node['solr']['install_java']` is set to false. The java verson can be changed by overriding `node['java']['jdk_version']`


## Supports
 - Debian
 - Ubuntu
 - CentOS
 - Red Hat
 - Amazon