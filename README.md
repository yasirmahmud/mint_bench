# MintBench

MintBench is an HDL linting benchmark for evaluating whether a tool can identify the right source line and describe the right issue. A prediction is counted as a match only when both conditions hold: the file/line matches the gold label, and an LLM judge confirms that the predicted description identifies the same issue. The public repository is intentionally small: benchmark data, one evaluation script, license text, and third-party notices.

## Repository Layout

| Path | Purpose |
| --- | --- |
| `data/` | Benchmark instances and gold labels. |
| `scripts/evaluate_mintbench.py` | Evaluation script for line matching and optional LLM description judging. |
| `THIRD_PARTY_NOTICES.md` | Notices for bundled third-party HDL sources. |
| `LICENSE` | License for original MintBench materials. |

## Benchmark Tracks

| Track | Task | Data |
| --- | --- | --- |
| RTL lint localization | Locate planted lint issues in single-module HDL examples. | `data/rtl_lint_localization/` |
| CDC verification | Detect clock-domain crossing violations in focused CDC fixtures. | `data/cdc/` |
| Root-cause analysis | Identify source root causes behind cascaded lint reports. | `data/root_cause_analysis/` |
| Scalability | Evaluate lint behavior on larger open-source RTL corpora. | `data/scalability/` |

## Prediction Format

Predictions are a JSON object keyed by `instance_id`. Each value can be a list of predicted items or an object with one of these list fields: `violations`, `targets`, `root_causes`, or `errors`.

Example:

```json
{
  "width_cascade": {
    "root_causes": [
      {
        "file_name": "sg_noise_top.sv",
        "line": 10,
        "root_type": "width_mismatch",
        "description": "TOP_W is set to 24 instead of matching DATA_W."
      }
    ]
  }
}
```

Accepted aliases:

| Field type | Accepted names |
| --- | --- |
| Line | `line`, `error_line`, `line_number` |
| File | `file_name`, `file`, `file_path` |
| Label/type | `taxonomy_title`, `rule`, `root_type`, `type`, `root_cause_type` |
| Description | `description`, `error_description` |

## Evaluate Predictions

Run evaluation:

```bash
export MINTBENCH_LLM_API_KEY="..."
python3 scripts/evaluate_mintbench.py \
  --predictions predictions.json \
  --output scores.json \
  --llm-check
```

The evaluator reports:

- `match_precision`: predictions with both line match and description match divided by submitted predictions.
- `match_recall`: gold items matched by both line and description divided by gold items.
- `line_match_precision` and `line_match_recall`: diagnostic location-only metrics.
- `false_positive_predictions`: predictions that did not match a gold location.

For RTL lint localization, the gold source is embedded in each JSON instance, so the match key is line only. For CDC, RCA, and scalability, the match key is file basename plus line.

## LLM Description Check

After a file/line match, the evaluator asks an OpenAI-compatible chat-completions endpoint whether the predicted description identifies the same issue as the gold description. A line match with a non-matching description is not a match.

```bash
export MINTBENCH_LLM_API_KEY="..."
python3 scripts/evaluate_mintbench.py \
  --predictions predictions.json \
  --output scores.json \
  --llm-check
```

Optional settings:

| Environment variable | Default |
| --- | --- |
| `MINTBENCH_LLM_MODEL` | `gemini-3.1-flash` |
| `MINTBENCH_LLM_ENDPOINT` | `https://generativelanguage.googleapis.com/v1beta/openai/chat/completions` |

Running without `--llm-check` is useful only for debugging line coverage. Official MintBench matching requires `--llm-check`.

## Error Taxonomy

RTL lint localization labels use these taxonomy families:

| Family |
| --- |
| `1. SYNTAX STRUCTURE` |
| `2. SIGNAL USAGE` |
| `3. SENSITIVITY LIST` |
| `4. RESERVED WORDS` |
| `5. RACE OR HAZARD` |
| `6. PORT TYPE` |
| `7. OPERATORS` |
| `8. MODULE INSTANCES` |
| `9. LOGIC SYNTHESIS` |
| `10. COMBINATIONAL OR SEQUENTIAL` |
| `11. BIT WIDTH USAGE` |
| `12. STATE MACHINE (FSM) DEFECTS` |
| `13. CODE QUALITY AND SYNTHESIS` |
| `14. CONNECTIVITY AND DRIVING` |

Root-cause labels use:

| Root-cause type |
| --- |
| `unresolved_hierarchy` |
| `width_mismatch` |
| `x_propagation` |
| `assignment_semantics` |

CDC and scalability labels use the `rule`, `taxonomy_title`, or `description` fields present in the gold data.

## License

MintBench benchmark materials and scripts are released under Apache-2.0. Third-party HDL source files under `data/` retain their upstream licenses; see `THIRD_PARTY_NOTICES.md`.
