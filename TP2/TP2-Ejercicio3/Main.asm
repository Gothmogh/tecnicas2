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

eval equ 0x30

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
   
    movf eval,w
    call AKNCONV
    goto main
;**********************************************************************
    
    
 
 AKNCONV addwf	    PCL,f
	 retlw	    b'00000000'	    ;0
	 retlw	    b'00000001'	    ;1
	 retlw	    b'00000010'	    ;2
	 retlw	    b'00000011'	    ;3
	 retlw	    b'00000100'	    ;4
	 retlw	    b'00001011'	    ;5
	 retlw	    b'00001100'	    ;6
	 retlw	    b'00001101'	    ;7
	 retlw	    b'00001110'	    ;8
	 retlw	    b'00001111'	    ;9
	 
 
    END ; directive 'end of program'





