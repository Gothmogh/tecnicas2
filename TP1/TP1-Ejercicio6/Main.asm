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
swap_mode_loc equ 0x11
rot_mode_loc equ 0x12

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
swapf swap_mode_loc,f ; nibble swap y almaceno en misma ubicacion
rlf rot_mode_loc,f ; desplazo 1 bit a la izq y almaceno en misma ubicacion
rlf rot_mode_loc,f ; desplazo 1 bit a la izq y almaceno en misma ubicacion
rlf rot_mode_loc,f ; desplazo 1 bit a la izq y almaceno en misma ubicacion
rlf rot_mode_loc,f ; desplazo 1 bit a la izq y almaceno en misma ubicacion
 
;**********************************************************************
goto $
END ; directive 'end of program'

 