#!/usr/bin/env python3
import re
import glob

def main():
    # Find all variable references in .tf files
    variables = set()
    var_pattern = re.compile(r'\bvar\.([a-zA-Z_][a-zA-Z0-9_]*)')
    
    for tf_file in glob.glob("*.tf"):
        with open(tf_file,'r') as f:
            variables.update(var_pattern.findall(f.read()))
    
    # Generate variables.tf
    with open("variables.tf", 'w') as f:
        for var_name in sorted(variables):
            f.write(f'variable "{var_name}" {{\n  type = string\n}}\n\n')
    
    print(f"Generated variables.tf with {len(variables)} variables")

if __name__ == "__main__":
    main()
