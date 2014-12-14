#!/usr/bin/node

var spawn = require('child_process').spawn


var ignoreEnvironment = false
var endLinesWithNull = false
var env = {}


function unset(key)
{
  if(!key)
  {
    console.error('Unknown environment key:',key)
    process.exit(2)
  }

  env[key] = undefined
}


var argv = process.argv.slice(2)

// Options
for(var arg; arg = argv[0]; argv.shift())
{
  if(arg[0] != '-') break;

  switch(arg[0])
  {
    case '-':
    case '-i':
    case '--ignore-environment':
      ignoreEnvironment = true;
    break;

    case '-0':
    case '--null':
      endLinesWithNull = true;
    break;

    case '-u':
    {
      argv.shift()
      unset(argv[0])
    }
    break;

    default:
      if(arg.substr(0,7) == '--unset')
      {
        unset(arg.substr(7))
        break
      }

      console.error('Unknown argument:',arg)
      process.exit(1)
  }
}


// Environment variabless
if(!ignoreEnvironment)
  env.__proto__ = process.env

for(var arg; arg = argv[0]; argv.shift())
{
  arg = arg.split('=')
  if(arg.length < 2) break;

  var key = arg.shift()
  var value = arg.join('=')

  env[key] = value;
}

// Exec command or show environment variables
var command = argv.shift()

if(command)
  spawn(command, argv, {env: env, stdio: 'inherit'})
else
{
  var endLine = endLinesWithNull ? '\0' : '\n'

  for(var key in env)
    process.stdout.write(key+'='+env[key] + endLine);
}
