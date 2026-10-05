#!/usr/bin/env bash
set -e

RUN_NAME="$1"
LABEL="$2"

if [ -z "$RUN_NAME" ] || [ -z "$LABEL" ]; then
    echo "Usage: $0 <run_name> <short-label>"
    echo "Available runs:"
    ls "${DC_DIR}/runs/"
    exit 1
fi

SRC="${DC_DIR}/runs/${RUN_NAME}"
if [ ! -d "$SRC" ]; then
    echo "ERROR: ${SRC} not found."
    exit 1
fi

DATE_TAG=$(date +%Y-%m-%d)
DEST="${ANC_DIGITAL_ROOT}/synthesis_results/${DATE_TAG}_${LABEL}"

mkdir -p "${DEST}/reports" "${DEST}/outputs"
cp "${SRC}"/reports/*.rpt "${DEST}/reports/" 2>/dev/null || true
cp "${SRC}"/outputs/top_syn.v "${DEST}/outputs/" 2>/dev/null || true
cp "${SRC}"/outputs/top.ddc  "${DEST}/outputs/" 2>/dev/null || true
cp "${SRC}"/outputs/top.sdc  "${DEST}/outputs/" 2>/dev/null || true

GIT_COMMIT=$(git -C "${ANC_DIGITAL_ROOT}" rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH=$(git -C "${ANC_DIGITAL_ROOT}" rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")

cat > "${DEST}/meta.txt" <<META
Archived from run: ${RUN_NAME}
Archived on:        $(date)
Git commit:          ${GIT_COMMIT}
Git branch:          ${GIT_BRANCH}
Label:               ${LABEL}

META

echo "Archived to: ${DEST}"