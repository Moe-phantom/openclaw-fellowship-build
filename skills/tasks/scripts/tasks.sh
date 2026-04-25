#!/usr/bin/env bash
/usr/bin/node -e "
const fs=require('fs'),os=require('os');
const f=os.homedir()+'/.openclaw/workspace/tasks.jsonl';
const lines=fs.existsSync(f)?fs.readFileSync(f,'utf8').trim().split('\n').filter(Boolean):[];
const open=lines.map(l=>{try{return JSON.parse(l)}catch{return null}}).filter(t=>t&&t.status==='open');
if(!open.length){console.log('No open tasks.');}
else{open.forEach((t,i)=>console.log((i+1)+'. '+t.description));}
"
