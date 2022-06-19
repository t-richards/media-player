;
; File: media-player.asm
; Remarks: This is a "media player" application.
;
; Assemble with:
; ml64 media-player.asm /link /subsystem:windows /defaultlib:kernel32.lib /entry:WinMain
;

option	casemap:none

EXTERN	SetThreadExecutionState:	PROC
EXTERN	Sleep:				PROC

; winbase.h
ES_CONTINUOUS		equ	080000000h
ES_SYSTEM_REQUIRED	equ	000000001h
ES_DISPLAY_REQUIRED	equ	000000002h
INFINITE		equ	0FFFFFFFFh

.CODE

WinMain	PROC
; for (;;) {
RunForever:
	; SetThreadExecutionState(ES_CONTINUOUS | ES_DISPLAY_REQUIRED | ES_SYSTEM_REQUIRED );
	mov	rcx,	ES_CONTINUOUS OR ES_DISPLAY_REQUIRED OR ES_SYSTEM_REQUIRED
	call	SetThreadExecutionState

	; Sleep(INFINITE);
	mov	rcx,	INFINITE
	call	Sleep

	; }
	jmp	RunForever
WinMain ENDP

END
