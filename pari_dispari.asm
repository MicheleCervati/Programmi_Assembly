;**************************************************
;*** Struttura base programma con la PIC 16F84A ***
;***                                            ***
;    [Programma assoluto]
;
; (c) 2022, Michele Cervati
;
;**************************************************
        PROCESSOR       16F84A	     ;definizione del tipo di Pic per il quale è stato scritto il programma
        RADIX           DEC	         ;i numeri scritti senza notazione sono da intendersi come decimali
        INCLUDE         "P16F84A.INC" ;inclusione del file che contiene la definizione delle costanti di riferimento al file dei
        							 ;registri (memoria Ram)
        ERRORLEVEL      -302		 ;permette di escludere alcuni errori di compilazione, la  segnalazione  302  ricorda  di 
                                     ;commutare il banco di memoria qualora si utilizzino registri che non stanno nel banco 0


        ;Setup of PIC configuration flags
        ;XT oscillator
        ;Disable watch dog timer
        ;Enable power up timer
        ;Disable code protect
;        __CONFIG        0x3FF1	      ; definizione del file di configurazione
		__CONFIG   _XT_OSC & _CP_OFF & _WDT_OFF &_PWRTE_ON

;=============================================================
;       DEFINE
;=============================================================
;Definizione comandi
;#define  Bank1	bsf     STATUS,RP0			  ; Attiva banco 1
;#define  Bank0 bcf     STATUS,RP0	          ; Attiva banco 0
;=============================================================
; 		SIMBOLI
;=============================================================
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================
;LED_ON  EQU     01					  ; Led acceso
;LED_OFF EQU	    00					  ; Led spento
;=============================================================
;       AREA DATI
;=============================================================	
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================
Reg1 EQU     0x0C					  
Reg2 EQU     0x0D
Reg3 EQU     0x0E
temp EQU	 0x0F
					
;=============================================================
;       PROGRAMMA PRINCIPALE
;=============================================================
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================        ;Reset Vector
        ;Start point at CPU reset
        ORG     0x0000				  ;	indirizzo di inizio programma
		goto	Main
;=============================================================
;       INTERRUPT AREA
;=============================================================
		ORG     0x0004				  ;	indirizzo inizio routine interrupt
;
;
		retfie						  ; ritorno programma principale
;=============================================================
;       AREA PROGRAMMA PRINCIPALE
;=============================================================
		Main
;Codice Programma
;        Bank1  ; accedo al banco zero del file register per settare I/O porta A e B
        bsf     STATUS,RP0  ; attiva banco 1


;Esercizio 1: Determinare se un valore inserito nel registro 0CH è pari o dispari, come visto in aula considerate il valore dell'ultimo bit per capire se il numero è pari o dispari.
;se Reg1 è un numero pari (ultima cifra 0) allora Reg2 è 0 altrimenti viene incrementato di 1


		MOVLW 0000
		MOVWF Reg2

		MOVLW 0000
		MOVWF Reg1

		BTFSC Reg1, 000
		INCF  Reg2

;=============================================================
;       AREA ROUTINE
;=============================================================
;										
        END                           ; Fine programma


 