# MintBench Summary
| Track | Instances | Key statistic |
| --- | ---: | --- |
| RTL lint localization | 312 | 921 planted errors across 14 taxonomy families |
| CDC verification | 60 | 387 total CDC violations |
| RCA | 9 | 15 root-cause annotations |
| Scalability | 18 designs | 8660 labeled violations across larger RTL designs |

## Evaluation Notes

- Lint and CDC tasks use exact-match issue localization.
- RCA uses exact-match root-cause file/line scoring.
- Scalability covers every design directory under `data/scalability/` and uses exact-match violation scoring.
- Optional auxiliary analysis is enabled through user-provided service credentials.
