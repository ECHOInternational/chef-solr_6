# frozen_string_literal: true

require 'serverspec'

set :path, '/sbin:/usr/local/sbin:$PATH'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end
