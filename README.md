## Huion-Switch-Screen
AHK script for toggling pen mapping between multiple monitors.

This script is designed for buttonless Huion pen tablets, such as the Kamvas 22 Plus, and introduces the functionality to switch pen mapping using a hotkey on your keyboard.
The Huion driver lacks this crucial functionality. 🤦‍♂️

The script functions akin to a game hack by injecting an integer value directly into the memory of a running process, specifically HuionTabletCore.exe.
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
