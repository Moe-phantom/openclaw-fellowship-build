---
name: papers
description: "Search arXiv for the latest research papers on a topic. Usage: /papers <topic>"
user-invocable: true
---

# papers

Use the exec tool to run the following command, replacing the topic words with everything after `/papers` in the user's message:

```
/usr/bin/bash /home/mohamed-alwathiq/.openclaw/workspace/skills/papers/scripts/papers.sh <topic words here>
```

Example — if user sent `/papers transformer attention`, run:
```
/usr/bin/bash /home/mohamed-alwathiq/.openclaw/workspace/skills/papers/scripts/papers.sh transformer attention
```

Reply with the stdout output of that command, verbatim. Nothing else.
