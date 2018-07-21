# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Cuba"
version = v"4.2a"
commit_sha = "11bfbf509088f168622b8268f49c0a59ee81758b"

# Collection of sources required to build Cuba
name = "Cuba"
version = v"4.2"
sources = [
    "https://github.com/giordano/cuba/archive/$commit_sha.tar.gz" =>
    "9cbb3a9c6ea541d7f3b0efcba6a865082e70536aded6a347bcec4873df3f3cc4",

]

# Bash recipe for building across all platforms
script = """
cd \$WORKSPACE/srcdir
cd cuba-$commit_sha/
./configure --prefix=\$prefix --host=\$target
make shared
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:i686, :glibc),
    Linux(:x86_64, :glibc),
    Linux(:aarch64, :glibc),
    Linux(:armv7l, :glibc, :eabihf),
    Linux(:powerpc64le, :glibc),
    Linux(:i686, :musl),
    Linux(:x86_64, :musl),
    Linux(:aarch64, :musl),
    Linux(:armv7l, :musl, :eabihf),
    MacOS(:x86_64),
    Windows(:i686),
    Windows(:x86_64)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libcuba", :libcuba)
]

# Dependencies that must be installed before this package can be built
dependencies = []

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
