; this script enables switch screen function mapped to a keybaord shortcut (for huion driver v15.x.x)


; ----------------------------- base script setup and imports ---------------------------------------------------------------------
#SingleInstance Force
#Include, ClassMemory.ahk ; ClassMemory Library  https://github.com/Kalamity/classMemory this file must be in the same folder as this script
SetWorkingDir %A_ScriptDir%

; run the script as admin, otherwise it will fail when hovering over elevated windows
; you can autostart programs on windows startup as admin with the tool called SkipUAC https://www.sordum.org/16219/skip-uac-prompt-v1-2/, HIGHLY RECOMMENDED!

if not A_IsAdmin 
	Run *RunAs "%A_ScriptFullPath%" ;

; If HuionTabletCore.exe is not found, retry after 2 seconds. In case the script starts before HuionTabletCore.exe is running,
Loop
    {
        Process, Exist, HuionTabletCore.exe ; lets set our exe here , my huion tablet uses this exe as main
        pid := ErrorLevel ; get pid of process related to the exe 
        if pid ; if pid2 is found, break the loop
            break
        Sleep, 2000 ; wait 2 seconds before retrying
    }

; -----------------------------setup a new Classmemory for huiontabletcore.exe-----------------------------------------------------------------------
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


; these offsets were found with "cheat engine" https://www.cheatengine.org/ , they are specific to the driver version and need to be updated for each new driver version.

; driver history: 

; driver version 15.5.1.390     [0x0003AB38 + mem.BaseAddress, "UInt", 0x178]
; driver version 15.6.2.80      [0x0003BB38 + mem.BaseAddress, "UInt", 0x194, 0x18] 
; driver version 5.7.6.1314     [0x0003FD58 + mem.BaseAddress, "UInt", 0x198, 0x18]

monitorMappingPointer := [0x0003FD58 + mem.BaseAddress, "UInt", 0x198, 0x18] 

; ------------------------------------  --------------------------------------------------------------------------------

SetCapsLockState, alwaysoff  ; im using capslock as hotkey , so lets disable this annoying button

CapsLock::  ; the hotkey ;) this whole codeblock is run when you press capslock

    SysGet, monitorsCount, MonitorCount  ; get the number of monitors connected to the pc via SysGet
    actualMonitorMapping := mem.read(monitorMappingPointer*) ;  monitor the huion driver maps to (saved as int) 
    
    ; show the monitor number in a tooltip, important for debugging a new driver! because the internal mapping might be differnet from what you expect and change with new driver version!
    ;ToolTip %actualMonitorMapping% 

    ; ------------        this is the toggle function, it toggles 0,1,2 for monitor 1,2 and 3 (and so on ) ------------------------------

    if (actualMonitorMapping + 1 == monitorsCount ){ ; if the last monitor is active switch to first one again        
        mem.write(0x0003FD58 + mem.BaseAddress, 0, "UInt", 0x198, 0x18) ; monitor 1 
    }
    else{
        newMapping := actualMonitorMapping + 1
        mem.write(0x0003FD58 + mem.BaseAddress, newMapping, "UInt", 0x198, 0x18) ; monitor + 1
    }

    Gui, Show
    Gui, Destroy ; TODO: dummy Gui, ugly hack to update the process , dont know anything better for now, but it works alright