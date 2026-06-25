# REFACTOR_LOG.md

> Append one entry per change, in the order applied. Never batch
> multiple unrelated changes into one entry — the whole point of this
> log is that each change can be independently understood, verified,
> and rolled back.

## Entry N

- **Step category:** <!-- Naming | Structure | Duplication | Dead Code |
                           Complexity | Type Safety | Dependency Cleanup -->
- **Problem:** <!-- quote or reference the exact finding from the
                     auditor's reports that justifies this change -->
- **Evidence:** <!-- the auditor's evidence, plus anything you verified
                      yourself before acting on it -->
- **Reason:** <!-- why this specific change addresses the problem -->
- **Change made:** <!-- precise description: files touched, what moved
                         where, what was renamed to what -->
- **Risk:** <!-- what could this break, even if you think it won't -->
- **Rollback method:** <!-- exact command or steps to undo this specific
                            change, e.g. "git revert <commit>" or
                            "restore from backup at path X" -->
- **Verification method:** <!-- how you confirmed this change didn't
                               break anything: which tests ran, what
                               build command, what manual check -->
- **Verification result:** <!-- pass/fail, with the actual output if
                               relevant -->
