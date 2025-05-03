################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Caleb Ji, 1008770885
# Student 2: Ethan Mondri, 1010000909
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    256
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
SCREEN:
    .space 262144 # 256 x 256 x 4
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000
# The address of the "game screen". (8x16)
##### Note about marking: 2 means "attached to the right", 3 means "attached to above", 4 means "attached to the left", 5 means "attached to below"
##### 1 means virus, 0 means empty
GAME_MAP:
	.word 0x10048000
# The address of the color (game screen-wise)
COLOR_BOARD:
	.word 0x10048400
# The address of the game screen to change board 
CHANGE_BOARD:
    .word 0x10048800
letter_A:
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
letter_D:
    .word 0xfb # 1111 1100
    .word 0x82 # 1000 0010
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x82 # 1000 0010
    .word 0xfc # 1111 1100
letter_E:
    .word 0xff # 1111 1111
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
    .word 0xff # 1111 1111
    .word 0xff # 1111 1111
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
    .word 0xff # 1111 1111
letter_G:
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
    .word 0x80 # 1000 0000
    .word 0x83 # 1000 0011
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
letter_H:
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
letter_I:
    .word 0x7e # 0111 1110
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x7e # 0111 1110
letter_M:
    # there's 2 versions here, one (the first) with double lines on the diagonal. Neither really look good.
    .word 0x81 # 1000 0001
    .word 0xc3 # 1100 0011
    .word 0xe7 # 1110 0111
    .word 0xbd # 1011 1101
    .word 0x99 # 1001 1001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    # .word 0x81 # 1000 0001
    # .word 0xc3 # 1100 0011
    # .word 0xa5 # 1010 0101
    # .word 0x99 # 1001 1001
    # .word 0x81 # 1000 0001
    # .word 0x81 # 1000 0001
    # .word 0x81 # 1000 0001
    # .word 0x81 # 1000 0001
letter_N:
    .word 0x81 # 1000 0001
    .word 0xc1 # 1100 0001
    .word 0xa1 # 1010 0001
    .word 0x91 # 1001 0001
    .word 0x89 # 1000 1001
    .word 0x85 # 1000 0101
    .word 0x83 # 1000 0011
    .word 0x81 # 1000 0001
letter_O:
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
letter_P:
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
letter_R:
    .word 0xff # 1111 1111
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
    .word 0xe0 # 1110 0000
    .word 0xb0 # 1011 0000
    .word 0x98 # 1001 1000
    .word 0x8c # 1000 1100
letter_S:
    .word 0xff # 1111 1111
    .word 0x80 # 1000 0000
    .word 0x80 # 1000 0000
    .word 0xff # 1111 1111
    .word 0xff # 1111 1111
    .word 0x01 # 0000 0001
    .word 0x01 # 0000 0001
    .word 0xff # 1111 1111
letter_T:
    .word 0xff # 1111 1111
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
letter_U:
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0xff # 1111 1111
letter_V:
    .word 0x81 # 1000 0001
    .word 0x81 # 1000 0001
    .word 0x42 # 0100 0010
    .word 0x42 # 0100 0010
    .word 0x24 # 0010 0100
    .word 0x24 # 0010 0100
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
letter_Y:
    .word 0x81 # 1000 0001
    .word 0x42 # 0100 0010
    .word 0x24 # 0010 0100
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000
    .word 0x18 # 0001 1000

##############################################################################
# Mutable Data
##############################################################################
# The rotation of the capsule.
ROTATION:
    .word 0
# The X and Y positions of the capsule.
X_POSITION:
    .word 3
Y_POSITION:
    .word 0
# The colors
LEFT_COLOR:
    .word 0xff0000
RIGHT_COLOR:
    .word 0xffff00
SCORE:
    .word 0
PREV_SCORE:
    .word 0
HIGH_SCORE:
    .word 0
DIFFICULTY:
    .word 1
GRAVITY_REQ:
    .word 60
##############################################################################
# Code
##############################################################################
	.text
	.globl main

    # Run the game.
main:
    # Initialize the game
    lw $s0, ADDR_DSPL               # load the address of the display to s0
    lw $s1, ADDR_KBRD               # load the address of the keyboard to s1
	lw $s2, GAME_MAP                # load the address of the game map to s2
	lw $s3, COLOR_BOARD             # load the address of the color board to s3
    li $s7, 0                       # Prepare an accumulator for the capsule's gravity

    j main_menu                     # go to main menu

startup:  
    jal draw_background             # Jump and link to draw bakcground
    jal random_colors               # Jump and link to randomly generate colors
	li $a0, 5                       # this is the base number of viruses to generate
    lw $t2, DIFFICULTY              # load in difficulty
    # Change gravity speed based on difficulty
    beq $t2, 1, set_game_speed_easy
    beq $t2, 2, set_game_speed_medium
    beq $t2, 3, set_game_speed_hard
set_game_speed_easy:
    li $t3, 70 
    j continue_startup
set_game_speed_medium:
    li $t3, 60 
    j continue_startup
set_game_speed_hard:
    li $t3, 50 
    j continue_startup
continue_startup:
    sw $t3, GRAVITY_REQ
    mul $a0, $a0, $t2               # multiply number of viruses by difficulty
	jal generate_viruses
    jal draw_board
  	jal find_lines
    jal draw_score
    j game_loop                     # go to game loop

game_loop:
    # 1a. Check if key has been pressed
    lw $t2, 0($s1)                  # load the first word from the keyboard
    beq $t2, 1, keyboard_input      # If first word 1, key is pressed
game_loop_after_keyboard:
    # 1b. Check which key has been pressed [in keyboard_input]
    
    # 2a. Check for collisions [ this also happens during keyboard input - to properly reject it if a collision actually happens]
    # here (2a) will be completing lines, separate from the collision
    
	# 2b. Update locations (capsules)
    
    # 3. Draw the screen
    # Erase old screen
    # jal erase_screen
    
    jal draw_capsule_main                # Jump and link to draw the current position of the capsule

	# 4. Sleep
    li $v0, 32                      # Sleep function
    li $a0, 16                      # 16 Millisecond sleep (60 fps)
    syscall

    # increment capsule gravity's accumulator, and perform the gravity if it's reached the point defined in memory
    lw $t2, GRAVITY_REQ             # load in the requirement
    beq $t2, $s7, capsule_gravity   # branch if reached the requirement
    addi $s7, $s7, 1                # increment accumulator

    # 5. Go back to Step 1
    j game_loop

update_loop:
    jal erase_screen
    jal draw_board
    # Find lines
    jal find_lines
    # Score lines
    jal score_lines
    jal update_score_number
    # Sleep
    li $v0, 32                      # Sleep function
    li $a0, 300                     # 300 Millisecond sleep 0.3 seconds
    syscall
    # Remove lines
    jal remove_lines
    jal erase_screen
    jal draw_board
    # Sleep
    # Gravity loop
    jal unlinked_gravity
    # clear keyboard 
    jal clear_keyboard
    # Update gravity speed
    jal update_gravity_req
    # new pill and go back to game loop
    j new_capsule 

capsule_gravity:
    # do the same as in respond_to_S, except the final jump
    lw $t0, X_POSITION              # Load X value into register
    lw $t1, Y_POSITION              # Load Y value into register
    jal check_collision_down        # jump to check collision. If it comes back, there was not a collision (draws a new capsule if there was a collision)
    jal erase_capsule_main          # Erase the capsule at the current position
    addi $t1, $t1, 1                # add 1 to y
    sw $t1, Y_POSITION              # save new y to memory
    
    li $s7, 0                       # reset accumulator
    j game_loop                     # go back to step 1

update_gravity_req:
    lw $t0, PREV_SCORE              # Load previous score into the register
    lw $t1, SCORE                   # Load current score
    sub $t0, $t1, $t0               # Difference of score
    bgt $t1, 10, update_gravity_scored  # If more than ten score has been scored update gravity
    j update_gravity_end
update_gravity_scored:
    li $t2, 10
    div $t1, $t2                    # Divide score by 10 so that we get how much to change gravity by
    mflo $t2
    lw $t3, GRAVITY_REQ             # Load current gravity requirement
    beq $t3, 5, update_gravity_end # If gravity is equal to minimum, exit
    sub $t3, $t3, $t2               # Subtract gravity by a tenth of the score change 
    lw $t1, PREV_SCORE              # Load new score as previous score
    bgt $t3, 5, update_gravity_good # Don't update gravity beyond a minimum
    li $t3, 5
    sw $t3, GRAVITY_REQ             # Set gravity to minimum
    j update_gravity_end
update_gravity_good:
    sw $t3, GRAVITY_REQ             # Save new gravity requirement
update_gravity_end:
    li $s7, 0                       # reset accumulator
    jr $ra


random_colors:
    add $s4, $zero, $ra             # Save the return address

    jal generate_color              # Jump to randomization
    sw $t2, LEFT_COLOR              # Save color to left pixel

    jal generate_color              # Jump to randomization
    sw $t2, RIGHT_COLOR             # Save color to right pixel

    jr $s4                          # Jump back to the saved return address

