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
prog_start equ 0x300
literal_value equ 0xA7
test_loc equ 0x46
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
    movlw literal_value ; seteo literal en registro w
    iorwf test_loc,f ; opero con registro test y almaceno ahi mismo
 
;**********************************************************************
    goto $
    END ; directive 'end of program'

 
