#!/bin/sh
# Lists every folder inside "images" in images/folders.js, so the viewer can show them in its menu,
# and copies each folder's metadata.json (if it has one) into that file, so the information card
# also works when the page is opened from disk.
# Run it again whenever you add, rename or remove a box folder, or change a metadata.json.
cd "$(dirname "$0")" || exit 1
mkdir -p images
cd images || exit 1
{
  echo "window.BOX_FOLDERS = ["
  for d in */; do
    [ -d "$d" ] && printf '  "%s",\n' "${d%/}"
  done
  echo "];"
  echo "window.BOX_META_TEXT = {};"
  for d in */; do
    [ -f "${d}metadata.json" ] || continue
    printf 'BOX_META_TEXT["%s"] = function () {/*\n' "${d%/}"
    cat "${d}metadata.json"
    printf '\n*/};\n'
  done
} > folders.js
echo "Updated images/folders.js:"
cat folders.js
