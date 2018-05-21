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
prog_start equ 0x100
number_1_loc equ 0x25
number_2_loc equ 0x26
number_3_loc equ 0x27
result_loc equ 0x28
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
    clrw ; seteo a cero registro w
    clrf result_loc ; seteo a cero registro result
    addwf number_1_loc,w ;sumo registro 1 con w y almaceno en w
    addwf number_2_loc,w ;sumo registro 1 con w y almaceno en w
    addwf number_3_loc,w ;sumo registro 1 con w y almaceno en w
    movwf result_loc ;sumo registro 1 con w y almaceno en w
 
;**********************************************************************
    goto $
    END ; directive 'end of program'

 
