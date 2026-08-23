#!/bin/zsh
#
# Build every worksheet target (pdf, scorm, and tex; with and without solutions).
#
# Usage:
#   ./build_worksheets.sh                    # build every worksheet
#   ./build_worksheets.sh ws-06-01 ws-07-03b  # build only these worksheets

cd "$(dirname "$0")/.."

if [ $# -eq 0 ]; then
    pattern='^ws-[0-9]{2}-[0-9]{2}[a-z]?-(pdf|scorm|tex)(-sols)?$'
else
    stems=$(IFS='|'; echo "$*")
    pattern="^(${stems})-(pdf|scorm|tex)(-sols)?\$"
fi

targets=$(pretext -t | grep -E "$pattern")
if [ -z "$targets" ]; then
    echo "No matching worksheet targets found for: $*" >&2
    exit 1
fi

echo "$targets" | while read -r target; do
    pretext build "$target"
done
