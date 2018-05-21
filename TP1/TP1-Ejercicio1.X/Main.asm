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
primero equ 0x15
segundo equ 0x20
temp equ 0x21
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
movlw 0x10
movwf primero ;cargo valor a primero
movlw 0x20
movwf segundo ;cargo valor a segundo
movf primero,w
movwf temp
movf segundo,w
movwf primero
movf temp,w
movwf segundo
clrf temp
;**********************************************************************
goto $
END ; directive 'end of program'




