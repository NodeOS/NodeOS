#!/usr/bin/env node

var Download = require('download');
var fs       = require('fs-extra')
var got      = require('got')
var progress = require('download-status');

var applyPatch = require('diff').applyPatch


// Source versions

const BINUTILS_VERSION = "2.25.1"
const GCC_VERSION      = "5.2.0"
const LINUX_VERSION    = "4.2"
const MUSL_VERSION     = "1.1.11"


// Source URLs

const BINUTILS_URL = "http://ftpmirror.gnu.org/binutils/binutils-"+BINUTILS_VERSION+".tar.gz"
const GCC_URL      = "http://gd.tuwien.ac.at/gnu/gcc/snapshots/"+GCC_VERSION+"/gcc-"+GCC_VERSION+".tar.bz2"
//const GCC_URL      = "http://ftpmirror.gnu.org/gcc/gcc-"+GCC_VERSION+"/gcc-"+GCC_VERSION+".tar.gz"
const LINUX_URL    = "https://www.kernel.org/pub/linux/kernel/v4.x/linux-"+LINUX_VERSION+".tar.xz"
const MUSL_URL     = "http://www.musl-libc.org/releases/musl-"+MUSL_VERSION+".tar.gz"


//
// binutils, gcc, Linux & musl
//

function download_prerequisites()
{
  // Download source code of mpfr, gmp & mpc
//    contrib/download_prerequisites

  // Source versions

  const MPFR_VERSION = "3.1.2"
  const GMP_VERSION  = "6.0.0a"
  const MPC_VERSION  = "1.0.2"


  // Source URLs

  const MPFR_URL = "http://ftpmirror.gnu.org/mpfr/mpfr-"+MPFR_VERSION+".tar.xz"
  const GMP_URL  = "http://ftpmirror.gnu.org/gmp/gmp-"+GMP_VERSION+".tar.xz"
  const MPC_URL  = "http://ftpmirror.gnu.org/mpc/mpc-"+MPC_VERSION+".tar.gz"

  var download = Download({ extract: true, strip: 1 })
  .get(MPFR_URL, 'mpfr')
  .get(GMP_URL,  'gmp')
  .get(MPC_URL,  'mpc')

  if(!process.env.CI) download.use(progress())

  download.run(function(error)
  {
    if(error) throw error;

    // Check system headers
    fs.exists('/usr/include/rpc/types.h', function(exists)
    {
      if(exists) return

      fs.mkdir('/usr/include/rpc', function(error)
      {
        if(error) throw error;

        fs.copy('sunrpc/rpc/*.h', '/usr/include/rpc', function(error)
        {
          if(error) throw error;

          console.log('Done')
        })
      })
    })
  })
}


process.stdout.write('Downloading binutils, gcc, linux & musl... ')

Download({ extract: true, strip: 1 })
.get(BINUTILS_URL, 'deps/binutils')
.get(GCC_URL,      'deps/gcc')
.get(LINUX_URL,    'deps/linux')
.get(MUSL_URL,     'deps/musl')
//.use(progress())
.run(function(error)
{
  if(error) throw error;

//  // Patch GCC to work with musl
//  const PATCH_URL = 'http://patches.clfs.org/embedded-dev/gcc-4.7.3-musl-1.patch'
//
//  got(PATCH_URL, function(error, patch)
//  {
//    if(error) throw error;
//
//      const fileToPatch = SRC_DIR+'/deps/openssl/openssl/crypto/ui/ui_openssl.c'
//
//    fs.readFile(fileToPatch, {encoding: 'utf8'}, function(error, fileContent)
//    {
//      if(error) throw error;
//
//      var patchedContent = applyPatch(fileContent, patch)
//
//      fs.writeFile(fileToPatch, patchedContent, function(error)
//      {
//        if(error) throw error;

        download_prerequisites()
//      })
//    })
//  })
})
