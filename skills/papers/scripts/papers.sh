#!/usr/bin/env bash
set -euo pipefail

TOPIC="${*:-machine learning}"
QUERY=$(echo "$TOPIC" | sed 's/ /+/g')
URL="https://export.arxiv.org/api/query?search_query=all:${QUERY}&start=0&max_results=5&sortBy=submittedDate&sortOrder=descending"

XML=$(curl -s --max-time 15 "$URL" 2>/dev/null || echo "")

if [ -z "$XML" ] || ! echo "$XML" | grep -q "<entry>"; then
  echo "No papers found for: $TOPIC"
  exit 0
fi

echo "📚 Latest arXiv papers on: $TOPIC"
echo ""

echo "$XML" | python3 -c "
import sys, re, html
from xml.etree import ElementTree as ET

ns = {'atom': 'http://www.w3.org/2005/Atom'}
data = sys.stdin.read()
try:
    root = ET.fromstring(data)
except Exception as e:
    print('arXiv API parse error')
    sys.exit(0)

entries = root.findall('atom:entry', ns)
if not entries:
    print('No papers found.')
    sys.exit(0)

for i, entry in enumerate(entries, 1):
    title = (entry.find('atom:title', ns).text or '').strip().replace('\n', ' ')
    title = re.sub(r'\s+', ' ', title)
    summary = (entry.find('atom:summary', ns).text or '').strip().replace('\n', ' ')
    summary = re.sub(r'\s+', ' ', summary)[:200]
    published = (entry.find('atom:published', ns).text or '')[:10]
    arxiv_id = (entry.find('atom:id', ns).text or '').split('/abs/')[-1]
    authors = [a.find('atom:name', ns).text for a in entry.findall('atom:author', ns)]
    if len(authors) > 2:
        author_str = f'{authors[0]}, {authors[1]}, et al.'
    else:
        author_str = ', '.join(authors)
    print(f'{i}. {title}')
    print(f'   {author_str} ({published})')
    print(f'   arxiv.org/abs/{arxiv_id}')
    print(f'   {summary}...')
    print('')
"
