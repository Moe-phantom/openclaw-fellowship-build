---
name: task
description: "Log a task to tasks.jsonl. Usage: /task <description>"
user-invocable: true
---

# task

Use the exec tool to run the following command. Pass every word of the user's task description as separate arguments after the script path:

```
/usr/bin/bash /home/mohamed-alwathiq/.openclaw/workspace/skills/task/scripts/task.sh USER_TASK_DESCRIPTION_WORDS
```

Example: if the user typed `/task buy milk and eggs`, run:
```
/usr/bin/bash /home/mohamed-alwathiq/.openclaw/workspace/skills/task/scripts/task.sh buy milk and eggs
```

Reply with the stdout output of that command, verbatim. Nothing else.
