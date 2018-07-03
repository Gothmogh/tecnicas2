;
; Escriba un programa que genere una onda cuadrada de aproximadamente 1.000 Hz en el pin
; menos significativo del puerto A. Realizar la temporización por programa (no usar los timers
; internos del PIC). Utilizar un reloj externo de 4 MHZ y realizar los cálculos de tiempo
; correspondientes
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
    movlw d'249' ; 1 CM
    movwf CONT ; 1 CM
BUCLE
    nop ; 1 CM
    decfsz CONT, w ; 1 CM si no salto y 2 CM si salto
    goto BUCLE ; 2 CM
    return ; 2CM
end;
;el retardo se calcula de la siguiente forma:
; T = 2 (call) + 1 (movlw) + 1 (movwf) + (249)*1 (NOP) + [(249-1)*1 + 2] (decsfz) +
; + (249-1)*2 (goto) + 2 (return)
; T = 2 + 1 + 1 + 249 + 248 + 2 + 496 + 2 = 1.001 useg ≈ 1 mseg