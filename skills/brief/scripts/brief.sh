#!/usr/bin/env bash
/usr/bin/node -e "
const fs=require('fs'),os=require('os');
const f=os.homedir()+'/.openclaw/workspace/tasks.jsonl';
const lines=fs.existsSync(f)?fs.readFileSync(f,'utf8').trim().split('\n').filter(Boolean):[];
const count=lines.filter(l=>{try{return JSON.parse(l).status==='open'}catch{return false}}).length;
const quotes=[
  'The secret of getting ahead is getting started. — Mark Twain',
  'It always seems impossible until it is done. — Nelson Mandela',
  'Focus on being productive instead of busy. — Tim Ferriss',
  'Action is the foundational key to all success. — Pablo Picasso',
  'Done is better than perfect. — Sheryl Sandberg'
];
const q=quotes[Math.floor(Math.random()*quotes.length)];
const d=new Date().toLocaleDateString('en-US',{weekday:'long',year:'numeric',month:'long',day:'numeric'});
console.log('\u{1F4C5} '+d);
console.log('\u{1F4CB} Open tasks: '+count);
console.log('\u{1F4AC} '+q);
"
