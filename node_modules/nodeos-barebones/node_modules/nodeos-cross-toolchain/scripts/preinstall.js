#!/usr/bin/env node

var Download = require('download');
var progress = require('download-status');

var eachSeries = require('async').eachSeries


// Source versions

const BINUTILS_VERSION = "2.24"
const GCC_VERSION      = "4.9.2"
const GLIBC_VERSION    = "2.20"


// Source URLs

const BINUTILS_URL = "http://ftpmirror.gnu.org/binutils/binutils-"+BINUTILS_VERSION+".tar.gz"
const GCC_URL      = "http://ftpmirror.gnu.org/gcc/gcc-"+GCC_VERSION+"/gcc-"+GCC_VERSION+".tar.gz"
const GLIBC_URL    = "http://ftpmirror.gnu.org/glibc/glibc-"+GLIBC_VERSION+".tar.gz"


function fetch(options, callback)
{
  var download = new Download({ extract: true, strip: 1 })
      .get(options.url)
      .dest(options.dest)
      .use(progress());

  download.run(callback);
}


var downloads =
[
  {url: BINUTILS_URL, dest: 'sources/binutils'},
  {url: GCC_URL,      dest: 'sources/gcc'},
  {url: GLIBC_URL,    dest: 'sources/glibc'}
]

eachSeries(downloads, fetch, function(error)
{
  if(error) throw err;

  console.log('Download finished!');
})
