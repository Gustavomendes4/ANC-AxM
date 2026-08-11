.PHONY: all help sim synth formal clean

all: help

help:
	@echo "Comandos disponíveis:"
	@echo "  make sim    - Roda VCS"
	@echo "  make synth  - Roda DC_NXT"
	@echo "  make formal - Roda Formality"
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
clean:
	@echo "--- Iniciando limpeza do projeto /run de todas tools ---"
	
	@# Roda o clean do sub-makefile do VCS
	@-cd ${VCS_DIR}/scripts && make clean 2>/dev/null || true

	@# Roda o clean do sub-makefile do DC
	@-cd ${DC_DIR}/scripts && make clean 2>/dev/null || true

	@# Roda o clean do sub-makefile do FM
	@-cd ${FM_DIR}/scripts && make clean 2>/dev/null || true

	@# Roda o clean do sub-makefile do FC
	@-cd ${FC_DIR}/scripts && make clean 2>/dev/null || true

	@# Apaga qualquer pasta run
	@rm -rf tools/*/run/
	
	@# Remove lixo residual e logs que possam ter sido gerados na raiz do bloco
	@rm -rf *.log *.rpt work/ simv* csrc/ *.daidir/ verdiLog/ NOCOMP_INFO
	@echo "--- Limpeza concluída com sucesso ---"

