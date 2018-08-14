;
; Escriba un programa que genere una onda cuadrada de frecuencia visible (al menos 50 Hz) en
; el pin menos significativo del puerto A. Utilizar un reloj de 4 MHZ y realizar los cálculos de
; tiempo correspondientes (sin utilizar timer interno)
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
; T = 2 (call) + 1 (movlw) + 1 (movwf) + (200)*1 (NOP) + [(200-1)*1 + 2] (decsfz) +
; + (200-1)*2 (goto) + 2 (return)
; T = 2 + 1 + 1 + 249 + 248 + 2 + 496 + 2 = 803 useg
;
; agregados los multiplicadores, simplemente se setean con valores que multiplicados a T den el retardo deseado
; TMult = MULT1 * MULT2 * T = 50 * 50 * 803 useg = 2007500 useg ≈ 2 seg
; Frec Señal = 1 / TMult = 1 / 2 seg = 0.5 Hz