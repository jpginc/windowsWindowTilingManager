# Windows window tiling manager

I use xmonad or i3 on my linux machines. I'm not sure if windows is as usable with the tiling window style...so not sure if i will put much more effort into getting the script fully functional or not. I thought i would post it here and see if anyone else wants this kind of functionality in windows. if other people want it too then I might keep developing it. 

If you clone the github project and run main.ahk all the open windows should tile automatically. the following hotkeys are setup:

* windows key + g: re-tile the windows (do this if tiling gets messed up)
* windows key + t: stop/start tiling the active window 
* windows key + j: move the middle split left
* windows key + k: move the middle split right
* windows key + shift + j: rotate the windows' position around left
* windows key + shift + k: rotate the windows' position around right

some features that would need to be implemented to make the tiling usable:
* handle multiple monitors
* handle multiple desktops (windows 10)
* have a way to tell the program to ignore windows by class name/exe name etc
* add features like automatically move windows of a certain type to a specific desktop (windows 10)
