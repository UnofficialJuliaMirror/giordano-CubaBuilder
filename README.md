# CubaBuilder builder

This repository builds binary artifacts of the [Cuba library](http://www.feynarts.de/cuba/).
This repository has a default .travis.yml file that can be used to build
binary artifacts on Travis CI. You will however need to setup the release
upload manually. See https://docs.travis-ci.com/user/deployment/releases/.

If you don't wish to use travis, you can use the build_tarballs.jl
file manually and upload the resulting artifacts to a hosting provider
of your choice.
