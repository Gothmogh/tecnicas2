

;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------0
;
; INFO
;    
;    The rate selection, as already seen, is made by the BRGH bit in TXSTA register:
;	--  1 = High speed
;	--  0 = Low speed
;   For each baud rate we need to calculate the value being placed in the SPBRG differently:
;	SPBRG = (Fosc / (16 x Baud rate)) - 1, BRGH = 1 High Speed
;	SPBRG = (Fosc / (64 x Baud rate)) - 1, BRGH = 0 Low Speed
;    
;   Calculo (Low speed):
;    Baud rate = 1.2kbps = 1200bps
;    SPBRG = (4MHz / (64 x 1200)) - 1 = 51.08 = 51 (parte entera)
;    BRGH = 0 (Low speed)
;    
    
SPBRG_VALUE equ d'51'
SPEED_VALUE equ b'0'
MULT1 equ d'50'
MULT2 equ d'50'
_MULT1 equ h'11'
_MULT2 equ h'12'

    ORG 0
    goto INICIO
;--- CONFIGURACIÓN DE PUERTOS
    bsf STATUS, RP0
    clrf TRISA
    bcf STATUS, RP0
; -- PROGRAMA PRINCIPAL
INICIO
    movlw b'1'
    movwf PORTA
    call RETARDO ; 2 CM
    clrf PORTA
    call RETARDO ; 2 CM
    goto INICIO

RETARDO
    movlw MULT1 ; 1 CM
    movwf _MULT1 ; 1 CM
RETARDO_1
    movlw MULT2 ; 1 CM
    movwf _MULT2 ; 1 CM
RETARDO_2
    movlw TEMP_VAR ; 1 CM
    movwf CONT ; 1 CM
BUCLE
    nop ; 1 CM
    decfsz CONT, f ; 1 CM si no salto y 2 CM si salto
    goto BUCLE ; 2 CM
    
    decfsz _MULT2, f ; 1 CM si no salto y 2 CM si salto
    goto RETARDO_2 ; 2 CM
    
    decfsz _MULT1, f ; 1 CM si no salto y 2 CM si salto
    goto RETARDO_1 ; 2 CM
    
    return ; 2CM
    end;
;el retardo se calcula de la siguiente forma:
; T = 2 (call) + 1 (movlw) + 1 (movwf) + (249)*1 (NOP) + [(249-1)*1 + 2] (decsfz) +
; + (249-1)*2 (goto) + 2 (return)
; T = 2 + 1 + 1 + 249 + 248 + 2 + 496 + 2 = 1.001 useg ≈ 1 mseg