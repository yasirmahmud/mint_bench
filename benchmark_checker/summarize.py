import json
from collections import Counter
from pathlib import Path

def summarize():
    report_path = Path(__file__).resolve().parent / "semantic_validation_report.json"
    if not report_path.exists():
        print(f"Error: report file {report_path} does not exist. Run validate_semantic.py first.")
        return
        
    with open(report_path, "r", encoding="utf-8") as f:
        data = json.load(f)
        
    print(f"Total incorrect/synthetic issues: {len(data)}")
    
    # Analyze by category
    by_type = Counter()
    reasons_by_type = {}
    
    for item in data:
        desc = item["desc"]
        reason = item["reason"]
        
        # Categorize desc
        if "Operator" in desc:
            category = "Operator"
        elif "Case statement" in desc:
            category = "Case statement"
        elif "set but not read" in desc:
            category = "Unused variable"
        elif "used inside a 'FlipFlop'" in desc:
            category = "Blocking assignment"
        elif "both blocking and non-blocking" in desc:
            category = "Mixed assignment"
        elif "Latch inferred" in desc:
            category = "Latch inferred"
        elif "multiple simultaneous drivers" in desc:
            category = "Multiple drivers"
        elif "sensitivity list" in desc:
            category = "Sensitivity list"
        else:
            category = "Other"
            
        by_type[category] += 1
        if category not in reasons_by_type:
            reasons_by_type[category] = []
        reasons_by_type[category].append(reason)
        
    for cat, count in by_type.items():
        print(f"\n--- {cat}: {count} occurrences ---")
        unique_reasons = Counter(reasons_by_type[cat])
        for r, r_count in unique_reasons.most_common(5):
            print(f"  ({r_count} times) {r}")

if __name__ == "__main__":
    summarize()
