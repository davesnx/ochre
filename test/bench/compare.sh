#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: compare.sh BASE_RUNS_DIR HEAD_RUNS_DIR" >&2
  exit 2
fi

shopt -s nullglob
base_runs=("$1"/*.txt)
head_runs=("$2"/*.txt)
if [ ${#base_runs[@]} -eq 0 ] || [ ${#head_runs[@]} -eq 0 ]; then
  echo "No bench outputs (*.txt) in $1 or $2" >&2
  exit 2
fi

median() {
  awk -v key="$1" '$1 == key { print $2 }' "${@:2}" | sort -g |
    awk '{ v[NR] = $1 } END { if (NR == 0) exit 1; print v[int((NR + 1) / 2)] }'
}

status=0
while read -r key; do
  if ! base=$(median "$key" "${base_runs[@]}"); then
    echo "$key: no base timing, skipped"
    continue
  fi
  head=$(median "$key" "${head_runs[@]}")
  limit=1.5
  if [ "$key" = total ]; then
    limit=1.25
  fi
  awk -v key="$key" -v base="$base" -v head="$head" -v limit="$limit" 'BEGIN {
    ratio = head / base
    printf "%s: base %.6f s, head %.6f s, head/base %.2f (limit %.2f)\n", key, base, head, ratio, limit
    exit !(ratio > limit)
  }' && {
    echo "$key is more than $limit times slower than base." >&2
    status=1
  }
done < <(awk '{ print $1 }' "${head_runs[@]}" | sort -u)
exit "$status"
