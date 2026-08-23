#!/bin/zsh
#
# Build every pset target (pdf, scorm, and tex; with and without solutions).
#
# Usage:
#   ./build_psets.sh              # build every pset
#   ./build_psets.sh ps06 ps07    # build only these psets

cd "$(dirname "$0")/.."

if [ $# -eq 0 ]; then
    pattern='^ps[0-9]{2}[a-z]?-(pdf|scorm|tex)(-sols)?$'
else
    stems=$(IFS='|'; echo "$*")
    pattern="^(${stems})-(pdf|scorm|tex)(-sols)?\$"
fi

targets=$(pretext -t | grep -E "$pattern")
if [ -z "$targets" ]; then
    echo "No matching pset targets found for: $*" >&2
    exit 1
fi

echo "$targets" | while read -r target; do
    pretext build "$target"
done