generate_color:
    # Generate a random number between 0 and 2
    li $a0, 0                       # Use the default generator id
    li $a1, 3                       # Set upper bound (exclusive)
    li $v0, 42                      # Generate random int in range
    syscall

    # Turn number into color
    beq $a0, 0, red
    beq $a0, 1, yellow
    j blue

red:
    li $t2, 0xff0000                # Load red to t2
    jr $ra                          # jump back to the return address

yellow:
    li $t2, 0xffff00                # Load yellow to t2
    jr $ra                          # jump back to the return address

blue:
    li $t2, 0x0000ff                # Load blue to t2
    jr $ra                          # jump back to the return address

# $a0 is the number of viruses to generate
generate_viruses:
    addi $sp, $sp, -4         # Make space on stack
    sw $ra, 0($sp)            # Save return address
    move $t0, $a0
generate_viruses_loop:
    beq $t0, 0, generate_viruses_continue   # Exit once done generating viruses
    # Generate a random number between 0 and 79 (max virus level at row 10)
    li $a0, 0                       # Use the default generator id
    li $a1, 79                       # Set upper bound (exclusive)
    li $v0, 42                      # Generate random int in range
    syscall
    li $t4, 1                       # value for virus
    multu $t2, $a0, 4               # 4 spaces per memory address
    addu $t1, $s2, 192               # 48 offset bc these rows cannot have viruses
    addu $t1, $t1, $t2               # Adding the randomly generated position
    multu $t2, $a0, 4               # Doing the same for the color map
    addu $t5, $s3, 192               
    addu $t5, $t5, $t2
    lw $t3, 0($t1)                  # get the value in the game map
    bne $t3, 0, generate_viruses_loop
    sw $t4, 0($t1)
    jal generate_color
    sw $t2, 0($t5)
    subu $t0, $t0, 1
    j generate_viruses_loop
generate_viruses_continue:
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller

new_capsule:
    lw $t2, Y_POSITION              # temp load y for comparison
    beqz $t2, game_over             # If the previous y was 0, go to game over, since that means you've reached the top.
    # Note: this does not also check x, meaning that technically if you place a horizontal block on the top row at the side, it will still exit.
  
	li $t2, 3                       # temp load 3
	sw $t2, X_POSITION              # reset x to 3
	sw $zero, Y_POSITION            # reset y to 0
	sw $zero, ROTATION				# reset rotation to 0

	jal random_colors               # Jump and link to randomly generate colors

	j game_loop                     # go back to game loop
	

##############################################################################
# Keyboard functions
##############################################################################
clear_keyboard:
    lw $t2, 0($s1)                  # load the first word from the keyboard
    beq $t2, 0, clear_keyboard_exit # If first word 0, no key pressed, exit
    lw $a0, 4($s1)                  # Load second word from keyboard to clear it
    j clear_keyboard
clear_keyboard_exit:
    jr $ra

keyboard_input:
    lw $a0, 4($s1)                  # Load second word from keyboard

    lw $t0, X_POSITION              # Load X value into register
    lw $t1, Y_POSITION              # Load Y value into register
    
    beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed
    beq $a0, 0x61, respond_to_A     # Check if the key a was pressed
    beq $a0, 0x73, respond_to_S     # Check if the key s was pressed
    beq $a0, 0x64, respond_to_D     # Check if the key d was pressed
    beq $a0, 0x77, respond_to_W     # Check if the key w was pressed
    beq $a0, 0x70, pause_screen      # Check if the key p was pressed

    j game_loop_after_keyboard                     # go back to game loop

respond_to_Q:
    li $v0, 10                      # quit gracefully
    syscall

respond_to_A:
	# No longer checking the left bound here, since that happens in collision
    jal check_collision_left        # jump to check collision. If it comes back, there was not a collision
    
    jal erase_capsule_main          # Erase the capsule at the current position

    sra $t0, $t0, 2                 # revert x to actual value (in calculating position for collision, x gets shifted left 2)
    subi $t0, $t0, 1                # subtract 1 from x
    sw $t0, X_POSITION              # save new x to memory

    j game_loop_after_keyboard                     # jump back to the game loop

respond_to_S:
    # No longer checking the bottom bound here, since that happens in collision  
	jal check_collision_down        # jump to check collision. If it comes back, there was not a collision (draws a new capsule if there was a collision)
    
    jal erase_capsule_main          # Erase the capsule at the current position
    
    addi $t1, $t1, 1                # add 1 to y
    sw $t1, Y_POSITION              # save new y to memory

    j game_loop_after_keyboard                     # jump back to the game loop
    
respond_to_D:
    # Perform correct collision checking depending on rotation of the capsule
    lw $t2, ROTATION                # load in rotation
    beq $t2, 1, D_vertical
    beq $t2, 3, D_vertical

    jal check_collision_right_h     # jump to check collision. If it comes back, there was not a collision

    jal erase_capsule_main          # erase the capsule at the current calculate_position

    sra $t0, $t0, 2                 # revert x to actual value (in calculating position for collision, x gets shifted left 2)
    addi $t0, $t0, 1                # add 1 to x
    sw $t0, X_POSITION              # save new x to memory

    j game_loop_after_keyboard                     # keyboard input finished

D_vertical:                         # this function does the exact same as the above except with check_collision_right_v instead of ..._h
    jal check_collision_right_v     # jump to check collision. If it comes back, there was not a collision

    jal erase_capsule_main          # erase the capsule at the current calculate_position

    sra $t0, $t0, 2                 # revert x to actual value (in calculating position for collision, x gets shifted left 2)
    addi $t0, $t0, 1                # add 1 to x
    sw $t0, X_POSITION              # save new x to memory

    j game_loop_after_keyboard                     # keyboard input finished

respond_to_W:
    beqz $t1, game_loop_after_keyboard

    # Calculate the game_map address for (x, y)
	li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t2, $t0, 2                 # shift x register left by 2 (multiply by 4) into t2
	add $t3, $t3, $t2               # calculate total shift
	add $t4, $t3, $s2               # calculate memory position of shift

    # If the capsule is horizontal, check that it isn't erasing a block above it
    lw $t5, ROTATION                # load in rotation
    beq $t5, 3, rotate_from_v       # skip checking if vertical
    beq $t5, 1, rotate_from_v       # skip checking if vertical
    
	lw $t9, -32( $t4 )              # load in the value one unit above the current position
    # if that value is not zero, go back to the game_loop (don't rotate)
    bnez $t9, game_loop_after_keyboard

    j rotate_continue               # continue rotation
rotate_from_v:
    lw $t9, 4( $t4 )                # load in the value one to the right of the current position
    # if that value is not zero, go back to the game_loop (don't rotate)
    bnez $t9, game_loop_after_keyboard

    # implicitly, move on to rotate_continue
rotate_continue:
    jal erase_capsule_main          # Erase the capsule at the current position
    lw $t5, ROTATION                # load in rotation
    
    addi $t5, $t5, 1                # Add 1 to rotation
    sw $t5, ROTATION                # Save new rotation value

    li $t2, 7                       # temp load 7 for comparison
    bne $t0, $t2, continue_W        # skip shifting capsule left if not vertical at edge

    subi $t0, $t0, 1                # subtract 1 from x
    sw $t0, X_POSITION              # save new x

continue_W:
	bge $t5, 4, reset_rotation      # If statement: branch to reset rotation to 0 if >= 4 (+1 happens before this line)
	
    j game_loop_after_keyboard      # jump back to the game loop

reset_rotation:    
    li $t5, 0                       # Set rotation to 0
    sw $t5, ROTATION                # Save new rotation value

    j game_loop_after_keyboard                     # jump back to the game loop

check_collision_down:
    # Calculate the game_map address for (x, y)
	li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t0, $t0, 2                 # shift x register left by 2 (multiply by 4)
	add $t3, $t3, $t0               # calculate total shift
	add $t4, $t3, $s2               # calculate memory position of shift
    
    li $t2, 15                      # temp load 15
	beq $t1, $t2, collide_down      # reached bottom, create new capsule
    
	lw $t9, 32( $t4 )               # load in the value one unit below the current position

	# note: this doesn't memory overflow because we check that it reached the bottom before this point.
	bnez $t9, collide_down          # if the item one unit below the current position is not empty, collide downwards

	lw $t8, ROTATION                # load in ROTATION
	beq $t8, 1, continue_collision  # skip checking the item to the down-right if vertical
	beq $t8, 3, continue_collision  # skip checking the item to the down-right if vertical
	
	lw $t9, 36( $t4 )               # load in the value to the right of the previously checked value
	bnez $t9, collide_down          # if the item one unit below the right of the current position is not empty, collide downwards

    j continue_collision            # Jump to continue_collision after checking both of the "below" positions

