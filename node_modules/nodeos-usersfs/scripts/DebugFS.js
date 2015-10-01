var execFile = require('child_process').execFile


const DEBUGFS_BIN = '/sbin/debugfs'


function filterEmpty(entry)
{
  return entry.length
}

function createStat(entry)
{
  entry = entry.split('/')

  var stat =
  {
    ino : parseInt(entry[1]),
    mode: parseInt(entry[2]),
    uid : parseInt(entry[3]),
    gid : parseInt(entry[4]),
    name: entry[5],
    size: parseInt(entry[6])
  }

  return stat
}


/**
 * Wrapper class over the 'debugfs' command to modify Ext2/3/4 filesystems
 */
function DebugFS(device)
{
  if(!(this instanceof DebugFS)) return new DebugFS(device)


  function exec(request, write, callback)
  {
    var argv = [device, '-R', request]
    if(write) argv.push('-w')

    execFile(DEBUGFS_BIN, argv, callback)
  }


  this.ls = function(filespec, callback)
  {
    exec('ls -p '+filespec, false, function(error, stdout)
    {
      if(error) return callback(error)

      var files = stdout.split('\n').filter(filterEmpty).map(createStat)

      callback(null, files)
    })
  }

  this.set_inode_field = function(filespec, field, value, callback)
  {
    exec('set_inode_field '+filespec+' '+field+' '+value, true, callback)
  }
}


DebugFS.prototype.set_uid = function(filespec, value, callback)
{
  this.set_inode_field(filespec, 'uid', value, callback)
}
DebugFS.prototype.set_gid = function(filespec, value, callback)
{
  this.set_inode_field(filespec, 'gid', value, callback)
}


module.exports = DebugFS
