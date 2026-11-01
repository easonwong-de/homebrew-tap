#!/usr/bin/env bash
set -euo pipefail

dry_run=false
for arg in "$@"; do
  if [ "$arg" = "--dry-run" ] || [ "$arg" = "-n" ]; then
    dry_run=true
  fi
done

if [ -n "${GITHUB_ACTIONS:-}" ] && [ "$dry_run" = false ]; then
  git config user.name "github-actions[bot]"
  git config user.email "github-actions[bot]@users.noreply.github.com"
fi

report() {
  local msg="$1"
  echo "$msg"
  if [ -n "${GITHUB_STEP_SUMMARY:-}" ]; then
    echo "$msg" >> "$GITHUB_STEP_SUMMARY"
  fi
}

fetch_sha() {
  local asset="$1" url="$2" sha
  sha=$(echo "$release_info" | jq -r --arg n "$asset" '.assets[] | select(.name == $n) | .digest' 2>/dev/null || true)
  sha="${sha#sha256:}"
  if [ -z "$sha" ] || [ "$sha" = "null" ]; then
    sha=$(curl -sL "$url" | sha256sum | awk '{print $1}')
  fi
  echo "$sha"
}

outdated_count=0
updated_count=0
shopt -s nullglob
files=(Formula/*.rb Casks/*.rb)

for file in "${files[@]}"; do
  [ -f "$file" ] || continue

  current_ver=$(grep -E '^[[:space:]]*version[[:space:]]+"' "$file" | head -n 1 | sed -E 's/.*version[[:space:]]+"([^"]+)".*/\1/')
  [ -n "$current_ver" ] || continue

  pkg_name=$(basename "$file" .rb)
  pkg_type="cask"
  if [[ "$file" == Formula/* ]]; then
    pkg_type="formula"
  fi

  repo=$(grep -o 'https://github.com/[^/"]\+/[^/"]\+' "$file" | head -n 1 | sed 's|https://github.com/||')
  [ -n "$repo" ] || continue

  tag=$(gh release view --repo "$repo" --json tagName -q .tagName 2>/dev/null || true)
  [ -n "$tag" ] || continue

  new_ver="${tag#v}"
  [ "$new_ver" != "$current_ver" ] || continue

  outdated_count=$((outdated_count + 1))

  if [ "$dry_run" = true ]; then
    report "dry-run: $pkg_type $pkg_name $current_ver -> $new_ver"
    continue
  fi

  release_info=$(gh release view "$tag" --repo "$repo" --json assets 2>/dev/null || true)
  sha_count=$(grep -c '^[[:space:]]*sha256' "$file" || true)

  tmp_file=$(mktemp)

  if [ "$sha_count" -le 1 ]; then
    url_template=$(grep -E '^[[:space:]]*url[[:space:]]+"' "$file" | head -n 1 | sed -E 's/^[[:space:]]*url[[:space:]]+"([^"]+)".*/\1/')
    target_url="${url_template//\#\{version\}/$new_ver}"
    asset_name="${target_url##*/}"
    new_sha=$(fetch_sha "$asset_name" "$target_url")

    awk -v new_ver="$new_ver" -v new_sha="$new_sha" '
      !v_done && sub(/version[[:space:]]+"[^"]+"/, "version \"" new_ver "\"") { v_done = 1 }
      !s_done && sub(/sha256[[:space:]]+"[^"]+"/, "sha256 \"" new_sha "\"") { s_done = 1 }
      { print }
    ' "$file" >"$tmp_file"
    mv "$tmp_file" "$file"
  else
    final_file=$(mktemp)
    awk -v new_ver="$new_ver" '
      !done && sub(/version[[:space:]]+"[^"]+"/, "version \"" new_ver "\"") { done = 1 }
      { print }
    ' "$file" >"$tmp_file"

    pending_asset=""
    pending_url=""

    while IFS= read -r line || [ -n "$line" ]; do
      if [[ "$line" =~ ^[[:space:]]*url[[:space:]]+\"([^\"]+)\" ]]; then
        raw_url="${BASH_REMATCH[1]}"
        resolved_url="${raw_url//\#\{version\}/$new_ver}"
        pending_asset="${resolved_url##*/}"
        pending_url="$resolved_url"
        echo "$line" >>"$final_file"
      elif [[ "$line" =~ ^([[:space:]]*)sha256[[:space:]]+\"[^\"]+\" ]] && [ -n "$pending_asset" ]; then
        indent="${BASH_REMATCH[1]}"
        new_sha=$(fetch_sha "$pending_asset" "$pending_url")
        echo "${indent}sha256 \"$new_sha\"" >>"$final_file"
        pending_asset=""
        pending_url=""
      else
        echo "$line" >>"$final_file"
      fi
    done <"$tmp_file"

    rm -f "$tmp_file"
    mv "$final_file" "$file"
  fi

  if ! git diff --quiet -- "$file"; then
    git add "$file"
    git commit -m "chore($pkg_type): update $pkg_name to $new_ver"
    report "updated: $pkg_type $pkg_name $current_ver -> $new_ver"
    updated_count=$((updated_count + 1))
  fi
done

if [ "$outdated_count" -eq 0 ]; then
  report "All packages are up to date."
fi

if [ "$updated_count" -gt 0 ] && [ -n "${GITHUB_ACTIONS:-}" ]; then
  git push
fi
