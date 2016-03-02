var readlinkSync = require('fs').readlinkSync

var minimist = require('minimist')


function processArguments(argv)
{
  var opts =
  {
    string: 'cpu',
    '--': true
  }
  var args = minimist(argv, opts)

  var cpu = args.cpu || readlinkSync('out/latest').split('/')[0]

  var cpu_family
  var libc = 'musl'
  var machine

  switch(cpu)
  {
    case 'armv6j':
      cpu_family = 'arm'
      libc       = 'musleabihf'
//      machine    = 'vexpress-a15'
      machine    = 'versatilepb'
    break

    case 'i386':
    case 'i486':
    case 'i586':
    case 'i686':
    case 'i786':
      cpu_family = 'i386'
    break

    case 'nocona':
    case 'x86_64':
      cpu_family = 'x86_64'
    break

    case undefined:
      console.error('Symlink not already generated, or CPU not defined')
      process.exit(-1)

    default:
      console.error('Unknown cpu:',cpu)
      process.exit(-2)
  }

  var result =
  {
    cpu:        cpu,
    cpu_family: cpu_family,
    libc:       libc,
    machine:    machine,
    argv:       args['--'] || args._
  }

  return result
}


module.exports = processArguments