check_collision_left:
    beqz $t0, game_loop_after_keyboard             # if x is 0 (at the left wall), don't return to the keyboard input
    
    # Calculate the game_map address for (x, y)
	li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t0, $t0, 2                 # shift x register left by 2 (multiply by 4)
	add $t3, $t3, $t0               # calculate total shift
	add $t3, $t3, $s2               # calculate memory position of shift
    lw $t9, -4( $t3 )               # load in the value one unit to the left of the current position

    bnez $t9, game_loop_after_keyboard             # if the item one unit left of the main square is not empty, don't return to the keyboard input

    lw $t8, ROTATION                # load in ROTATION
    beq $t8, 0, continue_collision  # if horizontal, return to keyboard
    beq $t8, 2, continue_collision  # if horizontal, return to keyboard

    lw $t9, -36( $t3 )              # load in the value to the left of the square above (since the capsule is vertical)
    bnez $t9, game_loop_after_keyboard             # if the item one unit above to the left of the main square is not empty, don't return to the keyboard input

    j continue_collision            # if both checks failed, return to keyboard

check_collision_right_h:            # check right collision for a horizontal capsule
    li $t2, 6                       # load in the maximum x a horizontal capsule should have
    bge $t0, $t2, game_loop_after_keyboard         # if x is >= the maximum it should be, don't return to keyboard input
    
    # Calculate the game_map address for (x, y)
	li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t0, $t0, 2                 # shift x register left by 2 (multiply by 4)
	add $t3, $t3, $t0               # calculate total shift
	add $t3, $t3, $s2               # calculate memory position of shift
    lw $t9, 8( $t3 )                # load in the value two units to the right of the current position

    bnez $t9, game_loop_after_keyboard             # if the item two units to the right of the main square is not empty, don't return to the keyboard input

    j continue_collision            # if that item is empty, return to keyboard

check_collision_right_v:            # check right collision for a vertical capusle
    li $t2, 7                       # load in the maximum x a vertical capsule should have
    bge $t0, $t2, game_loop_after_keyboard         # if x is >= the maximum value it should be, don't return to keyboard input
    
    # Calculate the game_map address for (x, y)
	li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t0, $t0, 2                 # shift x register left by 2 (multiply by 4)
	add $t3, $t3, $t0               # calculate total shift
	add $t3, $t3, $s2               # calculate memory position of shift
    lw $t9, 4( $t3 )                # load in the value one unit to the right of the current position

    bnez $t9, game_loop_after_keyboard             # if the item one unit to the right of the main square is not empty, don't return to the keyboard input

    lw $t9, -28( $t3 )              # load in the value one unit above and to the right of the current position
    bnez $t9, game_loop_after_keyboard             # if the item one unit above and to the right of the main square is not empty, don't return to the keyboard input

    j continue_collision            # if both items are empty, return to keyboard

continue_collision:
	jr $ra                          # go back to the keyboard input

collide_down:
	# Mark the square with 2/3, based on rotation
    lw $t2, ROTATION                # load in rotation
    andi $t2, $t2, 1                # extract the last bit from rotation (00, 01, 10, 11) so 0 and 2 face right while 1 and 3 face up
	addi $t2, $t2, 2                # add 2 to rotation
	sw $t2, 0( $t4 )                # mark calculated memory address with 2 for right-facing pairs, and 3 for up-facing pairs
    #### OTHER BLOCK 

    # get color board memory address
    add $t6, $t3, $s3

    # also mark the other block, depending on rotation (this code should later also change what value is stored in each block)
	lw $t5, ROTATION                # load in rotation value
	beq $t5, 0, mark_horizontal_right     # mark the spot 1 to the right as well
	beq $t5, 2, mark_horizontal_left     # mark the spot 1 to the right as well
	beq $t5, 1, mark_vertical_right       # mark the spot 1 above as well
	beq $t5, 3, mark_vertical_left       # mark the spot 1 above as well

mark_horizontal_right:
    lw $t7, LEFT_COLOR              # temp load left color   
    sw $t7, 0($t6)                  # save left color on color board
    li $t2, 4                       # temp load 4
	sw $t2, 4( $t4 )                # mark the right of the calculated memory address with 4
    lw $t7, RIGHT_COLOR             # temp load right color   
    sw $t7, 4($t6)                  # save right color to the right
  	j update_loop                   # go to update loop 

mark_horizontal_left:
    lw $t7, RIGHT_COLOR             # temp load right color   
    sw $t7, 0($t6)                  # save left color on color board
    li $t2, 4                       # temp load 4
	sw $t2, 4( $t4 )                # mark the right of the calculated memory address with 4
    lw $t7, LEFT_COLOR              # temp load left color   
    sw $t7, 4($t6)                  # save right color to the right
  	j update_loop                   # go to update loop 

mark_vertical_right:
    lw $t7, LEFT_COLOR              # temp load left color   
    sw $t7, 0($t6)                  # save right color to the right
    li $t2, 5                       # temp load 5
	sw $t2, -32( $t4 )              # mark one above the calculated memory address with 5
    lw $t7, RIGHT_COLOR             # temp load right color   
    sw $t7, -32($t6)                # save left color on color board
	j update_loop                   # go to update loop 

mark_vertical_left:
    lw $t7, RIGHT_COLOR             # temp load right color   
    sw $t7, 0($t6)                  # save left color on color board
    li $t2, 5                       # temp load 5
	sw $t2, -32( $t4 )              # mark one above the calculated memory address with 5
    lw $t7, LEFT_COLOR              # temp load left color   
    sw $t7, -32($t6)                # save right color to the right
	j update_loop                   # go to update loop


############################################################################
# Calculate board
############################################################################

find_lines:
    # loop through every square in the game board
    # Check if there are four squares of the same color to the right or down
    # If so, write on the change board to note for scoring and updating the display later
    add $t0, $zero, $zero              # Offset from start of board
find_lines_loop:
    lw $t8, CHANGE_BOARD               # Load address of change board to $t8
    beq $t0, 512, find_lines_end       # Exit when offset is 512
    add $t1, $s3, $t0                  # Position in color board 
    add $t6, $t8, $t0                  # Position on the change board
    move $t2, $t1                      # Moveable pointer
    lw $t3, 0 ($t2)                    # Color of first square
    beq $t3, 0, find_lines_loop_end    # If zero color jump to end
    addu $t4, $zero, 0                 # Counter for inner loop
find_one_line_right_loop:
    beq $t4, 3, find_right_line_success # Success after finding 3 extra blocks of the same color
    addu $t4, $t4, 1                    # Next in counter
    addu $t2, $t2, 4                    # Next item
    bge $t0, 504, find_lines_loop_end    # If $t20 is greater than 504, we cannot create any more lines to the right
    multu $t9, $t4, 4
    add $t9, $t9, $t0                    # $t9 becomes the offset calculated
    li $t8, 32
    div $t9, $t8                         # If $t9 is divisible by 32, then a new row started
    mfhi $t8                             # Load the remainder into $t8
    beq $t8, 0, find_right_line_end      # Exit if the remainder is zero
    lw $t5, 0 ($t2)
    bne $t5, $t3, find_right_line_end    # If the colors are different, exit
    j find_one_line_right_loop
find_right_line_success:
    li $t5, 1
    sw $t5, 0 ($t6)
    sw $t5, 4 ($t6)
    sw $t5, 8 ($t6)
    sw $t5, 12 ($t6)
find_right_line_end:
    move $t2, $t1                      # Reset the pointer
    addu $t4, $zero, 0                 # Reset the counter
find_one_line_down_loop:
    beq $t4, 3, find_down_line_success # Success after finding 3 extra blocks of the same color
    add $t2, $t2, 32                    # Next item
    bge $t0, 416, find_lines_loop_end    # If $t0 is greater than 416, it is on the last three rows and cannot make a line
    lw $t5, 0 ($t2)
    bne $t5, $t3, find_lines_loop_end    # If the colors do not match, remove
    addu $t4, $t4 1
    j find_one_line_down_loop
find_down_line_success:
    li $t5, 1
    sw $t5, 0 ($t6)
    sw $t5, 32 ($t6)
    sw $t5, 64 ($t6)
    sw $t5, 96 ($t6)
find_lines_loop_end:
    add $t0, $t0, 4 
    j find_lines_loop
find_lines_end:
    jr $ra                             # Return to caller 

score_lines:
    lw $t0, SCORE                   # load in score
    lw $t4, DIFFICULTY              # Load in difficulty
    add $t1, $s2, $zero             # load in pointer to start of game board
    addu $t5, $t1, 512              # End value
score_lines_loop:
    beq $t1, $t5, score_lines_end   # Jump to end when pointer reaches end
    lw $t2, 2048( $t1 )             # load in the value of change board
    beq $t2, 0, score_lines_loop_continue # Continue if nothing is changed
    lw $t3, 0( $t1 )                # load in the value of change board
    add $t0, $t0, $t4               # add difficulty score for each block removed
    beq $t3, 1, score_virus
    j score_lines_loop_continue
