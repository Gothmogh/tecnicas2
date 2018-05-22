; ------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------
num1 equ 0x15
num2 equ 0x16
temp1 equ 0x20
temp2 equ 0x21
temp_result equ 0x22
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
    org 0x007
main
    movf num1,w ; almaceno factores en temporales
    movwf temp1
    movf num2,w
    movwf temp2
    org 0x0B
    bcf STATUS,Z ; limpio Z
    movf temp2,f ; muevo sobre si mismo para luego analizar Z
    btfsc STATUS,Z ; analizo z, si es 1 salteo, si no continuo y el prog termina
    goto $
    call sum
    addlw 1
    subwf temp2,f
    goto 0x0B
    org 0x020
sum
    movf temp1,w
    addwf temp_result,f
    clrw
    return
;**********************************************************************
    
    END ; directive 'end of program'





