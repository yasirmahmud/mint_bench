import json
from pathlib import Path
import sys

def validate():
    # Set root dynamically relative to the script location
    root = Path(__file__).resolve().parent.parent / "large_design_minimal"
    if not root.exists():
        print(f"Error: root directory {root} does not exist")
        sys.exit(1)
        
    benchmark_files = sorted(root.glob("**/benchmark.json"))
    print(f"Found {len(benchmark_files)} benchmark.json files.\n")
    
    total_errors_checked = 0
    total_problems = 0
    
    for bf in benchmark_files:
        repo_dir = bf.parent
        repo_name = repo_dir.name
        print(f"Checking {repo_name}...")
        
        try:
            content = bf.read_text(encoding="utf-8")
            data = json.loads(content)
        except Exception as e:
            print(f"  [ERROR] Failed to parse JSON: {e}")
            total_problems += 1
            continue
            
        if "errors" not in data:
            print("  [ERROR] 'errors' key missing in JSON structure")
            total_problems += 1
            continue
            
        errors_list = data["errors"]
        if not isinstance(errors_list, list):
            print("  [ERROR] 'errors' is not a list")
            total_problems += 1
            continue
            
        seen_errors = set()
        
        for idx, err in enumerate(errors_list):
            total_errors_checked += 1
            # Check structure
            if not isinstance(err, dict):
                print(f"  [ERROR] Issue {idx} is not a dictionary")
                total_problems += 1
                continue
                
            file_name = err.get("file_name")
            line = err.get("line")
            description = err.get("description")
            
            missing_fields = []
            if file_name is None: missing_fields.append("file_name")
            if line is None: missing_fields.append("line")
            if description is None: missing_fields.append("description")
            
            if missing_fields:
                print(f"  [ERROR] Issue {idx}: Missing fields: {', '.join(missing_fields)}")
                total_problems += 1
                continue
                
            # Check duplicates
            err_key = (file_name, line, description)
            if err_key in seen_errors:
                print(f"  [WARNING] Issue {idx}: Duplicate error entry for {file_name}:{line} with description '{description}'")
                total_problems += 1
            seen_errors.add(err_key)
            
            # Check file existence
            source_file = repo_dir / file_name
            if not source_file.exists():
                print(f"  [ERROR] Issue {idx}: Referenced file '{file_name}' does not exist in {repo_name}")
                total_problems += 1
                continue
                
            # Check line correctness
            try:
                file_lines = source_file.read_text(encoding="utf-8", errors="ignore").splitlines()
                num_lines = len(file_lines)
            except Exception as e:
                print(f"  [ERROR] Issue {idx}: Failed to read '{file_name}': {e}")
                total_problems += 1
                continue
                
            if not isinstance(line, int):
                print(f"  [ERROR] Issue {idx}: 'line' is not an integer (got {type(line).__name__}: {line})")
                total_problems += 1
                continue
                
            if line <= 0:
                print(f"  [ERROR] Issue {idx}: 'line' number {line} is invalid (must be > 0)")
                total_problems += 1
            elif line > num_lines:
                print(f"  [ERROR] Issue {idx}: 'line' number {line} is out of bounds (file '{file_name}' has only {num_lines} lines)")
                total_problems += 1
                
    print(f"\nValidation complete. Checked {len(benchmark_files)} files, {total_errors_checked} errors total. Found {total_problems} problems.")

if __name__ == "__main__":
    validate()
