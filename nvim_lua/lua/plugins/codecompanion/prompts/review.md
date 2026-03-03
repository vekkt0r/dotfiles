---
name: Code Review
interaction: chat
description: Review code changes
---

## user

Please review this code:

```${context.filetype}
${context.code}
```

Here's the git diff:

```diff
${utils.git_diff}
