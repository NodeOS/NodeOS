#!/usr/bin/env node

var Download = require('download');
var progress = require('download-status');


// Source versions

const BINUTILS_VERSION = "2.24"
const GCC_VERSION      = "4.7.3"  // "4.9.2"
const LINUX_VERSION    = "3.18.3"
const MUSL_VERSION     = "1.0.4"


// Source URLs

const BINUTILS_URL = "http://ftpmirror.gnu.org/binutils/binutils-"+BINUTILS_VERSION+".tar.gz"
const GCC_URL      = "http://ftpmirror.gnu.org/gcc/gcc-"+GCC_VERSION+"/gcc-"+GCC_VERSION+".tar.gz"
const LINUX_URL    = "https://www.kernel.org/pub/linux/kernel/v3.x/linux-"+LINUX_VERSION+".tar.xz"
const MUSL_URL     = "http://www.musl-libc.org/releases/musl-"+MUSL_VERSION+".tar.gz"


Download({ extract: true, strip: 1 })
.get(BINUTILS_URL, 'deps/binutils')
.get(GCC_URL,      'deps/gcc')
.get(LINUX_URL,    'deps/linux')
.get(MUSL_URL,     'deps/musl')
.use(progress())
.run(function(error)
{
  if(error) throw error;

  console.log('Download finished!');
})
