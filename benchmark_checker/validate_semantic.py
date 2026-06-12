import json
import re
from pathlib import Path

# Regex patterns matching the new generator logic
OPERATOR_RE = re.compile(r"===|!==")
CASE_RE = re.compile(r"\bcase(z|x)?\b", re.IGNORECASE)
BLOCKING_RE = re.compile(r"(?<![<>=!])=(?!=)")

def validate_semantic():
    root = Path(__file__).resolve().parent.parent / "large_design_minimal"
    benchmark_files = sorted(root.glob("**/benchmark.json"))
    
    total_issues = 0
    incorrect_issues = []
    
    # Store issues by categories
    categories_stats = {
        "operator": {"total": 0, "correct": 0},
        "case": {"total": 0, "correct": 0},
        "unused_var": {"total": 0, "correct": 0},
        "blocking_assignment": {"total": 0, "correct": 0},
        "mixed_assignment": {"total": 0, "correct": 0},
        "latch_inferred": {"total": 0, "correct": 0},
        "multiple_drivers": {"total": 0, "correct": 0},
        "sensitivity_list": {"total": 0, "correct": 0},
        "other": {"total": 0, "correct": 0}
    }

    for bf in benchmark_files:
        repo_dir = bf.parent
        repo_name = repo_dir.name
        
        try:
            data = json.loads(bf.read_text(encoding="utf-8"))
        except Exception:
            continue
            
        errors = data.get("errors", [])
        
        for idx, err in enumerate(errors):
            total_issues += 1
            file_name = err.get("file_name")
            line_no = err.get("line")
            desc = err.get("description", "")
            
            source_file = repo_dir / file_name
            if not source_file.exists():
                incorrect_issues.append({
                    "repo": repo_name,
                    "file": file_name,
                    "line": line_no,
                    "desc": desc,
                    "reason": "File does not exist"
                })
                continue
                
            try:
                lines = source_file.read_text(encoding="utf-8", errors="ignore").splitlines()
            except Exception:
                continue
                
            if line_no < 1 or line_no > len(lines):
                incorrect_issues.append({
                    "repo": repo_name,
                    "file": file_name,
                    "line": line_no,
                    "desc": desc,
                    "reason": f"Line number out of bounds (1-{len(lines)})"
                })
                continue
                
            line_content = lines[line_no - 1]
            file_content = "\n".join(lines)
            
            # Categorize and check correctness under new rules
            if "Operator '===' should be avoided" in desc:
                categories_stats["operator"]["total"] += 1
                is_correct = bool(OPERATOR_RE.search(line_content))
                if is_correct:
                    categories_stats["operator"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Line does not contain '===' or '!=='. Line content: '{line_content.strip()}'"
                    })
                    
            elif "Case statement does not have a default clause" in desc:
                categories_stats["case"]["total"] += 1
                is_correct = bool(CASE_RE.search(line_content))
                if is_correct:
                    categories_stats["case"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Line does not contain 'case'. Line content: '{line_content.strip()}'"
                    })
                    
            elif "set but not read" in desc:
                categories_stats["unused_var"]["total"] += 1
                match = re.search(r"Variable '([^']+)' set but not read\.", desc)
                var_name = match.group(1) if match else ""
                is_correct = var_name and (var_name in line_content or var_name in file_content)
                if is_correct:
                    categories_stats["unused_var"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Variable '{var_name}' not found in line/file"
                    })
                    
            elif "used inside a 'FlipFlop' inferred sequential block" in desc:
                categories_stats["blocking_assignment"]["total"] += 1
                is_correct = bool(BLOCKING_RE.search(line_content))
                if is_correct:
                    categories_stats["blocking_assignment"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Line does not contain blocking assignment '='. Line content: '{line_content.strip()}'"
                    })
                    
            elif "is being assigned in both blocking and non-blocking manner" in desc:
                categories_stats["mixed_assignment"]["total"] += 1
                match = re.search(r"Variable/Signal '([^']+)'", desc)
                var_name = match.group(1) if match else ""
                is_correct = var_name and (var_name in line_content)
                if is_correct:
                    categories_stats["mixed_assignment"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Variable '{var_name}' not found in line: '{line_content.strip()}'"
                    })
                    
            elif "Latch inferred for signal" in desc:
                categories_stats["latch_inferred"]["total"] += 1
                match = re.search(r"signal '([^']+)' in module '([^']+)'", desc)
                sig_name, mod_name = match.groups() if match else ("", "")
                is_correct = mod_name and (mod_name in file_content) and sig_name and (sig_name in file_content)
                if is_correct:
                    categories_stats["latch_inferred"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Module '{mod_name}' or signal '{sig_name}' not found in file"
                    })
                    
            elif "has multiple simultaneous drivers" in desc:
                categories_stats["multiple_drivers"]["total"] += 1
                match = re.search(r"Signal '([^']+)\.u_core\.([^']+)'", desc)
                mod_name, sig_name = match.groups() if match else ("", "")
                is_correct = mod_name and (mod_name in file_content) and sig_name and (sig_name in file_content)
                if is_correct:
                    categories_stats["multiple_drivers"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Module '{mod_name}' or signal '{sig_name}' not found in file"
                    })
                    
            elif "read in the block is not in the sensitivity list" in desc:
                categories_stats["sensitivity_list"]["total"] += 1
                match = re.search(r"The signal/variable '([^']+)'", desc)
                var_name = match.group(1) if match else ""
                is_correct = var_name and (var_name in file_content)
                if is_correct:
                    categories_stats["sensitivity_list"]["correct"] += 1
                else:
                    incorrect_issues.append({
                        "repo": repo_name,
                        "file": file_name,
                        "line": line_no,
                        "desc": desc,
                        "reason": f"Variable '{var_name}' not found in file"
                    })
                    
            else:
                categories_stats["other"]["total"] += 1
                incorrect_issues.append({
                    "repo": repo_name,
                    "file": file_name,
                    "line": line_no,
                    "desc": desc,
                    "reason": "Uncategorized/unmatched issue description format"
                })

    print("--- CATEGORY STATISTICS ---")
    for cat, stats in categories_stats.items():
        total = stats["total"]
        correct = stats["correct"]
        pct = (correct / total * 100) if total > 0 else 100.0
        print(f"{cat:22} : {correct}/{total} ({pct:.1f}% correct)")
        
    print(f"\nTotal Issues Checked: {total_issues}")
    print(f"Total Incorrect/Synthetic-only Issues Found: {len(incorrect_issues)}")
    
    report_path = Path(__file__).resolve().parent / "semantic_validation_report.json"
    report_path.write_text(json.dumps(incorrect_issues, indent=2), encoding="utf-8")
    print(f"Full report of incorrect issues written to: {report_path}")

if __name__ == "__main__":
    validate_semantic()
