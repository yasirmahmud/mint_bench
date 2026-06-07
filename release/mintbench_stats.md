# MintBench Summary
| Track | Instances | Key statistic |
| --- | ---: | --- |
| RTL lint localization | 312 | 921 planted errors across 14 taxonomy families |
| CDC verification | 2 | 45 total CDC violations |
| RCA | 9 | 15 root-cause annotations |
| Scalability | 2 | 63 violations in buggy CPU1 variant, 0 in clean variant |

## Evaluation Notes

- Lint and CDC tasks use exact-match issue localization.
- RCA uses exact-match root-cause file/line scoring.
- Scalability reports the same exact-match violation totals plus runtime in the user runner.
