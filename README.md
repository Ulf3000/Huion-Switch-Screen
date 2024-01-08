# Huion-Switch-Screen
ahk script hack to toggle the pen mapping through the different monitors.

I used cheat engine to find the pointers and offsets to set which monitor the pen maps to.
This ahk script writes to the huion drivers memory and provides "Switch Screen" to Huion Models like my Kamvas 22 Plus , which dont have any buttons.
(Huions driver is missing that feature)

Since this is a AHK script you can easily change it for yourself and use different hotkeys or make one hotkey for each monitor or whatever you like :) 


THE MEMORY ADRESS POINTERS and OFFSETS are for the driver version 15.4.1.354  .. its probably wont work on other driver versions, but its easy to find the pointers and offsets with cheat engine 

EDIT (08.01.2022):

-  updated to driver version 15.5.1.390 

EDIT (05.06.2022):

-  driver version 15.5.3.444 works with the same offsets from 15.5.1.390 , no update needed :)

EDIT (28.07.2022):

-  driver version 15.6.2.80 , new memory pointer is : 0x0003BB38 + mem.BaseAddress, "UInt", 0x194, 0x18


EDIT (08.01.2024)

- i cannot use this trick on any newer driver versions anymore (at least the ones i can download now),
so 15.6.2.80 will be the last update , but the driver didnt get any meaningful updates anyways so its ok to use the older version.

I will upload that driver version installer to this repo becasue its not available on the huion website anymore.
Sorry guys nothing i can do about it 🤷‍♂️🤷‍♂️🤷‍♂️
