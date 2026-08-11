# Makefile Interno - Logic Equivalence Checking (Formality)
# Localização: tools/fm/scripts/Makefile

WORK_DIR   := $(FM_DIR)/work
REPORT_DIR   := $(FM_DIR)/report
LOG_DIR   := $(FM_DIR)/logs
SCRIPT    := $(FM_DIR)/scripts/fm.tcl

GUI ?= 0
FM_ARGS := -f $(SCRIPT)
ifeq ($(GUI),1)
    FM_ARGS += -gui
endif

.PHONY: fm setup run clean

fm: setup run

setup:
	@echo "--- [FM SETUP] Preparando diretorios de execucao ---"
	@mkdir -p $(WORK_DIR) $(REPORT_DIR) $(LOG_DIR)
	@if [ ! -f "$(SCRIPT)" ]; then echo "ERRO: $(SCRIPT) nao encontrado!"; exit 1; fi

run:
	@echo "--- [FM RUN] Executando Equivalencia Logica em /run ---"
	cd $(WORK_DIR) && fm_shell $(FM_ARGS) | tee $(LOG_DIR)/fm.log

clean:
	@echo "--- [FM CLEAN] Limpando a pasta /run e relatorios ---"
	rm -rf $(WORK_DIR)/*
	rm -f $(REPORT_DIR)/formality_*.rpt
	rm -f $(LOG_DIR)/fm*.log
	rm -rf $(WORK_DIR)/FM_WORK*
	rm -rf $(WORK_DIR)/formality.log*