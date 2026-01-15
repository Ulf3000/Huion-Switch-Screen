## Huion-Switch-Screen
AutoHotkey script for toggling pen mapping between multiple monitors.

This script implements the pen mapping function, activated by a keyboard hotkey.
<img width="941" height="648" alt="grafik" src="https://github.com/user-attachments/assets/e30f89d9-7684-45d5-a937-b6934e177331" />


This script adds hotkey functionality for switching pen mappings on buttonless Huion pen tablets, like the Kamvas 22 Plus. This feature is currently missing from the official Huion driver. 🤦‍♂️

The script functions like a game hack by injecting an integer value directly into the memory of a running process, specifically HuionTabletCore.exe.
I used cheat engine https://www.cheatengine.org/ to find the memorypointers and offsets to set that value.

Since this is an AutoHotkey script, you can easily change it yourself and use a different hotkey or make one hotkey for each monitor, or whatever you like :)

##### Installation:

- download and install autohotkey v1
- download both huionhack.ahk and classmemory.ahk and put them in the same folder, then run huionhack.ahk
- OR
- download the precompiled exe from the release section and use that instead (it precompiled with capslock as hotkey)

- I recommend running the script with administrator privileges.
- If you want to autostart eleveated apps at windows startup without prompting, i highly recommend to use the tool "skip UAC Prompt" https://www.sordum.org/16219/skip-uac-prompt-v1-2/


##### Update History: 

EDIT (08.01.2022):

-  updated to driver version 15.5.1.390 

EDIT (05.06.2022):

-  driver version 15.5.3.444 works with the same offsets from 15.5.1.390 , no update needed :)

EDIT (28.07.2022):

-  driver version 15.6.2.80 , new memory pointer is : 0x0003BB38 + mem.BaseAddress, "UInt", 0x194, 0x18

EDIT (02.03.2025)

-  driver version 5.7.6.1314 , new memory pointer is : 0x0003FD58 + mem.BaseAddress, "UInt", 0x198, 0x18

EDIT (15.01.2026)

-  driver version 15.7.6.1858 works with the same offsets from 5.7.6.1314 , no update needed :)