score_virus:
    addu $t0, $t0, 1                # add extra value for virus clear
score_lines_loop_continue:
    add $t1, $t1, 4                 # continue to next pixel
    j score_lines_loop
score_lines_end:
    sw $t0, SCORE                   # Save score
    jr $ra
    


unlinked_gravity:
    # loop through every square on the board from the bottom right upwards, and call respond_to_S on the (X, Y) of that block if there is not a block below it.
    li $t0, 7                       # load in x = 7 (right side of the board)
    li $t1, 14                      # load in y = 14 (one above the bottom of the board) [ blocks at the bottom level do not need to fall any further ]
    li $t8, 0                       # reset the accumulator
gravity_position:
    li $t2, 32                      # temp load row_length*4
	mul $t3, $t1, $t2               # calculate y shift
	sll $t4, $t0, 2                 # shift x left by 2 (multiply by 4)
	add $t3, $t3, $t4               # calculate total shift
	add $t5, $t3, $s2               # calculate memory position of shift

    lw $t6, 32( $t5 )               # load in the value one row below the current (x,y) [ on the game board ]
    bnez $t6, decrement_gravity_x   # if the block below the current one is not empty, skip performing gravity on it

    lw $t6, 0( $t5 )                # load in the value at the current (x,y) [ on the game board ]
    li $t2, 1                       # temp load 1 for comparison
    ble $t6, $t2, decrement_gravity_x # If the value of the current block is "virus" or "empty" (0 or 1), skip performing gravity on it

    li $t2, 4                       # load in the value for the right block of a horizontal capsule
    beq $t6, $t2, grav_hori_right   # branch to perform gravity (maybe) on the right block of a capsule
    li $t2, 2                       # load in the value for the left blcok of a horizontal capsule
    beq $t6, $t2, grav_hori_left    # branch to perform gravity (maybe) on the left block of a capsule
    # it's unecessary to split off for vertical capsules, since we're going bottom to top.
    
    # implicitly, if none of the above branches happen, perform gravity
do_gravity:
    addi $t8, $t8, 1                # reaching this point, we are performing gravity for sure. increment accumulator
    
    # load in the current game_board value and color_board value and move them one down (and erase them)
    # t5 is the current game board position, from gravity_position
    lw $t7, 0( $t5 )                # get the game board value of the current square
    sw $zero, 0( $t5 )              # set the game board value of the current square to 0
    sw $t7, 32( $t5 )               # set the old game board value one row down
    
    lw $t7, 1024( $t5 )              # get the color board value of the current square
    sw $zero, 1024( $t5 )            # set the color board value of the current square to 0
    sw $t7, 1056( $t5 )              # set the old color board value one row down

    # sw $t9, -32( $t5 )              # load in the value of the block one above the current (x,y)
    # li $t2, 6                       # temp load the value one above the last "linked" block value
    # ble $t9, $t2, decrement_gravity_x # if the value of the block above is empty, virus, or linked in any direction, skip setting it as "floating"
    
    # li $t2, 10                      # temp load 10 (value of "floating")
    # lw $t2, 0( $t9 )                # save "floating" to block above

    # implicitly, move on to decrement_gravity_x
decrement_gravity_x:
    beqz $t0, decrement_gravity_y   # If x is 0, decrement y instead
    subi $t0, $t0, 1                # subtract 1 from x
    j gravity_position              # go back to checking if gravity needs to be performed on the new (x,y)
decrement_gravity_y:
    beqz $t1, unlinked_gravity_end  # If y is 0 (this label only gets called when x is 0 too), we've checked every block and can go back to the update loop
    subi $t1, $t1, 1                # subtract 1 from y
    li $t0, 7                       # set x to 7
    # now that (x,y) is the right of the row above the last:
    j gravity_position              # go back to checking if gravity needs to be performed on the new (x,y)
grav_hori_right:
    lw $t6, 32( $t5 )               # load in the value one row below the current (x,y) [ on the game board ]
    bnez $t6, decrement_gravity_x   # if the block below the current one is not empty, skip performing gravity on it
    lw $t6, 28( $t5 )               # load in the value one row below and to the left of the current (x,y) [ on the game board ]
    bnez $t6, decrement_gravity_x   # if the block below the paired left block is not empty, skip performing gravity on it

    lw $t6, -4( $t5 )               # get the game board value of the square one to the left
    li $t2, 2                       # load in 2, the value the block to the left should have if it still exists
    beq $t6, $t2, do_gravity        # if that block exists, do gravity normally

    li $t2, 6                       # load in the value for an "unlinked" block
    sw $t2, 0( $t5 )                # if this block's pair does not exist, record it as unlinked in the game_board
    
    j do_gravity                    # move on to perform gravity
grav_hori_left:
    lw $t6, 32( $t5 )               # load in the value one row below the current (x,y) [ on the game board ]
    bnez $t6, decrement_gravity_x   # if the block below the current one is not empty, skip performing gravity on it

    lw $t6, 36( $t5 )               # get the game board value of the square one to the right (after it has already dropped one from gravity)
    li $t2, 4                       # load in 4, the value the block to the right should have if it still exists
    beq $t6, $t2, do_gravity        # if that block exists, do gravity normally
    
    lw $t6, 4( $t5 )                # load in the value one  to the right of the current (x,y) [ on the game board ]
    bnez  $t6, decrement_gravity_x  # if that block is the pair, it didn't get gravity activated, and neither should this block

    li $t2, 6                       # load in the value for an "unlinked" block
    sw $t2, 0( $t5 )                # if this block's pair does not exist, record it as unlinked in the game_board
    
    j do_gravity                    # move on to perform gravity
unlinked_gravity_end:
    bnez $t8, update_loop           # if the accumulator isn't 0 (if more than 0 blocks had gravity apply to them), go back to the start of update_loop
    jr $ra                          # otherwise, continue update_loop


remove_lines:
    # Clear game board and color board for each element in change board
    add $t0, $zero, $zero              # Offset from start of board
    lw $s4, CHANGE_BOARD
remove_lines_loop:
    beq $t0, 512, remove_lines_end
    add $t1, $s4, $t0
    lw $t2, 0($t1)                     # Load change
    beq $t2, 0, remove_lines_loop_end
    add $t3, $zero, $zero
    sw $t3, 0($t1)                     # Erase the change board 
    add $t1, $s2, $t0
    sw $t3, 0($t1)                     # Change the game board to zero
    add $t1, $s3, $t0
    sw $t3, 0($t1)                     # Change the color board to zero
remove_lines_loop_end:
    addu $t0, $t0, 4
    j remove_lines_loop
remove_lines_end:
    jr $ra
      
############################################################################
# Drawing functions
############################################################################
  
draw_background: 
    addi $sp, $sp, -4                  # Make space on stack
    sw $ra, 0($sp)                     # Save return address
    
    li $t4, 0x0283e8                   # $t4 = light blue
    li $t5, 0x265cff                   # $t5 = dark blue
    addi $t2, $s0, 195964              # End position 191 x 256 x 4 + 95 x 4
    addi $t3, $s0, 64892               # Start position 63 x 256 x 4 + 95 x 4
draw_outer_edge_loop:
    beq $t3, $t2, continue_background  # End if start position gets to the end
    sw $t4, -20($t3)
    sw $t5, -16($t3)
    sw $t4, -12($t3)
    sw $t5, -8($t3) 
    sw $t5, -4($t3)
    sw $t4, 0($t3)
    addi $t3, $t3, 256                 # Add width of box to move to the right side
    sw $t4, 20($t3)
    sw $t5, 16($t3)
    sw $t4, 12($t3)
    sw $t5, 8($t3) 
    sw $t5, 4($t3)
    sw $t4, 0($t3)
    addi $t3, $t3, 768                 # A row is 256 x 4, already added 256
    j draw_outer_edge_loop
continue_background:                   # draw the bottom from (96, 191) to (159, 191)
    addi $t2, $s0, 196220              # End position 191 x 256 x 4 + 159 x 4
    addi $t3, $s0, 195968              # Start position 191 x 256 x 4 + 96 x 4
draw_bottom_edge_loop:
    beq $t3, $t2, continue_background_2  # End if start position gets to the end
    sw $t4, 0($t3)
    sw $t5, 1024($t3)
    sw $t5, 2048($t3)
    sw $t4, 3072($t3)
    sw $t5, 4096($t3)
    sw $t4, 5120($t3)
    subu $t6, $t3, 132096               # Go to top (16x8+1)x256x4
    sw $t4, 0($t6)
    sw $t5, -1024($t6)
    sw $t5, -2048($t6)
    sw $t4, -3072($t6)
    sw $t5, -4096($t6)
    sw $t4, -5120($t6)
    addi $t3, $t3, 4                     # Add four to get to the next pixel
    j draw_bottom_edge_loop
