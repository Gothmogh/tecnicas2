; ------------------------------------------------------------------
; Encabezado
; ------------------------------------------------------------------
    list p=16f84a ; list directive to define processor
#include <p16f84a.inc> ; processor specific variable definitions
; ------------------------------------------------------------------
; Definición de Variables
; ------------------------------------------------------------------
prog_start equ 0x005
swap_mode_loc equ 0x11
rot_mode_loc equ 0x12
rot_tmp_loc equ 0x13

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
    org prog_start
main
    swapf swap_mode_loc,f ; nibble swap y almaceno en misma ubicacion
    movf rot_mode_loc,w ; muevo valor a registro W
    movwf rot_tmp_loc ; muevo valor de W a registro temporal
    bcf STATUS,C ; limpio el Carry y desplazo 1 bit a la izq - repito 4 veces
    rlf rot_mode_loc,f 
    bcf STATUS,C
    rlf rot_mode_loc,f 
    bcf STATUS,C
    rlf rot_mode_loc,f 
    bcf STATUS,C
    rlf rot_mode_loc,f
    bcf STATUS,C ; limpio el Carry y desplazo 1 bit a la der - repito 4 veces
    rrf rot_tmp_loc,f 
    bcf STATUS,C
    rrf rot_tmp_loc,f 
    bcf STATUS,C
    rrf rot_tmp_loc,f
    bcf STATUS,C
    rrf rot_tmp_loc,f
    movf rot_tmp_loc,w ; muevo registro temporal desplazado a la derecha al registro W
    iorwf rot_mode_loc,f ; operación OR entre registro W y registro desplazado a la izq, almaceno en registro
;**********************************************************************
    goto $
    END ; directive 'end of program' 
