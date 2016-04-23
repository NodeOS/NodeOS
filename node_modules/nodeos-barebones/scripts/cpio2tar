#!/usr/bin/env node

var cpio = require('cpio-stream')
var tar  = require('tar-stream')


var extract = cpio.extract()
var pack    = tar.pack()

extract.on('entry', function(header, stream, callback)
{
  stream.pipe(pack.entry(header, callback))
})

extract.on('finish', pack.finalize.bind(pack))

process.stdin.pipe(extract)
pack.pipe(process.stdout)
