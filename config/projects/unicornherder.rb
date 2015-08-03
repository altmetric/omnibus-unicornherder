#
# Copyright 2015 Digital Science
#
# All Rights Reserved.
#

name "unicornherder"
maintainer "Altmetric LLP"
homepage "https://github.com/altmetric/omnibus-unicornherder"

# Defaults to C:/unicornherder on Windows
# and /opt/unicornherder on all other platforms
install_dir "#{default_root}/#{name}"

build_version do
  source :version, from_dependency: 'unicornherder'
end

build_iteration 1

dependency "preparation"
dependency "unicornherder"
dependency "shebang-cleanup"
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
