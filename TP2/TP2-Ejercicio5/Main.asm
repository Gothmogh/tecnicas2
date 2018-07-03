;
; Diseñe el control de nivel para un tanque de agua, Al pulsar “INICIO” se activa la bomba B1.
; La bomba permanece encendida hasta alcanzar el nivel máximo, cuando se abre la válvula de
; “RIEGO”. La bomba se activa nuevamente cuando llegue al valor mínimo y se cierra la válvula.
; Se repite el ciclo, sin tener que presionar “INICIO”
;    
;------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------0

bomb_bit	    equ RA0
valve_bit	    equ	RA1
pulser_bit	    equ	RA3
min_level	    equ d'5'
max_level	    equ	d'15'

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
    movlw   b'11111111'
    movwf   TRISB		; seteo puerto b en entrada para leer nivel
    bsf	    TRISA,pulser_bit	; seteo bit de pulsador en entrada
    bcf	    STATUS,RP0		; vuelvo al banco 0

read_pulse
    btfss   PORTA,pulser_bit	; analizo valor pulsador, si esta seteado saltea
   goto    read_pulse		; si no esta seteado, vuelvo a leer
wait_down			; espero a que el valor del puerto vuelva a 0, para contar una vez por pulso
    btfsc   PORTA,pulser_bit	; analizo valor pulsador, si NO esta seteado saltea
    goto    wait_down		; si esta seteado, vuelvo a continuo ejecucion
    call    start_bomb
    call    check_level		; vuelve cuando llega al maximo (w = 1) o al minimo (w = 0)
		 
;**********************************************************************
start_bomb
    bsf	    PORTA,bomb_bit
    return
stop_bomb
    bcf	    PORTA,bomb_bit
    return
open_valve
    bcf	    PORTA,valve_bit
    return
close_valve
    bcf	    PORTA,valve_bit
    return
check_level		    ; chequea nivel hasta alcanzar maximo (devuelve 1) o minimo (devuelve 0)
    movf    PORTB,w
    sublw   min_level	; comparo igualdad con contador 	
    btfsc   STATUS,Z		; si es igual, Z es 1 y ejecuta sig instruccion, si no saltea
    call    action_on_min_level	; si es 0 llamo subrutina nivel minimo
    movf    PORTB,w
    sublw   max_level	; comparo igualdad con contador 	
    btfsc   STATUS,Z		; si es igual, Z es 1 y ejecuta sig instruccion, si no saltea
    call    action_on_max_level	; si es 1 llamo subrutina nivel maximo
    goto    check_level
action_on_max_level
    call    stop_bomb
    call    open_valve
    return
action_on_min_level
    call    start_bomb
    call    close_valve
    return
    
    
    END ; directive 'end of program'