# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "Cuba"
version = v"4.2a"
commit_sha = "75a98808e0246a8b716df6478169711144f66e0c"

# Collection of sources required to build Cuba
name = "Cuba"
version = v"4.2"
sources = [
    "https://github.com/giordano/cuba/archive/$commit_sha.tar.gz" =>
    "d5984ba8678acf4afba78a37c6e01a0fedc6d3ab6052eef196d1c9a5382dc869",

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
