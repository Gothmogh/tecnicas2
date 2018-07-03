;
; Ejercicio nº 1:
; Escriba un programa para inicializar en “uno” un arreglo ubicado a partir de la dirección 40h.
; El tamaño del arreglo se encuentra en la dirección 2Ah (utilizando direccionamiento
; indirecto)     
;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------

pointer_start equ 0x40
length_location equ 0x2A

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
next	
    movlw	0x01			; carga literal 1 en W
    movwf	INDF			; carga W a registro INDF (donde apunta el puntero)
    incf	FSR			; incrementa el puntero
    decfsz	length_location		; decremento longitud
    goto	next			; NO, carga el siguiente
finish    
    goto	$
;**********************************************************************
    
    END ; directive 'end of program'





