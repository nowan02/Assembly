
Code Segment
	            assume CS:Code, DS:Data, SS:Stack

	Start:      
	            mov    ax, Code
	            mov    DS, AX
	; Clear screen
	            mov    ax, 03h
	            int    10h

	Display:    
	; Set cursor
	            mov    ah, 02h
	            mov    bh, 0                      	; screen number
	            mov    dh, 10                     	; row
	            mov    dl, 0                      	; column
	            int    10h
	; Display string
	            mov    dx, offset message1
	            mov    ah, 09h
	            int    21h
	; Display counter number
				mov    dx, offset counter2
	            mov    ah, 09h
	            int    21h

	            mov    dx, offset counter1
	            mov    ah, 09h
	            int    21h

	            mov    dx, offset message2
	            mov    ah, 09h
	            int    21h

	Input:      
	            xor    ax, ax                     	; reset ax
	            int    16h                        	; Read keyboard input to AH, ASCII code to AL

	            cmp    al, 27                     	; compare ASCII in al to ASCII of ESCAPE
	            jz     End_program

				cmp al, "a"
				jz Count1
				jmp	   Input             			; Jump to end if cmp returns 0 (True)

	Count1:     
	;COUNT1
	            mov    di, offset counter1
	            mov    al, [di]                   	; load address of DI into AL
	            inc    al                         	; al++
	            mov    [di], al                   	; load value of AL into DI's address

	            cmp    al, ':'
	            jz     Reset1
	            jmp    Display
	;COUNT1
	
	;COUNT2
	Reset1:     
	            mov    al, '0'
	            mov    [di], al

	Count2:     
	            mov    di, offset counter2
	            mov    ah, [di]                   	; load address of DI into AL
	            inc    ah                         	; al++
	            mov    [di], ah                   	; load value of AL into DI's address

	            cmp    al, ':'
	            jz     End_program
	            jmp    Display

	End_program:
	            mov    ax, 4c00h
	            int    21h

	message1:   
	            db     "The 'a' key was pressed $"
	message2:   
	            db     " times$"
	counter1:   
	            db     "0$"
	counter2:   
	            db     "0$"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

