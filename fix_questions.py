#!/usr/bin/env python3
"""修复 questions_clean.sql"""

import json

with open('questions_clean.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

output = []
for line in lines:
    line = line.strip()
    if not line.startswith('INSERT INTO questions'):
        continue

    opt_start = line.find(', "')
    if opt_start < 0:
        output.append(line)
        continue

    # Find closing ' followed by ]]
    opt_end_search = -1
    for i in range(opt_start + 4, len(line) - 4):
        if line[i] == "'" and line[i+1:i+3] == "]]":
            opt_end_search = i
            break

    if opt_end_search < 0:
        output.append(line)
        continue

    opt_value_start = opt_start + 4
    opt_value_end = opt_end_search + 4

    old_opt = line[opt_value_start:opt_value_end]

    # Extract options
    inner_start = old_opt.find("[[")
    inner_end = old_opt.rfind("]]")
    if inner_start < 0 or inner_end < 0:
        output.append(line)
        continue

    inner = old_opt[inner_start+2:inner_end]
    if '", "' in inner:
        parts = inner.split('", "')
        options = []
        for part in parts:
            part = part.strip()
            if part.startswith("'"):
                part = part[1:]
            if part.endswith("'"):
                part = part[:-1]
            part = ' '.join(part.split())
            if part:
                options.append(part)
    else:
        options = [inner.strip().strip("'").strip()]

    sql_opt = "'" + json.dumps(options, ensure_ascii=False) + "'"
    new_line = line.replace(old_opt, sql_opt, 1)

    # Clean content spaces
    import re
    match = re.search(r"VALUES\s*\('([^']+)',", new_line)
    if match:
        content_val = match.group(1)
        cleaned = re.sub(r' {2,}', ' ', content_val)
        if cleaned != content_val:
            new_line = new_line.replace("'" + content_val + "'", "'" + cleaned + "'", 1)

    output.append(new_line)

with open('questions_fixed.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(output))

print(f"处理了 {len(output)} 行")
print("\n第一行前300字符:")
print(output[0][:300])