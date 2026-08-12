# TODO LIST
* Falta arrumar os paths do arquivo fm.tcl
* Temos que decifir onde colocar os arquivos coms os paths do pdk, não acho que seja ideial ter uma configuração de pdk no fm e outra no dc, analisar e criar um pasta com isso centralizado, pois isso pode virar bagunça

# Observaçõres
* Usar a pasta `synthesis_results` para guardar resultado importantes que demorarm para ser sintetizados, mover manualmente
* O DC cria uma pasta `runs` que dentro dela contem os resultados de cada execução, então da para fazer várias sinteses com constraints diferentes e ele irá fazer um snapshot das configurações usados, do rtl e dos reports.

# Para executar
* Entra em blocks e depois execute

```bash
source setup.sh
```

e depois o make desejado