continue_background_2:            # draw blocks in the corners
    li $t7, 0x98a6d0
    subi $t8, $t3, 1028           # subtract a little from the ending point of last task to get corners
    jal draw_block
    subi $t8, $t3, 1304
    jal draw_block
    addu $t8, $s0, 57700           # start at (56, 89), 56 x 256 x 4 + 89 x 4
    jal draw_block
    addu $t8, $s0, 57976           # start at (56, 158), 56 x 256 x 4 + 158 x 4
    jal draw_block
    # draw black square over top two central squares
    addu $t8, $s0, 57824          # 56 x 256 x 4 + 120 x 4
    li $t7, 0x000000
    jal draw_eight_by_eight
    addu $t8, $s0, 57856          # 56 x 256 x 4 + 128 x 4
    jal draw_eight_by_eight
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)


draw_score:
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address    
    # Write `SCORE`
    li $a0, 200
    li $a1, 60
    li $a2, 28
    li $a3, 0xffffff              # Set color to white
    jal draw_ascii
    li $a0, 208
    li $a2, 12
    jal draw_ascii
    li $a0, 216
    li $a2, 24
    jal draw_ascii
    li $a0, 224
    li $a2, 27
    jal draw_ascii
    li $a0, 232
    li $a2, 14
    jal draw_ascii
    # Write `HIGH`
    li $a0, 200
    li $a1, 90
    li $a2, 17
    jal draw_ascii
    li $a0, 208
    li $a2, 18
    jal draw_ascii
    li $a0, 216
    li $a2, 16
    jal draw_ascii
    li $a0, 224
    li $a2, 17
    jal draw_ascii
    # Write `SCORE`
    li $a1, 100
    li $a0, 200
    li $a2, 28
    jal draw_ascii
    li $a0, 208
    li $a2, 12
    jal draw_ascii
    li $a0, 216
    li $a2, 24
    jal draw_ascii
    li $a0, 224
    li $a2, 27
    jal draw_ascii
    li $a0, 232
    li $a2, 14
    jal draw_ascii    
    jal update_score_number
    jal update_high_score_number
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)

update_score_number:
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address
    # Erase previous score 
    li $t7, 0x000000
    li $t5, 72480            # (70, 200) = 70x1024+200x4
    addu $t5, $t5, $s0
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    li $a3, 0xffffff
    # Write the first four digits of the score
    li $a1, 70
    lw $t0, SCORE
    li $t1, 10
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 224
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 216
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 208
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 200
    jal draw_ascii
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)

update_high_score_number:
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address
    # Erase previous score 
    li $t5, 113440            # (110, 200) = 110x1024+200x4
    li $t7, 0x000000
    addu $t5, $t5, $s0
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    addu $t5, $t5, 32
    move $t8, $t5
    jal draw_eight_by_eight
    li $a3, 0xffffff
    # Write the first four digits of the high score
    li $a1, 110
    lw $t0, HIGH_SCORE
    li $t1, 10
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 224
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 216
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 208
    jal draw_ascii
    div $t0, $t1
    mfhi $a2
    mflo $t0
    li $a0, 200
    jal draw_ascii
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)



# X = [0, 8], Y = [0, 16]
# Given an X ($a0) and Y ($a1) position, calculate the bitmap display position ($v0)
# Assumes $s0 is the start of the address of the display
calculate_position:
    multu $v0, $a1, 8192    # Starts at (64 + 8Y) x 256 x 4 + (96 + 8X) x 4. First Y x 8 x 256 x 4
    multu $t3, $a0, 32      # X x 8 x 4
    addu $v0, $v0, 65536    # Add 64 x 256 x 4
    addu $t3, $t3, 384      # Add 96 x 4
    addu $v0, $v0, $t3
    add $v0, $s0, $v0       # Final value for start of block
    jr $ra

draw_board:
    addi $sp, $sp, -4         # Make space on stack
    sw $ra, 0($sp)            # Save return address
    li $t0, 0                 # incrementer
draw_board_loop:
    beq $t0, 128, draw_board_done
    multu $t6, $t0, 4        # get position in bytes to change
    addu $t1, $s2, $t6      # position on board
    addu $t2, $s3, $t6      # position on color board
    lw $t6, 0($t1)            # get value at memory address

    li $t5, 8
    div $t0, $t5             # get X and Y coords
    mflo $a1                 # The divisor is the Y coordinate
    mfhi $a0                 # The remainder is the X coordinate
    jal calculate_position
    move $t8, $v0
    lw $t7, 0($t2)            # get color from memory
    addu $t0, $t0, 1
    beq $t6, 0, draw_board_loop
    beq $t6, 1, draw_board_virus
    bgt $t6, 1, draw_board_other
draw_board_virus:
    jal draw_virus
    j draw_board_loop
draw_board_other:
    jal draw_block
    j draw_board_loop
draw_board_done:
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller 



# Erase the playable area
erase_screen:
    addi $sp, $sp, -4         # Make space on stack
    sw $ra, 0($sp)            # Save return address
    
    li $a0, 0                 # Set X to 0
    li $a1, 0                 # Set Y to 0
    jal calculate_position    # Calculate the position of (0,0) on bitmap
    li $t7, 0x0               # Set color to 0
    move $t8, $v0
    li $t9, 63              # Length of a row 8 x 8 - 1
    li $t5, 127              # Set counter to 8 x 16 - 1, number of rows to draw
erase_screen_loop:
    beq $t5, 0, erase_screen_done   # GOTO finish when counter is 0
    jal draw_horizontal_line
    li $t9, 63                      # reset $t9
    addu $t8, $t8, 772              # Add the length of the screen minus the length drawn, 256 x 4 - (8 x 8 - 1) x 4
    subu $t5, $t5, 1                # reduce from counter
    j erase_screen_loop
erase_screen_done:
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)


draw_capsule_main:
    addi $sp, $sp, -4  # Make space on stack
    sw $ra, 0($sp)     # Save return address
    lw $a0, X_POSITION              # Load x from memory
    lw $a1, Y_POSITION              # Load y from memory
    lw $a2, LEFT_COLOR              # Load left color to register
    lw $a3, RIGHT_COLOR             # Load right color to register
    jal draw_capsule                # Jump and link to draw the current position of the capsule
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)

erase_capsule_main:
    addi $sp, $sp, -4  # Make space on stack
    sw $ra, 0($sp)     # Save return address
    lw $a0, X_POSITION              # Load x from memory
    lw $a1, Y_POSITION              # Load y from memory
    li $a2, 0x0                     # Load black
    li $a3, 0x0                     # Load black
    jal draw_capsule                # Jump and link to draw the current position of the capsule
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)


# $a0 is X, $a1 is y, $a2 is left color, $a3 is right color
draw_capsule:
    addi $sp, $sp, -4  # Make space on stack
    sw $ra, 0($sp)     # Save return address
    
    jal calculate_position
    move $t5, $v0                   # Load position into $t5

    lw $t6, ROTATION                # Load in rotation for branching
    beq $t6, 0, draw0
    beq $t6, 1, draw1
    beq $t6, 2, draw2
    beq $t6, 3, draw3

draw0:
    # Draw the capsule  (rotation = 0)
    move $t7, $a2                  # load left color
    move $t8, $t5                  # copy $t5 into $t8 as the starting position
    jal draw_block
    move $t7, $a3                  # load right color
    move $t8, $t5                  # Copy $t5 into $t8 
    addu $t8, $t8, 32              # Add 32 pixels to $t8
    jal draw_block
    j draw_capsule_finish

draw1:
    # Draw the capsule (rotation = 1)
    move $t7, $a2                  # load left color
    move $t8, $t5                  # copy $t5 into $t8 as the starting position
    jal draw_block
    move $t7, $a3                  # load right color
    move $t8, $t5                  # Copy $t5 into $t8 
    subu $t8, $t8, 8192            # subtract 1024 x 8 pixels to $t8
    jal draw_block
    j draw_capsule_finish

draw2:
    # Draw the capsule (rotation = 2)
    move $t7, $a3                  # load right color
    move $t8, $t5                  # copy $t5 into $t8 as the starting position
    jal draw_block
    move $t7, $a2                  # load left color
    move $t8, $t5                  # Copy $t5 into $t8 
    addu $t8, $t8, 32              # Add 32 pixels to $t8
    jal draw_block
    j draw_capsule_finish

draw3:
    # Draw the capsule (rotation = 3)
    move $t7, $a3                  # load right color
    move $t8, $t5                  # copy $t5 into $t8 as the starting position
    jal draw_block
    move $t7, $a2                  # load left color
    move $t8, $t5                  # Copy $t5 into $t8 
    subu $t8, $t8, 8192            # subtract 1024 x 8 pixels to $t8
    jal draw_block
    j draw_capsule_finish
    
draw_capsule_finish:
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)

