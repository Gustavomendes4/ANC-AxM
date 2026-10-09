#!/usr/bin/env bash

# Load with "source setup.sh". No "set -e": when sourced it applies to the
# user's shell and closes it on the first failing command.

### PATHS
# project root
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
export ANC_DIGITAL_ROOT="${SCRIPT_DIR}"

# directories
export RTL_DIR="${ANC_DIGITAL_ROOT}/rtl"
export VERIF_DIR="${ANC_DIGITAL_ROOT}/verif"
export MODEL_DIR="${VERIF_DIR}/model_cpp"
export CONSTRAINTS_DIR="${ANC_DIGITAL_ROOT}/constraints"

# tools scripts
export SYNTH_DIR="${ANC_DIGITAL_ROOT}/tools"
export DC_DIR="${SYNTH_DIR}/dc"
export FC_DIR="${SYNTH_DIR}/fc"
export FM_DIR="${SYNTH_DIR}/fm"
export VCS_DIR="${SYNTH_DIR}/vcs"



### MODULES
MODULES=(
    "syn/W-2024.09-SP5-2"
    "fusioncompiler/W-2024.09-SP3"
    "designcompiler/W-2024.09-SP5-4"
    "vcs/W-2024.09-SP2-3"
    "verdi/W-2024.09-SP2-6"
    "fm/W-2024.09-SP5"


)

echo "Loading Synopsys modules..."
SETUP_FAILED=0
for mod in "${MODULES[@]}"; do
    if ! module load "${mod}"; then
        echo "ERRO: falha ao carregar o modulo ${mod}"
        SETUP_FAILED=1
    fi
done

### Summary
echo
echo " ANC-AxM environment configured"
echo "ANC_DIGITAL_ROOT     = ${ANC_DIGITAL_ROOT}"
echo "RTL_DIR          = ${RTL_DIR}"
echo "CONSTRAINTS_DIR  = ${CONSTRAINTS_DIR}"
echo "VERIFICATION_DIR = ${VERIF_DIR}"
echo "MODEL_DIR        = ${MODEL_DIR}"
echo "SYNTH_DIR        = ${SYNTH_DIR}"
echo "DC_DIR           = ${DC_DIR}"
echo "FC_DIR           = ${FC_DIR}"
echo "FM_DIR           = ${FM_DIR}"
echo "VCS_DIR          = ${VCS_DIR}"
echo "=========================================="

if [ "${SETUP_FAILED}" -ne 0 ]; then
    echo "ATENCAO: ambiente INCOMPLETO - veja os erros acima antes de rodar make"
fi
