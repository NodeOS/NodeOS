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

  var cpu = args.cpu || readlinkSync('out/latest').split('/')[-2]

  var cpu_family;
  switch(cpu)
  {
    case 'armv6':
      cpu_family = 'arm'
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

    default:
      console.error('Unknown cpu:',cpu)
      process.exit(-1)
  }

  return {cpu: cpu, cpu_family: cpu_family, argv: args['--'] || args._}
}


module.exports = processArguments
