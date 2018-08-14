;
; Dado un número almacenado en un registro transmitirlo por el pin A2.
;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------0

;   F=1/4T --- T=1*4/F
;   Si F=4MHz --- T=1/F = 1*4/4000000 =1useg = 1 CM (ciclo máquina)
CONT equ h'10'
TEMP_VAR equ d'200'
MULT1 equ d'50'
MULT2 equ d'50'
_MULT1 equ h'11'
_MULT2 equ h'12'
DATA_REG equ h'20'
CONT2 equ h'13'

    ORG 0
    goto INICIO
;--- CONFIGURACIÓN DE PUERTOS
    bsf STATUS, RP0
    clrf TRISA
    bcf STATUS, RP0
; -- PROGRAMA PRINCIPAL
INICIO
    movlw d'8' ; long de palabra 8 bits
    movwf CONT2 ; cargo a variable temporal
LOOP
    btfsc STATUS,Z;
    goto FIN;
    dcs
    rlf DATA_REG ; rotación de dato hacia la izquierda, cargando msb en carry
    btfsc STATUS, C ; analizo carry , si es 1 sigo, si es 0 salteo
    goto HIGH_WRITE
    goto LOW_WRITE
HIGH_WRITE
    bsf	PORTA, RA2
    call RETARDO ; 2 CM
    decfsz CONT2
    goto LOOP
    goto FIN
LOW_WRITE
    clrf PORTA
    call RETARDO ; 2 CM
    decfsz CONT2
    goto LOOP
    goto FIN
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
FIN
    end;
;el retardo se calcula de la siguiente forma:
; T = 2 (call) + 1 (movlw) + 1 (movwf) + (200)*1 (NOP) + [(200-1)*1 + 2] (decsfz) +
; + (200-1)*2 (goto) + 2 (return)
; T = 2 + 1 + 1 + 249 + 248 + 2 + 496 + 2 = 803 useg
;
; agregados los multiplicadores, simplemente se setean con valores que multiplicados a T den el retardo deseado
; TMult = MULT1 * MULT2 * T = 50 * 50 * 803 useg = 2007500 useg ≈ 2 seg
; Frec Señal = 1 / TMult = 1 / 2 seg = 0.5 Hz