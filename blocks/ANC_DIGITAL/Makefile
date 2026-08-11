.PHONY: all help sim synth formal clean

all: help

help:
	@echo "Comandos disponíveis:"
	@echo "  make sim    - Carrega módulos e roda VCS"
	@echo "  make synth  - Carrega módulos e roda DC_NXT"
	@echo "  make formal - Carrega módulos e roda Formality"
	@echo "  make clean  - Limpa os diretórios"

# Regras de Execução (Carrega direto e delega para o sub-Makefile)
sim:
	@echo "--- Executando Simulação (VCS) ---"
	cd ${VCS_DIR}/scripts && make sim	

view_cov:
	@echo "--- Abrindo Cobertura (Verdi) ---"
	cd ${VCS_DIR}/scripts && make view_cov

synth:
	@echo "--- Executando Síntese (DC_NXT) ---"
	cd ${DC_DIR}/scripts && make synth

fm:
	@echo "--- Executando Equivalência (FM) ---"
	cd ${FM_DIR}/scripts && make fm

fc:
	@echo "--- Executando Equivalência (FC) ---"
	cd ${FC_DIR}/scripts && make fc
	
	
# Limpeza de Arquivos Temporários e Pastas de Execução
# TODO Arrumar isso depois após decidir onde ficará as pastas e evitar regex
clean:
	@echo "--- Iniciando limpeza do projeto /run de todas tools ---"
	
	@# 1. Tenta rodar o clean do sub-makefile do VCS (ignora erro se a pasta/arquivo não existir)
	@-cd tools/vcs/scripts && make clean 2>/dev/null || true
	
	@# 2. Esvazia o conteúdo de qualquer pasta run ou .run em todas as ferramentas de forma genérica
	@rm -rf tools/*/run/* tools/*/.run/*
	
	@# 3. Garante a remoção de arquivos ocultos dentro dessas pastas (ex: .vdb ou .lock)
	@rm -rf tools/*/run/.[a-zA-Z0-9]* tools/*/.run/.[a-zA-Z0-9]* 2>/dev/null || true
	
	@# 4. Remove lixo residual e logs que possam ter sido gerados na raiz do bloco
	@rm -rf *.log *.rpt work/ simv* csrc/ *.daidir/ verdiLog/ NOCOMP_INFO
	@echo "--- Limpeza concluída com sucesso ---"

# TODO Arrumar isso depois após decidir onde ficará as pastas
clean_hard_dc:
	@echo "--- Iniciando limpeza profunda do projeto /outputs and /rpt das rodadas antigas ---"
	@rm -rf tools/dc_nxt/rpt/* tools/dc_nxt/outputs/*

