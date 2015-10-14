#!/usr/bin/env node

var join = require('path').join

var async    = require('async')
var Download = require('download');
var fs       = require('fs-extra')
//var got      = require('got')
var progress = require('download-status');

var applyPatch = require('diff').applyPatch


const DEPS='deps'


// Source versions

const BINUTILS_VERSION = "2.25.1"
const GCC_VERSION      = "4.7.3"  // "5.2.0"
const LINUX_VERSION    = "4.2.3"
const MUSL_VERSION     = "1.1.11"


// Source URLs

const BINUTILS_URL = "http://ftpmirror.gnu.org/binutils/binutils-"+BINUTILS_VERSION+".tar.gz"
const GCC_URL      = "http://ftpmirror.gnu.org/gcc/gcc-"+GCC_VERSION+"/gcc-"+GCC_VERSION+".tar.gz"
const LINUX_URL    = "https://www.kernel.org/pub/linux/kernel/v4.x/linux-"+LINUX_VERSION+".tar.gz"
const MUSL_URL     = "http://www.musl-libc.org/releases/musl-"+MUSL_VERSION+".tar.gz"


//
// binutils, gcc, Linux & musl
//

function download_prerequisites(name, callback)
{
  // Download source code of mpfr, gmp & mpc
//    contrib/download_prerequisites

  // Source versions

  const MPFR_VERSION = "3.1.2"
  const GMP_VERSION  = "6.0.0a"
  const MPC_VERSION  = "1.0.2"


  // Source URLs

  const MPFR_URL = "http://ftpmirror.gnu.org/mpfr/mpfr-"+MPFR_VERSION+".tar.bz2"
  const GMP_URL  = "http://ftpmirror.gnu.org/gmp/gmp-"+GMP_VERSION+".tar.bz2"
  const MPC_URL  = "http://ftpmirror.gnu.org/mpc/mpc-"+MPC_VERSION+".tar.gz"

  var download = Download({ extract: true, strip: 1 })
  .get(MPFR_URL, join(DEPS, name, 'mpfr'))
  .get(GMP_URL,  join(DEPS, name, 'gmp'))
  .get(MPC_URL,  join(DEPS, name, 'mpc'))

  if(!process.env.CI) download.use(progress())

  download.run(function(error)
  {
    if(error) return callback(error)

    // Check system headers
    fs.exists('/usr/include/rpc/types.h', function(exists)
    {
      if(exists) return callback()

      fs.mkdir('/usr/include/rpc', function(error)
      {
        if(error) return callback(error)

        fs.copy('sunrpc/rpc/*.h', '/usr/include/rpc', callback)
      })
    })
  })
}


var downloads =
[
  {
    name: 'binutils',
    url: BINUTILS_URL
  },
  {
    name: 'gcc',
    url: GCC_URL,
    action: function(callback)
    {
      //  // Patch GCC to work with musl
      //  const PATCH_URL = 'https://raw.githubusercontent.com/GregorR/musl-cross/master/patches/gcc-'+GCC_VERSION+'-musl.diff'
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

              download_prerequisites(this.name, callback)
      //      })
      //    })
      //  })
    }
  },
  {
    name: 'linux',
    url: LINUX_URL
  },
  {
    name: 'musl',
    url: MUSL_URL
  },
]


//
// Downloads manager
//

function addUrl(item)
{
  this.get(item.url, join(DEPS, item.name))
}

function getName(item)
{
  return item.name
}

function getAction(item)
{
  return item.action
}

function getNames(downloads)
{
  var names = downloads.map(getName)
  var last  = names.pop()

  var result = names.join(', ')

  if(names.length) result += ' and '

  return result + last
}

function notUndefinedAction(item)
{
  return item.action !== undefined
}


async.reject(downloads, function(item, callback)
{
  fs.exists(join(DEPS, item.name), callback)
},
function(downloads)
{
  if(!downloads.length) return

  process.stdout.write('Downloading '+getNames(downloads)+'... ')

  var download = Download({ extract: true, strip: 1 })
  if(!process.env.CI) download.use(progress())

  downloads.forEach(addUrl, download)

  download.run(function(error)
  {
    if(error) throw error;

    if(!process.env.CI) console.log('Done')

    async.series(downloads.filter(notUndefinedAction).map(getAction),
    function(argument)
    {
      if(error) throw error;
    })
  })
})
