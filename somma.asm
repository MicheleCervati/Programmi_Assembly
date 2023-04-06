;**************************************************
;*** Struttura base programma con la PIC 16F84A ***
;***                                            ***
;    [Programma assoluto]
;
; (c) 2022, Cervati Michele
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
Val1  EQU     B'00000010'					  ; definisco il primo valore
Val2  EQU	  B'10000000'					  ; definisco il secondo valore 
;=============================================================
;       AREA DATI
;=============================================================	
;LABEL	CODE 	OPERANDO	COMMENTO
;=============================================================
Reg1 EQU     0x0C	 ; definisco i registri associando loro una etichetta				  
Reg2 EQU     0x0D
Reg3 EQU     0x0E
temp EQU     0x0F
					
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
		clrf Reg1; cancello contenuto di Reg1
		clrf Reg2; cancello contenuto di Reg2
		clrf Reg3; cancello contenuto di Reg3
		clrf temp; cancello contenuto di temp
		movlw Val1; sposto Val1 in w
		movwf Reg1; sposto contenuto di w in Reg1
		movlw Val2; sposto Val2 in w
		movwf Reg2; sposto contenuto di w in Reg2
		addwf Reg1;sommo i due valori e memorizzo il risultato in Reg1
		btfsc STATUS,010; valuto il bit 2 del registro status, se questo bit è 1 incremento Reg3 
		incf  Reg3

;=============================================================
;       AREA ROUTINE
;=============================================================
;
        END                           ; Fine programma


 


 