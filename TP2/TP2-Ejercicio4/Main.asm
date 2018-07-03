;
; Diseñe un contador de 8 bits, que se incrementa cada vez que se pulsa “P” (bit 3 del puerto A).
; Visualice el resultado por el puerto B. Activar un “LED” (bit 0 del puerto A) cuando el contador
; llegue a d125 y apagarlo cuando llegue a d225. Reiniciar el ciclo
;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------

led_bit		    equ RA0
pulser_bit	    equ	RA3
counter		    equ 0x10
led_on_count	    equ d'125'
led_off_count	    equ d'225'
reset_count	    equ d'255'

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
    bsf	    STATUS,RP0		; cambio de banco para configurar puertos
    clrf    TRISA		; seteo puerto a en salida
    clrf    TRISB		; seteo puerto b en salida
    bsf	    TRISA,pulser_bit	; seteo bit de pulsador en entrada
    bcf	    STATUS,RP0		; vuelvo al banco 0
begin
    clrf    counter		; seteo en 0 el contador
    goto    led_off
loop
    btfss   PORTA,pulser_bit	; analizo valor pulsador, si esta seteado saltea
    goto    loop		; si no esta seteado, vuelvo a leer
    incf    counter,f
    movf    counter,w		; cargo contador en W
    movwf   PORTB		; cargo valor de W en Puerto B
    sublw   led_on_count	; comparo igualdad con contador 	
    btfsc   STATUS,Z		; si es igual, Z es 1 y ejecuta sig instruccion, si no saltea
    goto    led_on		; se ejecuta llamada a encendido de led y vuelve a iniciar loop 
    movf    counter,w		; cargo contador en W
    sublw   led_off_count	; idem para apagado
    btfsc   STATUS,Z		; 
    goto    led_off		; 
    movf    counter,w		; cargo contador en W
    sublw   reset_count		; idem para reset
    btfsc   STATUS,Z		
    goto    begin		; reinicio rutina con reseteo de contador
wait_down			; espero a que el valor del puerto vuelva a 0, para contar una vez por pulso
    btfsc   PORTA,pulser_bit	; analizo valor pulsador, si NO esta seteado saltea
    goto    wait_down		; si esta seteado, vuelvo a leer
    goto    loop		 
;**********************************************************************
led_on
    bsf	    PORTA,led_bit
    goto    wait_down
led_off
    bcf	    PORTA,led_bit
    goto    wait_down

	 
    END ; directive 'end of program'