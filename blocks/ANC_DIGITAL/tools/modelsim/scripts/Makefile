# Makefile Interno - Simulação ModelSim/Questasim
# Localização: tools/modelsim/scripts/Makefile

RUN_DIR    := $(MODELSIM_DIR)/run
WORK_LIB   := work

# Configuração de Modo (RTL vs Gate-Level)
GL ?= 0

ifeq ($(GL),1)
    $(info --- [MODO] Configurando para Gate-Level Simulation (Netlist) ---)
    FILELIST  = $(VERIF_DIR)/filelist_gl.f
    TOP_TB    = tb_ANC

    SDF_FILE := $(wildcard $(DC_DIR)/outputs_latest/*.sdf)
    ifneq ($(words $(SDF_FILE)),1)
        $(error ERRO: Encontrado $(words $(SDF_FILE)) arquivos .sdf. Precisa ser exatamente 1)
    endif
    SDF_ARG := -sdfmax /tb_ANC/uut=$(SDF_FILE)
else
    $(info --- [MODO] Configurando para RTL Simulation ---)
    FILELIST  = $(VERIF_DIR)/filelist.f
    TOP_TB    = tb_ANC
    SDF_ARG   :=
endif

# Controle de Features
GUI ?= 0

SIM_TIME ?= 100000ns

VLOG_FLAGS := -sv -timescale=1ns/1ps
VSIM_FLAGS := -voptargs=+acc $(SDF_ARG)

.PHONY: sim setup comp run clean

sim: setup comp run

setup:
	@echo "--- [MODELSIM SETUP] Preparando diretório de execução em /run ---"
	@mkdir -p $(RUN_DIR)
	@if [ ! -f "$(FILELIST)" ]; then echo "ERRO: $(FILELIST) não encontrado!"; exit 1; fi
	cd $(RUN_DIR) && vlib $(WORK_LIB)

comp:
	@echo "--- [MODELSIM COMP] Compilando RTL e Testbench dentro de /run ---"
	cd $(RUN_DIR) && vlog $(VLOG_FLAGS) -work $(WORK_LIB) -f $(FILELIST)

run:
ifeq ($(GUI),1)
	@echo "--- [MODELSIM RUN] Abrindo em modo GUI (waveform interativo) ---"
	cd $(RUN_DIR) && vsim $(VSIM_FLAGS) -do "$(MODELSIM_DIR)/scripts/wave.do; run $(SIM_TIME)" $(WORK_LIB).$(TOP_TB)
else
	@echo "--- [MODELSIM RUN] Executando em modo batch (limite: $(SIM_TIME)) ---"
	cd $(RUN_DIR) && vsim -c $(VSIM_FLAGS) -do "run $(SIM_TIME); quit -f" $(WORK_LIB).$(TOP_TB) | tee vsim_run.log
endif

clean:
	@echo "--- [MODELSIM CLEAN] Limpando a pasta /run ---"
	rm -rf $(RUN_DIR)/
