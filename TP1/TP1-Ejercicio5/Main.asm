; Ejemplificación con variables:
; ------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------
; acá van las definiciones de las variables con su posición
prog_start equ 0x005
number_1_loc equ 0x3A
number_2_loc equ 0x3B
result_loc equ 0x3C
; -------------------------------------------------------------------
; Vectores
; ------------------------------------------------------------------
ORG 0x000 ; processor reset vector
goto main ; go to beginning of program
ORG 0x004 ; interrupt vector location
goto main ;
; ============================================
; PROGRAMA PRINCIPAL
; ============================================
org prog_start
main
movf number_2_loc,w ; seteo numero 2 en registro w
subwf number_1_loc,w ; le resto valor en w (numero 2) a numero 1 y guardo en w
movwf result_loc ; almaceno valor de w (resultado resta) en ubicacion final
 
;**********************************************************************
goto $
END ; directive 'end of program'

 
