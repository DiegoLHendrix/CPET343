@REM *****************************************************************************
@REM This file will call the Quartus II programmer to program the DE1-SoC  board
@REM *****************************************************************************

quartus_pgm --mode=JTAG -o P;output_files\seven_seg.sof@2
pause
