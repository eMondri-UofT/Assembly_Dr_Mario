Recreation of the video game Dr Mario with some extra features. Created and runnable using Saturn for MIPS assembly: https://github.com/1whatleytay/saturn/

In order to play the game once opened in Saturn, you need to go to the "Bitmap" tab and adjust the values to match the header of the file: 256x256 display widthxheight.
The address should be correct by default, at 0x10008000.

Select a difficulty using "e", "m", and "h", for easy medium and hard, respectively. Then hit s to start, and play Dr Mario!
Use 'a' and 'd' to move the capsule left and right, 's' to move it down, and 'w' to rotate it.
Complete a line of 4 of the same color in a row to clear that line and make the rest of the blocks attached to them fall. Survive for as long as possible and try to set a high score.

You lose when you can't place another block (the bottle is filled up).
On Game Over, press 'r' to return to the menu screen.

At any time in-game, you can press 'p' to pause.

Gravity will speed up the more blocks you clear. The only blocks able to float are "viruses", with a custom sprite different from that of the capsules. They can be cleared the same as any other block.
