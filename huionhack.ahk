; this script enables switch screen function mapped to a keybaord shortcut (for huion driver v15)


; ----------------------------- base script setup and imports ---------------------------------------------------------------------
#SingleInstance Force

#Include, ClassMemory.ahk ; ClassMemory Library  https://github.com/Kalamity/classMemory

SetWorkingDir %A_ScriptDir%

; run the script as admin, otherwise itll fail when hovering over elevated windows 
if not A_IsAdmin 
	Run *RunAs "%A_ScriptFullPath%" ;

if (_ClassMemory.__Class != "_ClassMemory") ; check that classmemory is imported 
    msgbox class memory not correctly installed. Or the (global class) variable "_ClassMemory" has been overwritten

; -----------------------------setup a new Classmemory for huiontabletcore.exe-----------------------------------------------------------------------

Process, Exist, HuionTabletCore.exe ; lets set our exe here , my huion tablet uses this exe as main
pid := ErrorLevel ; get pid of process related to the exe 
if !pid 
{
    msgbox pid not found 
    ExitApp
}

mem := new _ClassMemory("ahk_pid " pid, "", hProcessCopy)  ; create new ClassMemory class instance with pid as input
if !isObject(mem) ; Check if the above method was successful.
{
    msgbox failed to open a handle
    if (hProcessCopy = 0)
        msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter. 
    else if (hProcessCopy = "")
        msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
    ExitApp
}

; -------------             ----------------setup a new Classmemory for huiontablet.exe-----------------------------------------------------------------------

Process, Exist, HuionTablet.exe ; lets set our exe here , my huion tablet uses this exe as main
pid2 := ErrorLevel ; get pid of process related to the exe 
if !pid2 
{
    msgbox pid2 not found 
    ExitApp
}

; mem2 := new _ClassMemory("ahk_pid " pid, "", hProcessCopy)  ; create new ClassMemory class instance with pid as input
; if !isObject(mem2) ; Check if the above method was successful.
; {
;     msgbox failed to open a handle
;     if (hProcessCopy = 0)
;         msgbox The program isn't running (not found) or you passed an incorrect program identifier parameter. 
;     else if (hProcessCopy = "")
;         msgbox OpenProcess failed. If the target process has admin rights, then the script also needs to be ran as admin. Consult A_LastError for more information.
;     ExitApp
; }

; these offsets were found with "cheat engine" , they are specific to the driver version and need eventually be updated when a newer huion driver releases

monitorMappingPointer := [0x0003BB38 + mem.BaseAddress, "UInt", 0x194, 0x18] 

; ------------------------------------  --------------------------------------------------------------------------------

SetCapsLockState, alwaysoff  ; im using capslock as hotkey , so lets disable this annoying button

CapsLock::  ; the hotkey ;)

    SysGet, monitorsCount, MonitorCount  ; get the number of monitors connected to the pc 
    actualMonitorMapping := mem.read(monitorMappingPointer*) ;  monitor the huion driver maps to (saved as int ) 
    ;ToolTip %actualMonitorMapping%

    newMonitorMapping = 0

    ; ------------        this is the toggle function, it toggles 0,1,2 for monitor 1,2 and 3 (and so on ) ------------------------------

    if (actualMonitorMapping + 1 == monitorsCount ){ ; if last monitor switch to first one 

       
        mem.write(0x0003BB38 + mem.BaseAddress, 0, "UInt", 0x194, 0x18) ; monitor 1 
        newMonitorMapping = 0
    }
    else{
        newMapping := actualMonitorMapping + 1
        mem.write(0x0003BB38 + mem.BaseAddress, newMapping, "UInt", 0x194, 0x18) ; monitor + 1
        newMonitorMapping := actualMonitorMapping + 1
    }


    ; ;------------------ set the mapping size for non screentablet monitors smaller , so that its easier to control on a big pendisplay like 20"+

    ; if (newMonitorMapping == 0 or newMonitorMapping == 1){ ; monitor 1 and 2 are my normal monitors 

    ;     ToolTip ULF
    ;     mem2.write(0x00116B30 + mem.BaseAddress, 0.25, "Float", 0x138, 0x20, 0104) ; shrink input
    ; }
    ; else{
    ;     mem2.write(0x00116B30 + mem.BaseAddress, 0, "Float", 0x138, 0x20, 0104) ; full input area
    ; }

    Gui, Show
    Gui, Destroy ; TODO: dummy Gui, ugly hack to update the process , dont know anything better for now, but it works alright
