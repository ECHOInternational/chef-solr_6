name 'solr_6'
maintainer 'ECHO Inc'
maintainer_email 'nflood@echonet.org'
license 'Apache 2.0'
description 'Installs/Configures Apache Solr Version 6'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports 'amazon'
supports 'centos'
supports 'redhat'
supports 'scientific'
supports 'ubuntu'

depends 'yum'
depends 'java'
