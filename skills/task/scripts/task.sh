#!/usr/bin/env bash
# Usage: task.sh <description words...>
/usr/bin/node -e "
const c=require('crypto'),fs=require('fs'),os=require('os');
const desc=process.argv.slice(1).join(' ');
if(!desc){console.error('No description provided');process.exit(1);}
const entry=JSON.stringify({id:c.randomUUID(),description:desc,status:'open',created:new Date().toISOString()});
fs.appendFileSync(os.homedir()+'/.openclaw/workspace/tasks.jsonl',entry+'\n');
console.log('✅ Logged: '+desc);
" -- "$@"
