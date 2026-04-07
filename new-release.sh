#!/bin/bash
# ─────────────────────────────────────────────
# S&N Infrastructure — New Release Note Script
# Run from the root of the ReleaseNotes repo
# ─────────────────────────────────────────────

set -e

echo ""
echo "═══════════════════════════════════════════"
echo "  S&N Infrastructure — New Release Note"
echo "═══════════════════════════════════════════"
echo ""

# ── FORM SPACE ──────────────────────────────
echo "Select a Form Space:"
echo "  1) Tillman"
echo "  2) Glo"
echo "  3) Ripple"
echo "  4) CVEC"
echo "  5) APB"
echo "  6) Dominion"
echo "  7) Southern Company"
echo ""
read -p "Enter number: " SPACE_CHOICE

case $SPACE_CHOICE in
  1) FORM_SPACE="Tillman";        SPACE_FOLDER="tillman" ;;
  2) FORM_SPACE="Glo";            SPACE_FOLDER="glo" ;;
  3) FORM_SPACE="Ripple";         SPACE_FOLDER="ripple" ;;
  4) FORM_SPACE="CVEC";           SPACE_FOLDER="cvec" ;;
  5) FORM_SPACE="APB";            SPACE_FOLDER="apb" ;;
  6) FORM_SPACE="Dominion";       SPACE_FOLDER="dominion" ;;
  7) FORM_SPACE="Southern Company"; SPACE_FOLDER="southern-company" ;;
  *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

# ── FORM NAME ───────────────────────────────
echo ""
read -p "Form Name (e.g. SPLICE POINT): " FORM_NAME
FORM_FOLDER=$(echo "$FORM_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# ── VERSION ─────────────────────────────────
echo ""
read -p "Version Number (e.g. 1.36): " VERSION_NUM
VERSION_DISPLAY="Ver $VERSION_NUM"
VERSION_FILE=$(echo "$VERSION_NUM" | tr '.' '-')

# ── RELEASE DATE ────────────────────────────
echo ""
read -p "Release Date (e.g. April 7, 2025): " RELEASE_DATE

# ── AUTHOR ──────────────────────────────────
echo ""
read -p "Authored By: " AUTHOR

# ── CHANGE CATEGORY ─────────────────────────
echo ""
echo "Change Category:"
echo "  1) Bug Fix"
echo "  2) New Feature"
echo "  3) Improvement"
echo "  4) Data Integrity"
echo "  5) Workflow"
read -p "Enter number: " CAT_CHOICE

case $CAT_CHOICE in
  1) CATEGORY="Bug Fix" ;;
  2) CATEGORY="New Feature" ;;
  3) CATEGORY="Improvement" ;;
  4) CATEGORY="Data Integrity" ;;
  5) CATEGORY="Workflow" ;;
  *) echo "Invalid choice. Exiting."; exit 1 ;;
esac

# ── CHANGE TITLE ────────────────────────────
echo ""
read -p "Title of the Change: " CHANGE_TITLE

# ── CHANGE DESCRIPTION ──────────────────────
echo ""
echo "Full description of what changed and why"
echo "(Press Enter twice when done):"
CHANGE_DESC=""
while IFS= read -r line; do
  [[ -z "$line" ]] && break
  CHANGE_DESC+="$line "
done

# ── SUMMARY ─────────────────────────────────
echo ""
echo "───────────────────────────────────────────"
echo "  Summary"
echo "───────────────────────────────────────────"
echo "  Form Space : $FORM_SPACE"
echo "  Form       : $FORM_NAME"
echo "  Version    : $VERSION_DISPLAY"
echo "  Date       : $RELEASE_DATE"
echo "  Author     : $AUTHOR"
echo "  Category   : $CATEGORY"
echo "  Change     : $CHANGE_TITLE"
echo "───────────────────────────────────────────"
echo ""
read -p "Create release note? (y/n): " CONFIRM
[[ "$CONFIRM" != "y" ]] && echo "Cancelled." && exit 0

# ── CREATE FILES ────────────────────────────
NOTE_DIR="docs/$SPACE_FOLDER/$FORM_FOLDER"
INDEX_PATH="$NOTE_DIR/index.md"
NOTE_PATH="$NOTE_DIR/ver-$VERSION_FILE.md"

mkdir -p "$NOTE_DIR"

# Create form index if it doesn't exist
if [ ! -f "$INDEX_PATH" ]; then
cat > "$INDEX_PATH" << EOF
---
title: $FORM_NAME
parent: $FORM_SPACE
nav_order: 1
has_children: true
permalink: docs/$SPACE_FOLDER/$FORM_FOLDER/
---

# $FORM_NAME

Release notes for the $FORM_NAME form in the $FORM_SPACE form space.

| Version | Date | Author | Summary |
|---|---|---|---|
| [$VERSION_DISPLAY](ver-$VERSION_FILE) | $RELEASE_DATE | $AUTHOR | $CHANGE_TITLE |
EOF
  echo "✓ Created form index: $INDEX_PATH"
else
  # Add new row to top of table in existing index
  NEW_ROW="| [$VERSION_DISPLAY](ver-$VERSION_FILE) | $RELEASE_DATE | $AUTHOR | $CHANGE_TITLE |"
  sed -i "/^|---|/a $NEW_ROW" "$INDEX_PATH"
  echo "✓ Updated form index: $INDEX_PATH"
fi

# Create the release note
cat > "$NOTE_PATH" << EOF
---
title: $VERSION_DISPLAY — $FORM_NAME
parent: $FORM_NAME
nav_order: 1
---

# $VERSION_DISPLAY — $FORM_NAME

**Form Space:** $FORM_SPACE
**Form:** $FORM_NAME
**Release Date:** $RELEASE_DATE
**Authored By:** $AUTHOR

---

## $CATEGORY

### $CHANGE_TITLE

$CHANGE_DESC

**Affected:** $FORM_SPACE — $FORM_NAME

---

## Summary of Changes

| Category | Description |
|---|---|
| $CATEGORY | $CHANGE_TITLE |
EOF

echo "✓ Created release note: $NOTE_PATH"

# ── GIT COMMIT ──────────────────────────────
echo ""
read -p "Commit and push to GitHub now? (y/n): " GIT_CONFIRM
if [[ "$GIT_CONFIRM" == "y" ]]; then
  git add .
  git commit -m "Add $VERSION_DISPLAY release note — $FORM_SPACE / $FORM_NAME"
  git push
  echo ""
  echo "✓ Pushed to GitHub. Site will update in ~60 seconds."
else
  echo ""
  echo "Files created. Run 'git add . && git commit -m \"...\" && git push' when ready."
fi

echo ""
echo "Done!"
