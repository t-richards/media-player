;
; File: media-player-arm64.asm
; Remarks: This is a "media player" application.
;
; Assemble with:
; armasm64 media-player-arm64.asm
; link media-player-arm64.obj /subsystem:windows /defaultlib:kernel32.lib /entry:WinMain /machine:arm64
;

    AREA    |.text|, CODE, READONLY

    IMPORT  SetThreadExecutionState
    IMPORT  Sleep

; winbase.h
ES_CONTINUOUS       EQU 0x80000000
ES_SYSTEM_REQUIRED  EQU 0x00000001
ES_DISPLAY_REQUIRED EQU 0x00000002
INFINITE            EQU 0xFFFFFFFF

EXEC_STATE          EQU ES_CONTINUOUS :OR: ES_DISPLAY_REQUIRED :OR: ES_SYSTEM_REQUIRED

    EXPORT  WinMain
WinMain PROC
; for (;;) {
RunForever
    ; SetThreadExecutionState(ES_CONTINUOUS | ES_DISPLAY_REQUIRED | ES_SYSTEM_REQUIRED);
    ; ARM64 can't load a full 32-bit immediate in one instruction, so split
    ; EXEC_STATE into its low and high 16-bit halves.
    movz    w0, #(EXEC_STATE :AND: 0xFFFF)
    movk    w0, #(EXEC_STATE :SHR: 16), lsl #16
    bl      SetThreadExecutionState

    ; Sleep(INFINITE);
    mov     w0, #INFINITE
    bl      Sleep

    ; }
    b       RunForever
    ENDP

    END
