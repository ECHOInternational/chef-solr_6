# solr_6 Cookbook

[![Coverage Status](https://coveralls.io/repos/github/ECHOInternational/chef-solr_6/badge.svg?branch=master)](https://coveralls.io/github/ECHOInternational/chef-solr_6?branch=master) [![Build Status](https://travis-ci.org/ECHOInternational/chef-solr_6.svg?branch=master)](https://travis-ci.org/ECHOInternational/chef-solr_6)

Cookbook to install, configure, and start a Solr server (version 6).

Solr 6 comes prepackaged with its own installation script, this cookbook simply prepares an appropriate environment and executes that install script.

## Recipes

 - `solr_6::install`    - This will install Java (optional), download Solr, configure, install,
                        and start the server.
 - `solr_6::deploy`     - This will download a tarball containing one or more solr cores to the
                        SOLR_HOME directory and restart the server. This is useful for bootstraping Solr when not using Solr Cloud.

## Attributes

### Java
 - `node['solr']['install_java']`
    - Install the Java Virtual Machine
    - **Default:** "true"

This recipe will automatically install JDK v1.8 from the community cookbook unless `node['solr']['install_java']` is set to false. The java verson can be changed by overriding `node['java']['jdk_version']`

### Solr
#### Installation
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
     - Solr Data Directory
     - **Default:** '/var/solr'
     - Note: a 'data' folder will be appended which will be the SOLR_HOME location

#### Configuation
##### General
 - `node['solr']['host']`
    - Host Name for this Solr instance
    - **Default:** The FQDN of the machine
 - `node['solr']['port']`
    - Solr port
    - **Default:** '8983'
 - `node['solr']['timezone']`
    - Solr Timezone
    - **Default:** 'UTC'

##### Solr Cloud
 - `node['solr']['zk_host']`
    - Zookeeper Host
    - **Default:** "" (Disabled)
 - `node['solr']['zk_client_timeout']`
    - The ZooKeeper client timeout
    - **Default:** '15000'

##### Performance
 - `node['solr']['java_mem']`
    - Amount of memory to allocate to Solr
    - **Default:** '-Xms512m -Xmx512m'

 - `node['solr']['gc_tune']`
    - Garbage collection settings
    - Defaults to installer provided settings (see attributes/install.rb)

##### Logging
 - `node['solr']['gc_log_opts']`
    - Logging options string
    - Defaults to verbose settings (see attributes/install.rb)

##### Monitoring
 - `node['solr']['enable_remote_jmx_opts']`
    - Activate the JMX RMI connector to allow remote JMX client applications
    to monitor the JVM hosting Solr; set to "false" to disable that behavior
    - **Default:** 'false' (*recommended in production environments*)
 - `node['solr']['rmi_port']`
    - Specifies the port for the RMI connector
    - **Default** '18983'
    - Note: If `node['solr']['enable_remote_jmx_opts']` is "false" then this line will be commented out

##### Security
 - `node['solr']['solr_authentication_client_configurer']`
    - Solr authentication client configurer
    - **Default:** "" (Disabled)
 - `node['solr']['solr_authentication_opts']`
    - Solr authentication options
    - **Default:** "" (Disabled)

##### SSL
 - `node['solr']['solr_ssl_key_store']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_key_store_password']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_trust_store']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_trust_store_password']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_need_client_auth']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_want_client_auth']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_client_key_store']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_client_key_store_password']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_client_trust_store']`
    - **Default:** "" (Disabled)
 - `node['solr']['solr_ssl_client_trust_store_password']`
    - **Default:** "" (Disabled)

#### Deploy
 - `node['solr']['deploy_url']`
    - URL from which a tarball can be downloaded containing Solr core(s)
    - **Default:** nil

If the `solr_6::deploy` recipe is invoked, but the `node['solr']['deploy_url']` is not set the recipe will raise an exception.

Currently only publicly available urls can be downloaded. Providing more options could be added down the road (see [Contributing](#contributing)).

One or more Solr core directories can be stored at the root of the archive. The provided url will be downloaded and extracted directly into the SOLR_HOME directory. Solr 6 provides core autodiscovery so cores should be available immediately after the service restarts.

## Supports
 - Ubuntu
 - CentOS
 - Red Hat
 - Amazon
 - Fedora

Java 8 is not currently installable on Debian with the Java community Chef recipe. Debian could be supported if Java 8 is installed manually.

## Roadmap

v2.0 -- allow configuration of multiple instances through Chef Custom Resources

## Contributing
Please see CONTRIBUTING for details.


## Copyright & License
Authors:: Nate Flood for ECHO Inc. < [nflood@echonet.org](mailto:nflood@echonet.org) >

License: [MIT](http://echo.mit-license.org/)