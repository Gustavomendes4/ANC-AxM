# Makefile Interno - Logic Equivalence Checking (Formality)
# Localização: tools/fm/scripts/Makefile

# TODO: Ver como organixar os logs para o fm da sintese e o do dft
WORK_DIR   := $(FM_DIR)/work
REPORT_DIR   := $(FM_DIR)/reports
LOG_DIR   := $(FM_DIR)/logs
SCRIPT_SYNTHESIS    := $(FM_DIR)/scripts/fm_synthesis.tcl
SCRIPT_DFT    := $(FM_DIR)/scripts/fm_dft.tcl

GUI ?= 0
FM_ARGS_SYNTHESIS   := -f $(SCRIPT_SYNTHESIS)
ifeq ($(GUI),1)
    FM_ARGS_SYNTHESIS   += -gui
endif

FM_ARGS_DFT := -f $(SCRIPT_DFT)
ifeq ($(GUI),1)
    FM_ARGS_DFT += -gui
endif

.PHONY: fm setup run clean

fm_synthesis: setup run_synthesis

fm_dft: setup run_dft


setup:
	@echo "--- [FM SETUP] Preparando diretorios de execucao ---"
	@mkdir -p $(WORK_DIR) $(REPORT_DIR) $(LOG_DIR)
	@if [ ! -f "$(SCRIPT_SYNTHESIS)" ]; then echo "ERRO: $(SCRIPT_SYNTHESIS) nao encontrado!"; exit 1; fi

run_synthesis:
	@echo "--- [FM RUN] Executando Equivalencia Logica em /run ---"
	cd $(WORK_DIR) && fm_shell $(FM_ARGS_SYNTHESIS) | tee $(LOG_DIR)/fm.log

run_dft:
	@echo "--- [FM RUN] Executando Equivalencia Logica em /run ---"
	cd $(WORK_DIR) && fm_shell $(FM_ARGS_DFT) | tee $(LOG_DIR)/fm.log

clean:
	@echo "--- [FM CLEAN] Limpando a pasta /run e relatorios ---"
	rm -rf $(WORK_DIR)/*
	rm -f $(REPORT_DIR)/formality_*.rpt
	rm -f $(LOG_DIR)/fm*.log
	rm -rf $(WORK_DIR)/FM_WORK*
	rm -rf $(WORK_DIR)/formality.log*