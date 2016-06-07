name 'solr_6'
maintainer 'ECHO Inc'
maintainer_email 'nflood@echonet.org'
license 'MIT'
description 'Installs/Configures Apache Solr Version 6'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'
source_url 'https://github.com/ECHOInternational/chef-solr_6'
issues_url 'https://github.com/ECHOInternational/chef-solr_6/issues'

supports 'amazon'
supports 'centos'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'

depends 'yum'
depends 'java'
