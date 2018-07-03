;
; Escriba un programa para encontrar el menor elemento en un bloque de datos. La longitud del
; bloque está en la dirección 31h, y el bloque comienza a partir de la dirección 32h. El resultado
; debe guardarse en la dirección 50h.   
;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------

pointer_start equ 0x32
length_location equ 0x31
result equ 0x30

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
    movf  length_location,f	; opero sobre el registro para analizar si es 0
    btfsc STATUS,Z		; 
    goto  finish		; si es 0, termino
    movlw pointer_start		; inicializa el puntero
    movwf FSR			; a la RAM
    movlw 0xFF			; inicializo en el máximo valor posible
    movwf result
next
    movf	result,w
    subwf	INDF,w			; carga resta registro INDF de W y almacena en W
    btfsc	STATUS,C		; si era menor o igual salta
    goto	continue
    movf	INDF,w
    movwf	result
continue
    incf	FSR			; incrementa el puntero
    decfsz	length_location		; decremento longitud
    goto	next			; NO, carga el siguiente
finish    
    goto	$
;**********************************************************************
    
    END ; directive 'end of program'





