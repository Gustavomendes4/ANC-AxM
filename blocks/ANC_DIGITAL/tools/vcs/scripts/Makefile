# Makefile Interno - Simulação VCS
# Localização: tools/vcs/scripts/Makefile

RUN_DIR    := $(VCS_DIR)/run
WORK_DIR   := $(VCS_DIR)/work

# Configuração de Modo (RTL vs Gate-Level)
GL ?= 0

ifeq ($(GL),1)
    $(info --- [MODO] Configurando para Gate-Level Simulation (Netlist) ---)
    FILELIST  = $(VERIF_DIR)/filelist_gl.f
    TOP_TB    = tb_ANC #top_tb_gl
    
    SDF_FILE := $(wildcard $(DC_DIR)/outputs_latest/*.sdf)
    
    ifneq ($(words $(SDF_FILE)),1)
        $(error ERRO: Encontrado $(words $(SDF_FILE)) arquivos .sdf. Precisa ser exatamente 1)
    endif

    DUT_INST  = uut
    COMP_ARGS += +define+GATE_LEVEL_SIM
    COMP_ARGS += -sdf max:$(TOP_TB).$(DUT_INST):$(SDF_FILE)
else
    $(info --- [MODO] Configurando para RTL Simulation ---)
    FILELIST  = $(VERIF_DIR)/filelist.f
    TOP_TB    = tb_ANC
endif

# Controle de Features (Tags de Linha de Comando)
GUI ?= 0
UVM ?= 0
COV ?= 0

SIM_TIME ?= 100000 # Em ns, Alterar dependendo de objetivo e testes

COMP_ARGS :=
RUN_ARGS  :=

# +vcs+finish is a hard cut on simulation time, and the value is in timescale
# PRECISION (1ps here), not ns. Under UVM the objections end the simulation, so
# the cut is left out - the watchdog is uvm_top.set_timeout() in anc_drv_test.
ifneq ($(UVM),1)
    RUN_ARGS += +vcs+finish+$(SIM_TIME)
endif

# Tags
ifeq ($(GUI),1)
    RUN_ARGS += -gui=verdi
endif

# UVM=1 switches filelist/top to the UVM testbench.
# UVM_TEST: anc_wav_test (default, whole file) or anc_base_test (1000 samples).
UVM_TEST ?= anc_wav_test

# Fractional bits of the C++ model. Must follow the RTL: ANC.v does not pass F
# down to LMS_Direct_10taps, which uses its default F=14.
MODEL_F ?= 14

ifeq ($(UVM),1)
    FILELIST  = $(VERIF_DIR)/filelist_uvm.f
    TOP_TB    = tb_top
    COMP_ARGS += -ntb_opts uvm-1.2

    # C++ model (DPI): declarations in model_dpi.sv, implementation in dpi.cpp.
    MODEL_CFLAGS := -I$(MODEL_DIR)/include -DMODEL_F=$(MODEL_F) -std=c++17
    COMP_ARGS += $(MODEL_DIR)/dpi.cpp -cpp g++ -CFLAGS "$(MODEL_CFLAGS)" -LDFLAGS "-lstdc++"

    ifneq ($(UVM_TEST),)
        RUN_ARGS += +UVM_TESTNAME=$(UVM_TEST)
    endif

    # WAV is required. WAV_SAMPLES and WAV_SHIFT are anc_wav_test only.
    ifneq ($(WAV),)
        RUN_ARGS += +WAV=$(WAV)
    endif
    ifneq ($(WAV_SAMPLES),)
        RUN_ARGS += +WAV_SAMPLES=$(WAV_SAMPLES)
    endif
    ifneq ($(WAV_SHIFT),)
        RUN_ARGS += +WAV_SHIFT=$(WAV_SHIFT)
    endif

    # Waves only with FSDB=1.
    ifeq ($(FSDB),1)
        RUN_ARGS += +FSDB
    endif

    # DUMP=<file>: per-cycle CSV. DUMP_W=1 adds the W coefficients (big file).
    ifneq ($(DUMP),)
        RUN_ARGS += +DUMP=$(DUMP)
    endif
    ifeq ($(DUMP_W),1)
        RUN_ARGS += +DUMP_W
    endif

    ifneq ($(RESET_AT),)
        RUN_ARGS += +RESET_AT=$(RESET_AT)
    endif
    ifneq ($(VERB),)
        RUN_ARGS += +UVM_VERBOSITY=$(VERB)
    endif
endif

ifeq ($(COV),1)
    COV_METRICS := line+cond+fsm+tgl+branch
    COMP_ARGS   += -cm $(COV_METRICS)
    RUN_ARGS    += -cm $(COV_METRICS) -cm_name $(TOP_TB)
endif

# Flags 
VCS_FLAGS := -full64 -sverilog -timescale=10ns/1ps -debug_access+all -kdb -l vcs_comp.log

.PHONY: sim setup comp run view_cov clean

# Regras Principais 
sim: setup comp run

setup:
	@echo "--- [VCS SETUP] Preparando diretório de execução em /run ---"
	@mkdir -p $(RUN_DIR)
	@if [ ! -f "$(FILELIST)" ]; then echo "ERRO: $(FILELIST) não encontrado!"; exit 1; fi
ifeq ($(UVM),1)
	@if [ -z "$(MODEL_DIR)" ]; then echo "ERRO: MODEL_DIR não definido - rode 'source setup.sh'"; exit 1; fi
	@if [ ! -f "$(MODEL_DIR)/dpi.cpp" ]; then echo "ERRO: $(MODEL_DIR)/dpi.cpp não encontrado!"; exit 1; fi
endif

comp:
	@echo "--- [VCS COMP] Compilando RTL e Testbench dentro de /run ---"
	cd $(RUN_DIR) && vcs $(VCS_FLAGS) $(COMP_ARGS) -f $(FILELIST) -top $(TOP_TB)

run:
	@echo "--- [VCS RUN] Executando Simulação em /run ---"
	cd $(RUN_DIR) && ./simv $(RUN_ARGS) -l vcs_run.log

view_cov:
	@echo "--- [VERDI COV] Abrindo Análise de Cobertura no Verdi ---"
	@if [ ! -d "$(RUN_DIR)/simv.vdb" ]; then \
		echo "ERRO: Banco de dados de cobertura não encontrado!"; \
		exit 1; \
	fi
	cd $(RUN_DIR) && verdi -cov -covdir simv.vdb &

clean:
	@echo "--- [VCS CLEAN] Limpando a pasta /run ---"
	rm -rf $(RUN_DIR)/