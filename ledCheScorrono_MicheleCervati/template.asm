;******************
;* Struttura base programma con la PIC 16F84A *
;*                                            *
;        [Ritardare l'accensione di un led]
;
;             (c) 2023, Michele Cervati
;
;******************
	PROCESSOR       16F84A               ;definizione del tipo di Pic per il quale è stato scritto il programma
	RADIX           DEC                  ;i numeri scritti senza notazione sono da intendersi come decimali
	INCLUDE         "P16F84A.INC"        ;inclusione del file che contiene la definizione delle costanti di riferimento al file dei
	                                     ;registri (memoria Ram)
	ERRORLEVEL      -302                 ;permette di escludere alcuni errori di compilazione, la  segnalazione  302  ricorda  di 
	                                     ;commutare il banco di memoria qualora si utilizzino registri che non stanno nel banco 0
	__CONFIG        _XT_OSC & _CP_OFF & _WDT_OFF &_PWRTE_ON ; Configurazioni

;=============================================================
;                           DEFINE
;=============================================================
;Definizione comandi
;#define  Bank1bsf      STATUS,RP0            ;Attiva banco 1
;#define  Bank0         bcf STATUS,RP0        ;Attiva banco 0
;=============================================================
;                    Area SIMBOLI e DATI
;=============================================================
;LABEL       CODE      OPERANDO         COMMENTO
;=============================================================
delay1   EQU       0x0C
delay2   EQU       0x0D
delay0   EQU       0x0E
LED_ON       EQU       B'00000001'
LED_OFF      EQU       B'00000000'

;=============================================================
;                  PROGRAMMA PRINCIPALE
;=============================================================
;   LABELCODE         OPERANDO      COMMENTO
;=============================================================
;Reset Vector
;Start point at CPU reset

	ORG               0x0000        ;indirizzo di inizio programma, origine
	goto              Main







;=============================================================
;                       INTERRUPT AREA
;=============================================================
	ORG               0x0004       ;indirizzo inizio routine interrupt
	retfie                         ;ritorno programma principale





;=============================================================
;                  AREA PROGRAMMA PRINCIPALE
;=============================================================

Main

        bsf       STATUS,RP0      ; Metto a 1 il bit RP0, attivo il banco 1
        movlw     0
        movlw     TRISA
        movlw     TRISB           ; Metto tutte le porte del Banco0 e Banco1 come output
        bcf       STATUS,RP0      ; Metto 0 il bit RP0, attivo il banco 0
InizioLampeggio
        movlw     LED_ON
        movwf     PORTB           ; Porto il valore di LED_ON sulla Porta B

Sinistra	rlf       PORTB ;trasla il bit di portB nella posizione 2 poi 3 e cosi via VERSO SINISTRA
		call      RitardoMezzoSec
        btfss     PORTB, 7
        goto      Sinistra
Destra   rrf       PORTB ;trasla il bit di portB nella posizione 2 poi 3 e cosi via VERSO DESTRA
        btfss     PORTB, 0
		call      RitardoMezzoSec
        goto      Destra
	
        goto      InizioLampeggio    ; Porto il valore di LED_OFF sulla Porta B




;=======AreaRoutine=============
RitardoMezzoSec ;fa un ritardo di mezzo sec sulla pic
		
		clrf	delay0
		movlw   130					; sposta in W il valore 130
		movwf	delay1				; iniziallizo delay1 con il valore dentro W
		movlw   5					; sposta in W il valore 5
		movwf   delay2 
loop1	decfsz	delay0				  ; decremento delay0 fino a 0 
		goto	loop1				; quanto delay0 = 0 esco dal loop
		decfsz 	delay1				; decremento delay1 fino a 0 
		goto	loop1				; quanto delay1 = 0 esco dal loop
		movlw 	130					; sposta in W il valore 130
		movwf	delay1				 ;iniziallizo delay1 con il valore dentro W
		decfsz 	delay2				; decremento delay2 fino a 0 
		goto 	loop1
		return	
		


		
        END                       ;Fine programma