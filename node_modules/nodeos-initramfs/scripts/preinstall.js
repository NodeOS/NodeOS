#!/usr/bin/env node

var exists = require('fs').exists

var Download = require('download')
var progress = require('download-status')


// Source versions

const FUSE_VERSION = "2.9.4"


// Source URLs

const FUSE_URL="http://downloads.sourceforge.net/fuse/fuse-"+FUSE_VERSION+".tar.gz"


//
// FUSE
//

const SRC_DIR = 'deps/fuse'

exists(SRC_DIR, function(exists)
{
  if(exists) return

  process.stdout.write('Downloading FUSE... ')

  Download({ extract: true, strip: 1 })
  .get(FUSE_URL, SRC_DIR)
  .use(progress())
  .run(function(error)
  {
    if(error) throw error;

    console.log('Done')
  })
})
