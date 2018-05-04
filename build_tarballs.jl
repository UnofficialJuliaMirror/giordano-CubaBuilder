using BinaryBuilder

# Collection of sources required to build CubaBuilder
sources = [
    "https://github.com/giordano/cuba/archive/1c3e17736216bb01f6a6d32746b851869a25c867.tar.gz" =>
    "e572dcb49c52bcdff5c20a95caff2fe0aae504c56200d798a00a960eb27f8a73",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd cuba-1c3e17736216bb01f6a6d32746b851869a25c867/
./configure --prefix=$prefix --host=$target
make shared
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    BinaryProvider.Linux(:armv7l, :glibc, :eabihf),
    BinaryProvider.Linux(:powerpc64le, :glibc, :blank_abi),
    BinaryProvider.Linux(:x86_64, :glibc, :blank_abi),
    BinaryProvider.Linux(:aarch64, :glibc, :blank_abi),
    BinaryProvider.Windows(:x86_64, :blank_libc, :blank_abi),
    BinaryProvider.Linux(:i686, :glibc, :blank_abi),
    BinaryProvider.Windows(:i686, :blank_libc, :blank_abi),
    BinaryProvider.MacOS(:x86_64, :blank_libc, :blank_abi)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libcuba", :libcuba)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "CubaBuilder", sources, script, platforms, products, dependencies)

