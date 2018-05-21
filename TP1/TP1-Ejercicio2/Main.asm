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
prog_start equ 0x20
test_reg equ 0x1B
true_dest equ 0x5A
false_dest equ 0x12A
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
    movf test_reg,f ; muevo registro sobre si mismo para setear flag Z en reg Status
    btfss STATUS,Z ; analizo status Z, si es 0 continua, si es 1 saltea un paso
    goto false_dest
    goto true_dest
;**********************************************************************
    goto $
    END ; directive 'end of program'

 
