#!/bin/bash
# NovaHub Rebranding Script
# Systematically replaces NovaHub references with NovaHub

set -e

REPO_DIR="/home/mrnova420/NovaHub"
cd "$REPO_DIR"

echo "🚀 Starting NovaHub rebranding..."

# Backup count
echo "📊 Finding files to modify..."
grep -r "novahub" --exclude-dir=node_modules --exclude-dir=.git --exclude="*.lock" . | wc -l

# Replace in all files (case-sensitive)
echo "🔄 Replacing 'novahub' with 'novahub'..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -not -name "*.png" -not -name "*.jpg" -not -name "*.svg" -not -name "*.ico" -exec sed -i 's/novahub/novahub/g' {} + 2>/dev/null || true

echo "🔄 Replacing 'novahub' with 'novahub'..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -not -name "*.png" -not -name "*.jpg" -not -name "*.svg" -not -name "*.ico" -exec sed -i 's/novahub/novahub/g' {} + 2>/dev/null || true

echo "🔄 Replacing 'NovaHub' with 'NovaHub'..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -not -name "*.png" -not -name "*.jpg" -not -name "*.svg" -not -name "*.ico" -exec sed -i 's/NovaHub/NovaHub/g' {} + 2>/dev/null || true

echo "🔄 Replacing 'NOVAHUB' with 'NOVAHUB'..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -not -name "*.png" -not -name "*.jpg" -not -name "*.svg" -not -name "*.ico" -exec sed -i 's/NOVAHUB/NOVAHUB/g' {} + 2>/dev/null || true

echo "🔄 Replacing URLs and domains..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -exec sed -i 's|https://novahub\.ai|https://novahub.dev|g' {} + 2>/dev/null || true
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -exec sed -i 's|novahub\.ai|novahub.dev|g' {} + 2>/dev/null || true

echo "🔄 Replacing GitHub references..."
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -exec sed -i 's|anomalyco/novahub|MrNova420/NovaHub|g' {} + 2>/dev/null || true
find . -type f -not -path "*/node_modules/*" -not -path "*/.git/*" -not -name "*.lock" -exec sed -i 's|@MrNova420|@MrNova420|g' {} + 2>/dev/null || true

# Rename directories and files
echo "📁 Renaming directories..."
find . -depth -name "*novahub*" -not -path "*/node_modules/*" -not -path "*/.git/*" 2>/dev/null | while read -r path; do
    newpath=$(echo "$path" | sed 's/novahub/novahub/g')
    if [ "$path" != "$newpath" ]; then
        mv "$path" "$newpath" 2>/dev/null || true
        echo "  Renamed: $path -> $newpath"
    fi
done

echo "✅ Rebranding complete!"
echo ""
echo "📋 Next steps:"
echo "  1. Review changes: git diff"
echo "  2. Update logos and assets manually"
echo "  3. Test build: bun install && bun run dev"
echo "  4. Commit: git add . && git commit -m 'Rebrand to NovaHub'"