# $t8 is the top left memory position of the 8x8 block to draw. $t7 is the color
draw_block:     
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address
    
    addu $t8, $t8, 1032     # Start drawing one row down and two blocks in to draw top end
    li $t9, 4
    jal draw_horizontal_line
    addu $t8, $t8, 4         # add four to $t8 to make it consistent for the loop
    
    li $t6, 4
draw_middle_block_loop:
    addu $t8, $t8, 1000     # Start the next line one row minus 6 
    li $t9, 6
    jal draw_horizontal_line
    subu $t6, $t6, 1  # Decrement counter
    bgt $t6, 0, draw_middle_block_loop  # Repeat until all pixels are drawn

    addu $t8, $t8, 1004     # Start the next line one row minus 5 for bottom end
    li $t9, 4
    jal draw_horizontal_line
  
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)

# $t8 is the top left memory position of the 8x8 block to draw. $t7 is the color
draw_virus:
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address

    jal draw_block
    beq $t7, 0xff0000, draw_virus_red
    beq $t7, 0xffff00, draw_virus_yellow
    beq $t7, 0x0000ff, draw_virus_blue
    beq $t7, 0x000000, erase_virus

draw_virus_red:
    li $t6, 0xffff00                 # Red viruses uses yellow
    j draw_virus_end
draw_virus_blue:
    li $t6, 0xff0000                 # Blue viruses uses red
    j draw_virus_end
draw_virus_yellow:
    li $t6, 0x0000ff                 # Yellow viruses uses blue
    j draw_virus_end
draw_virus_end:
    subi $t8, $t8, 4112              # Return $t8 back 4 rows and 4 pixels (4x256x4+4x4) to starting position of virus draw
    sw $t6, 0($t8)           
    addi $t8, $t8, 12
    sw $t6, 0($t8)
    addi $t8, $t8, 2040              # 2x256x4 - 2x4
    sw $t6, 0($t8)
    addi $t8, $t8, 4              
    sw $t6, 0($t8)
    addi $t8, $t8, 1016              # 256x4 - 2x4              
    sw $t6, 0($t8)
    addi $t8, $t8, 12              
    sw $t6, 0($t8)
erase_virus: # erase skips to the exit
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller (main)
  

# Draws an 8x8 square starting at $t8, and color $t7
draw_eight_by_eight:
    addi $sp, $sp, -4  # Make space on stack this archtype is used for nested jal function calls
    sw $ra, 0($sp)     # Save return address
    li $t6, 8                               # draw 8 lines
draw_eight_by_eight_loop:
    beq $t6, 0, draw_eight_by_eight_continue     
    li $t9, 8                               # draw a line of eight length
    jal draw_horizontal_line
    subu $t6, $t6, 1 
    addu $t8, $t8, 992                      # 1024 - 8x4
    j draw_eight_by_eight_loop
draw_eight_by_eight_continue:
    lw $ra, 0($sp)     # Restore return address
    addi $sp, $sp, 4   # Free stack space
    jr $ra             # Return to caller 

# Draws a horizontal line starting at $t8, for $t9 pixels and color $t7. $t9 must be greater than 0
draw_horizontal_line: 
    sw $t7, 0($t8)    # Store color at address
    addiu $t8, $t8, 4 # Move to next pixel (4 bytes per pixel)
    subu $t9, $t9, 1  # Decrement counter
    bgt $t9, 0, draw_horizontal_line  # Repeat until all pixels are drawn
draw_horizontal_line_done:
    jr $ra            # Return


############################################################################
# Main Menu functions
############################################################################
main_menu:
    # Draw the line "MAIN MENU" in white
    li $t4, 0xffffff                 # load in the color of the pixels
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter I on screen
    la $t0, letter_I                 # load the address of "I" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter N on screen
    la $t0, letter_N                 # load the address of "N" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 504               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 544               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter N on screen
    la $t0, letter_N                 # load the address of "N" into t0
    addi $t1, $s0, 584               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter
    # Draw the letter U on screen
    la $t0, letter_U                 # load the address of "U" into t0
    addi $t1, $s0, 624               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 51200             # move down to the correct row (this is 1024 * 50)
    jal start_letter                 # draw the letter

    # Draw the line "EASY" in green
    li $t4, 0x00ff00                 # load in the color of the pixels
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter S on screen
    la $t0, letter_S                 # load the address of "S" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter Y on screen
    la $t0, letter_Y                 # load the address of "Y" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter

    # Draw the line "MEDIUM" in yellow
    li $t4, 0xffff00                 # load in the color of the pixels
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter D on screen
    la $t0, letter_D                 # load the address of "D" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter I on screen
    la $t0, letter_I                 # load the address of "I" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter U on screen
    la $t0, letter_U                 # load the address of "U" into t0
    addi $t1, $s0, 464               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 504               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter

    # Draw the line "HARD" in red
    li $t4, 0xff0000                 # load in the color of the pixels
    # Draw the letter H on screen
    la $t0, letter_H                 # load the address of "H" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter
    # Draw the letter R on screen
    la $t0, letter_R                 # load the address of "R" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter
    # Draw the letter D on screen
    la $t0, letter_D                 # load the address of "D" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter

    # Draw the line "S TO START" in white
    li $t4, 0xffffff                 # load in the color of the pixels
    # Draw the letter S on screen
    la $t0, letter_S                 # load the address of "S" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter T on screen
    la $t0, letter_T                 # load the address of "T" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter O on screen
    la $t0, letter_O                 # load the address of "O" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter S on screen
    la $t0, letter_S                 # load the address of "S" into t0
    addi $t1, $s0, 504               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter T on screen
    la $t0, letter_T                 # load the address of "T" into t0
    addi $t1, $s0, 544               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 584               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter R on screen
    la $t0, letter_R                 # load the address of "R" into t0
    addi $t1, $s0, 624               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter
    # Draw the letter T on screen
    la $t0, letter_T                 # load the address of "T" into t0
    addi $t1, $s0, 664               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 204800            # move down to the correct row (this is 1024 * 200)
    jal start_letter                 # draw the letter

    lw $t0, DIFFICULTY               # load in the starting difficulty value

    # implicitly, move on to menu_input

menu_input:
    # check keyboard input
    lw $t2, 0($s1)                  # load the first word from the keyboard
    beq $t2, 1, menu_keyboard       # If first word 1, key was pressed
menu_loop:
    # Sleep
    li $v0, 32                      # Sleep function
    li $a0, 20                      # 20 Millisecond sleep (50 fps)
    syscall
  
    # here, $t0 should still be the old difficulty, cover that spot with a black square (erase old square)
    li $t1, 80172                   # initial offset (78 rows + 300)
    li $t2, 20480                   # down 20 rows
    mul $t2, $t2, $t0               # turn 20 rows into 20, 40, or 60, depending on difficulty 1, 2, 3 (easy, medium, hard)
    add $t1, $t1, $t2               # find total offset into t1
    add $t1, $s0, $t1               # find position in memory of offset
    li $t3, 0x000000                # load in black
    li $t2, 0                       # create row accumulator
    jal draw_menu_square            # draw over the old difficulty square in black

    lw $t0, DIFFICULTY              # load in the new difficulty
    li $t1, 80172                   # initial offset (78 rows + 300)
    li $t2, 20480                   # down 20 rows
    mul $t2, $t2, $t0               # turn 20 rows into 20, 40, or 60, depending on difficulty 1, 2, 3 (easy, medium, hard)
    add $t1, $t1, $t2               # find total offset into t1
    add $t1, $s0, $t1               # find position in memory of offset
    
    beq $t0, 1, easy_color          # load in green if difficulty is 1
    beq $t0, 2, medium_color        # load in yellow if difficuluty is 2
    beq $t0, 3, hard_color          # load in red if difficulty is 3
    # one of these should branch correctly, implicitly goes to easy if something fails though
easy_color:
    li $t3, 0x00ff00                # load in green
    li $t2, 0                       # create row accumulator
    jal draw_menu_square            # draw in the new difficulty square in green
    j menu_input                    # go back to checking for input
medium_color: 
    li $t3, 0xffff00                # load in yellow
    li $t2, 0                       # create row accumulator
    jal draw_menu_square            # draw in the new difficulty square in yellow
    j menu_input                    # go back to checking for input
hard_color:
    li $t3, 0xff0000                # load in red
    li $t2, 0                       # create row accumulator
    jal draw_menu_square            # draw in the new difficulty square in red
    j menu_input                    # go back to checking for input

# $t1 is (on input) the position of the top left of the square in memory
# $t3 is the color
draw_menu_square:
    li $t5, 10                      # temp load 10 (final value)
    beq $t2, $zero, draw_menu_row   # draw a full row
    beq $t2, $t5 draw_menu_row      # draw a full row
    j draw_menu_side                # otherwise, just draw the two side blocks
draw_menu_square_fin:
    jr $ra                          # go back to where this function was called from

draw_menu_row:
    li $t4, 0                       # create column accumulator
    li $t5, 80                      # load in final value of column accumulator
