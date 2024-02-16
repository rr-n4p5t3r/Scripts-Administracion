@echo off
:: Mover archivos con extensión .txt a un directorio específico, puede funcionar con cualquier extension
if not exist txt_files mkdir txt_files
move *.txt txt_files
