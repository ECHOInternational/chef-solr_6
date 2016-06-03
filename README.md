# solr_6

Cookbook to install, configure, and start a Solr server (version 6).

Solr 6 comes prepackaged with its own installation script, this cookbook simply prepares an appropriate environment and executes that install script.

## Recipes

 - `install` - This will optionally install java, download Solr, install, and start the server.

## Attributes

### Java
 - `node['solr']['install_java']`
 	- Install the Java Virtual Machine
 	- **Default:** "true"

This recipe will automatically install JDK v1.8 from the community cookbook unless `node['solr']['install_java']` is set to false. The java verson can be changed by overriding `node['java']['jdk_version']`

### Solr

 - `node['solr']['version']`
 	- Version of Solr to install
 	- **Default:** '6.0.0'
 - `node['solr']['url']`
 	- Remote location of the Solr source files
 	- **Default:** Automatically determined from version specified.
 - `node['solr']['dir']`
 	- Where to install Solr
 	- **Default:** '/opt/solr'
 - `node['solr']['user']`
 	- User that owns the Solr process
 	- **Default:** 'solr'
 - `node['solr']['group']`
 	- User Group that owns the Solr process
 	- **Default:** 'solr'
 - `node['solr']['data_dir']`
 	 - Solr Data Directory.
 	 - **Default:** '/var/solr'
 	 - Note: a 'data' folder will be appended which will be the SOLR_HOME location
 - `node['solr']['port']`
 	 - Solr port
 	 - **Default:** '8983'
 - `node['solr']['java_mem']`
 	- Amount of memory to allocate to Solr
 	- **Default:** '-Xms512m -Xmx512m'
 - `node['solr']['host']`
 	- Host Name for this Solr instance
 	- **Default:** The FQDN of the machine
 - `node['solr']['timezone']`
 	- Solr Timezone
 	- **Default:** UTC
 - `node['solr']['zk_host']`
 	- Zookeeper Host
 	- **Default:** ""
 	- Note: If this is an empty string then zookeeper is disabled.
 - `node['solr']['zk_client_timeout']`
 	- The ZooKeeper client timeout (for SolrCloud mode)
 	- **Default:** "15000"
 - `node['solr']['gc_log_opts']`
 	- Logging options string.
 	- Defaults to verbose settings (see attributes/install.rb)
 - `node['solr']['enable_remote_jmx_opts']`
 	- Activate the JMX RMI connector to allow remote JMX client applications
	- to monitor the JVM hosting Solr; set to "false" to disable that behavior
	- **Default:** "false" (*recommended in production environments*)


## Supports
 - Ubuntu
 - CentOS
 - Red Hat
 - Amazon
 - Fedora

Java 8 is not currently installable on Debian with the Java community Chef recipe. Debian could be supported if Java 8 is installed manually.

## Todo

Finish solr.in.sh.erb template file to include all options

### Overwrite the solrconfig.xml

Provide a location to download an alternate solrconfig.xml file

### Cores - Non Solr cloud

Provide a location to download a preconfigured core