draw_menu_row_cont:
    sw $t3, 0( $t1 )                # draw the color in the right spot
    addi $t1, $t1, 4                # move t1 to the next pixel
    addi $t4, $t4, 1                # add 1 to the column accumulator
    beq $t4, $t5, draw_menu_row_fin # after 80 columns, finish the row
    j draw_menu_row_cont            # otherwise, repeat the loop
draw_menu_row_fin:
    li $t6, 10                      # load in value of final row
    beq $t2, $t6, draw_menu_square_fin # if this was the final row, finish the square
    addi $t2, $t2, 1                # increment row accumulator
    addi $t1, $t1, 704             # move t1 to the next left corner
    j draw_menu_square              # go back to drawing the square

draw_menu_side:
    sw $t3, 0( $t1 )                # draw the color in the pixel on the left side
    sw $t3, 320( $t1 )              # draw the color in the pixel on the right side
    addi $t1, $t1, 1024             # move t1 to the next row
    addi $t2, $t2, 1                # increment row accumulator
    j draw_menu_square              # go back to drawing the square

menu_keyboard:
    lw $a0, 4($s1)                  # Load second word from keyboard
    
    beq $a0, 0x65, menu_e           # Check if the key e was pressed
    beq $a0, 0x6d, menu_m           # Check if the key m was pressed
    beq $a0, 0x68, menu_h           # Check if the key h was pressed
    beq $a0, 0x73, menu_s           # Check if the key s was pressed
    beq $a0, 0x71, exit             # quit the program if the key q was pressed
    # if the keyboard input was s, start
    # if the keyboard input was e, m, or h, change that variable, and also change difficulty (should figure out how that changes the default gravity requirement)

    j menu_loop                     # move on to the menu loop

menu_e:
    li $t2, 1                       # load in difficulty 1 (easy)
    sw $t2, DIFFICULTY              # save the new difficulty
    
    j menu_loop                     # move on to the menu loop
menu_m:
    li $t2, 2                       # load in difficulty 2 (medium)
    sw $t2, DIFFICULTY              # save the new difficulty
    
    j menu_loop                     # move on to the menu loop
menu_h:
    li $t2, 3                       # load in difficulty 3 (hard)
    sw $t2, DIFFICULTY              # save the new difficulty
    
    j menu_loop                     # move on to the menu loop
    
menu_s:
    # clean the board first
    li $t0, 0                       # load in the first value (top left)
    li $t1, 262144                  # load in the highest value (bottom right)
    # implicitly move on to screen_wipe, to clear everything off the screen
screen_wipe:
    add $t3, $s0, $t0               # load current memory position
    sw $zero, 0( $t3 )              # save 0 to the position in memory
    addi $t0, $t0, 4                # add 4 to the offset from top left
    beq $t0, $t1, wipe_end          # if reached the end, move on
    j screen_wipe                   # otherwise, do another loop
wipe_end:
    j startup                       # move on to the actual game

# $t0 = address of the letter bitmap, $t1 = screen position, $t2 = number of rows the letter has, $t4 = color of letter
start_letter:
    li $t2, 8                        # load in the number of rows the letter has                         (this is set as 8 for convenience. Might be a variable later)
    li $t8, 0                        # create a row accumulator
draw_letter:
    lw $t3, 0( $t0 )                 # load in one byte of the letter
    li $t5, 8                        # load in the number of columns the letter has                      (this is set as 8 for convenience. Might be a variable later)
    li $t6, 0x80                     # create a mask to check each bit, starting at 10000000
draw_letter_pixel:
    and $t7, $t3, $t6                # check if the current bit is set (bitwise AND with the mask)
    beqz $t7, no_store               # if the bit is zero, don't store the color
    sw $t4, 0( $t1 )                 # store the color at the current position
no_store:
    addi $t1, $t1, 4                 # move the current position over one pixel
    srl $t6, $t6, 1                  # move the mask one to the right
    subi $t5, $t5, 1                 # decrease the column counter by 1
    bnez $t5, draw_letter_pixel      # draw the next pixel if not done with the row
finish_letter:
    addi $t8, $t8, 1                 # accumulate another row
    addi $t0, $t0, 4                 # move over to the next byte of the letter
    addi $t1, $t1, 0x3e0             # move to the start of the next row
    bne $t8, $t2, draw_letter        # restart drawing the letter with the next row

    jr $ra                           # return to main menu

############################################################################
# Pause
############################################################################
pause_screen:
    # Draw the line "PAUSED" vertically in white
    li $t4, 0xffffff                 # load in the color of the pixels
    # Draw the letter P on screen
    la $t0, letter_P                 # load the address of "P" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 92160             # move down to the correct row (this is 1024 * 90)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter U on screen
    la $t0, letter_U                 # load the address of "U" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 112640            # move down to the correct row (this is 1024 * 110)
    jal start_letter                 # draw the letter
    # Draw the letter S on screen
    la $t0, letter_S                 # load the address of "S" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 133120            # move down to the correct row (this is 1024 * 130)
    jal start_letter                 # draw the letter
    # Draw the letter D on screen
    la $t0, letter_D                 # load the address of "D" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter

    # implicitly move on to pause_loop
pause_loop:
    # check keyboard input
    lw $t2, 0($s1)                  # load the first word from the keyboard
    beq $t2, 1, pause_keyboard      # If first word 1, key was pressed
    j pause_loop                    # repeat searching for keyboard input

pause_keyboard:
    lw $a0, 4($s1)                  # Load second word from keyboard
    
    beq $a0, 0x70, pause_end        # Check if the key p was pressed

    j pause_loop                    # if it wasn't p, keep searching for keyboard input
    
pause_end:
    # Draw the line "PAUSED" vertically in black (erase it)
    li $t4, 0x000000                 # load in the color of the pixels
    # Draw the letter P on screen
    la $t0, letter_P                 # load the address of "P" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 92160             # move down to the correct row (this is 1024 * 90)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter U on screen
    la $t0, letter_U                 # load the address of "U" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 112640            # move down to the correct row (this is 1024 * 110)
    jal start_letter                 # draw the letter
    # Draw the letter S on screen
    la $t0, letter_S                 # load the address of "S" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 122880            # move down to the correct row (this is 1024 * 120)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 133120            # move down to the correct row (this is 1024 * 130)
    jal start_letter                 # draw the letter
    # Draw the letter D on screen
    la $t0, letter_D                 # load the address of "D" into t0
    addi $t1, $s0, 48                # add in the x offset where we want to draw the letter
    addi $t1, $t1, 143360            # move down to the correct row (this is 1024 * 140)
    jal start_letter                 # draw the letter
    
    j game_loop                      # go back to the game

############################################################################
# Game End
############################################################################
game_over:
    # clear the board first
    li $t0, 0                       # load in the first value (top left)
    li $t1, 265216                  # load in the highest value (bottom right + game_board + color board + change_board)
    # implicitly move on to clear_screen, to clear everything off the screen
clear_screen:
    add $t3, $s0, $t0               # load current memory position
    sw $zero, 0( $t3 )              # save 0 to the position in memory
    addi $t0, $t0, 4                # add 4 to the offset from top left
    beq $t0, $t1, over_cont         # if reached the end, move on
    j clear_screen                  # otherwise, do another loop
over_cont:
    # Draw the line "GAME OVER" in white
    li $t4, 0xffffff                 # load in the color of the pixels
    # Draw the letter G on screen
    la $t0, letter_G                 # load the address of "G" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter O on screen
    la $t0, letter_O                 # load the address of "O" into t0
    addi $t1, $s0, 504               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter V on screen
    la $t0, letter_V                 # load the address of "V" into t0
    addi $t1, $s0, 544               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 584               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter R on screen
    la $t0, letter_R                 # load the address of "R" into t0
    addi $t1, $s0, 624               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter

    lw $t2, SCORE                    # load in the current score
    sw $zero, SCORE                  # zero out score
    lw $t3, HIGH_SCORE               # load in the current high score
    ble $t2, $t3, game_over_loop     # if the current score is less than the high score, skip setting high score
    sw $t2, HIGH_SCORE               # otherwise, set the high score

    # implicitly, continue to game_over_loop
game_over_loop:
    # check keyboard input
    lw $t2, 0($s1)                   # load the first word from the keyboard
    beq $t2, 1, over_keyboard        # If first word 1, key was pressed
    j game_over_loop                 # repeat searching for keyboard input
over_keyboard:
    lw $a0, 4($s1)                   # Load second word from keyboard
    
    beq $a0, 0x72, restart           # Check if the key r was pressed

    j game_over_loop                 # if it wasn't r, keep searching for keyboard input
restart:
    # Draw the line "GAME OVER" in black (erase it)
    li $t4, 0x000000                 # load in the color of the pixels
    # Draw the letter G on screen
    la $t0, letter_G                 # load the address of "G" into t0
    addi $t1, $s0, 304               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter A on screen
    la $t0, letter_A                 # load the address of "A" into t0
    addi $t1, $s0, 344               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter M on screen
    la $t0, letter_M                 # load the address of "M" into t0
    addi $t1, $s0, 384               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 424               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter O on screen
    la $t0, letter_O                 # load the address of "O" into t0
    addi $t1, $s0, 504               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter V on screen
    la $t0, letter_V                 # load the address of "V" into t0
    addi $t1, $s0, 544               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter E on screen
    la $t0, letter_E                 # load the address of "E" into t0
    addi $t1, $s0, 584               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
    # Draw the letter R on screen
    la $t0, letter_R                 # load the address of "R" into t0
    addi $t1, $s0, 624               # add in the x offset where we want to draw the letter
    addi $t1, $t1, 102400            # move down to the correct row (this is 1024 * 100)
    jal start_letter                 # draw the letter
  
    j main                          # jump to main
  
############################################################################
# ASCII letters font system 1
############################################################################

# Draws an ascii character
# a0 - x coordinate
# a1 - y coordinate
# a2 - ascii character. 0-9 is numbers, 10-35 is characters. All characters in uppercase
# a3 - color
# does not use register $t0-$t2
draw_ascii:
    multu $t3, $a1, 1024              # number of rows
    multu $t4, $a0, 4                 # x coordinate times 4 for pixel width
    addu $t3, $t3, $t4                # total offset
    addu $t3, $s0, $t3                # position on draw board 
    beq   $a2, 0,  draw_0
    beq   $a2, 1,  draw_1
    beq   $a2, 2,  draw_2
    beq   $a2, 3,  draw_3
    beq   $a2, 4,  draw_4
    beq   $a2, 5,  draw_5
    beq   $a2, 6,  draw_6
    beq   $a2, 7,  draw_7
    beq   $a2, 8,  draw_8
    beq   $a2, 9,  draw_9
    beq   $a2, 10, draw_A
    beq   $a2, 11, draw_B
    beq   $a2, 12, draw_C
    beq   $a2, 13, draw_D
    beq   $a2, 14, draw_E
    beq   $a2, 15, draw_F
    beq   $a2, 16, draw_G
    beq   $a2, 17, draw_H
    beq   $a2, 18, draw_I
    beq   $a2, 19, draw_J
    beq   $a2, 20, draw_K
    beq   $a2, 21, draw_L
    beq   $a2, 22, draw_M
    beq   $a2, 23, draw_N
    beq   $a2, 24, draw_O
    beq   $a2, 25, draw_P
    beq   $a2, 26, draw_Q
    beq   $a2, 27, draw_R
    beq   $a2, 28, draw_S
    beq   $a2, 29, draw_T
    beq   $a2, 30, draw_U
    beq   $a2, 31, draw_V
    beq   $a2, 32, draw_W
    beq   $a2, 33, draw_X
    beq   $a2, 34, draw_Y
    beq   $a2, 35, draw_Z
    jr    $ra                         # Return if no match

#### NOTE all characters are created in a 5x6 grid. Easier to take a completed 5x6 grid as below and subtract 
#### what should not be there to construct new letters
#### Based off of font https://cdn.vectorstock.com/i/1000v/81/81/retro-game-pixel-art-font-pixelated-text-alphabet-vector-44758181.jpg
    # sw $a3, 0( $t3 ) 
    # sw $a3, 4( $t3 ) 
    # sw $a3, 8( $t3 ) 
    # sw $a3, 12( $t3 ) 
    # sw $a3, 16( $t3 ) 
    # sw $a3, 1024( $t3 ) 
    # sw $a3, 1028( $t3 ) 
    # sw $a3, 1032( $t3 ) 
    # sw $a3, 1036( $t3 ) 
    # sw $a3, 1040( $t3 ) 
    # sw $a3, 2048( $t3 ) 
    # sw $a3, 2052( $t3 ) 
    # sw $a3, 2056( $t3 ) 
    # sw $a3, 2060( $t3 ) 
    # sw $a3, 2064( $t3 ) 
    # sw $a3, 3072( $t3 ) 
    # sw $a3, 3076( $t3 ) 
    # sw $a3, 3080( $t3 ) 
    # sw $a3, 3084( $t3 ) 
    # sw $a3, 3088( $t3 ) 
    # sw $a3, 4096( $t3 ) 
    # sw $a3, 4100( $t3 ) 
    # sw $a3, 4104( $t3 ) 
    # sw $a3, 4108( $t3 ) 
    # sw $a3, 4112( $t3 ) 
    # sw $a3, 5120( $t3 ) 
    # sw $a3, 5124( $t3 ) 
    # sw $a3, 5128( $t3 ) 
    # sw $a3, 5132( $t3 ) 
    # sw $a3, 5136( $t3 ) 
    # sw $a3, 6144( $t3 ) 
    # sw $a3, 6148( $t3 ) 
    # sw $a3, 6152( $t3 ) 
    # sw $a3, 6156( $t3 ) 
    # sw $a3, 6160( $t3 ) 

draw_0:
    # Draw character '0'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2060( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4100( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_1:
    # Draw character '1'
    sw $a3, 8( $t3 ) 
    sw $a3, 1028( $t3 ) 
    sw $a3, 1032( $t3 ) 
    sw $a3, 2056( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 5128( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_2:
    # Draw character '2'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 5124( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    sw $a3, 6160( $t3 ) 
    jr $ra

draw_3:
    # Draw character '3'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_4:
    # Draw character '4'
    sw $a3, 12( $t3 ) 
    sw $a3, 1032( $t3 ) 
    sw $a3, 1036( $t3 ) 
    sw $a3, 2052( $t3 ) 
    sw $a3, 2060( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4108( $t3 ) 
    sw $a3, 5124( $t3 ) 
    sw $a3, 5128( $t3 ) 
    sw $a3, 5132( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_5:
    # Draw character '5'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 16( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_6:
    # Draw character '6'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_7:
    # Draw character '7'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 16( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 5124( $t3 )  
    sw $a3, 6144( $t3 ) 
    jr $ra

draw_8:
    # Draw character '8'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_9:
    # Draw character '9'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_A:
    # Draw character 'A'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4100( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 4108( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6160( $t3 ) 
    jr $ra

draw_B:
    # Draw character 'B'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_C:
    # Draw character 'C'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_D:
    # Draw character 'D'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1036( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5132( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    jr $ra

draw_E:
    # Draw character 'E'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 16( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    sw $a3, 6160( $t3 ) 
    jr $ra

draw_F:
    # Draw character 'F'
    jr $ra

draw_G:
    # Draw character 'G'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 )  
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4108( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_H:
    # Draw character 'H'
    sw $a3, 0( $t3 ) 
    sw $a3, 16( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4100( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 4108( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6144( $t3 )  
    sw $a3, 6160( $t3 ) 
    jr $ra

draw_I:
    # Draw character 'I'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1032( $t3 ) 
    sw $a3, 2056( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 4104( $t3 ) 
    sw $a3, 5128( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_J:
    # Draw character 'J'
    jr $ra

draw_K:
    # Draw character 'K'
    jr $ra

draw_L:
    # Draw character 'L'
    jr $ra

draw_M:
    # Draw character 'M'
    jr $ra

draw_N:
    # Draw character 'N'
    jr $ra

draw_O:
    # Draw character 'O'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3088( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_P:
    # Draw character 'P'
    jr $ra

draw_Q:
    # Draw character 'Q'
    jr $ra

draw_R:
    # Draw character 'R'
    sw $a3, 0( $t3 ) 
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 2064( $t3 ) 
    sw $a3, 3072( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4096( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6144( $t3 ) 
    sw $a3, 6160( $t3 ) 
    jr $ra

draw_S:
    # Draw character 'S'
    sw $a3, 4( $t3 ) 
    sw $a3, 8( $t3 ) 
    sw $a3, 12( $t3 ) 
    sw $a3, 1024( $t3 ) 
    sw $a3, 1040( $t3 ) 
    sw $a3, 2048( $t3 ) 
    sw $a3, 3076( $t3 ) 
    sw $a3, 3080( $t3 ) 
    sw $a3, 3084( $t3 ) 
    sw $a3, 4112( $t3 ) 
    sw $a3, 5120( $t3 ) 
    sw $a3, 5136( $t3 ) 
    sw $a3, 6148( $t3 ) 
    sw $a3, 6152( $t3 ) 
    sw $a3, 6156( $t3 ) 
    jr $ra

draw_T:
    # Draw character 'T'
    jr $ra

draw_U:
    # Draw character 'U'
    jr $ra

draw_V:
    # Draw character 'V'
    jr $ra

draw_W:
    # Draw character 'W'
    jr $ra

draw_X:
    # Draw character 'X'
    jr $ra

draw_Y:
    # Draw character 'Y'
    jr $ra

draw_Z:
    # Draw character 'Z'
    jr $ra

exit:
    li $v0, 10
    syscall