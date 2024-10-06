Code Segment
	            assume CS:Code, DS:Data, SS:Stack
	Start:      
	            mov    ax, Code
	            mov    ds, ax
	First:      
	; Clear screen
	            mov    ax, 03
	            int    10h

	            mov    di, offset program_c
	            mov    ah, [di]                  	; Dereference DI into AH
	            inc    ah                        	; ah++
	            mov    [di], ah

	            mov    di, offset value

	            mov    dx, offset start_1
	            mov    ah, 09
	            int    21h
	            jmp    Input
	Second:     
	; Clear screen
	            mov    ax, 03
	            int    10h

	            mov    di, offset program_c
	            mov    ah, [di]                  	; Dereference DI into AH
	            inc    ah                        	; ah++
	            mov    [di], ah

	            mov    di, offset value
	            mov    dx, offset start_2
	            mov    ah, 09
	            int    21h

	Input:      
	; Wait for input
	            xor    ax, ax
	            int    16h

	; Clear screen again
	            mov    bx,ax                     	; save ax
	            mov    ax, 03
	            int    10h
	            mov    ax,bx                     	; restore ax

	            mov    ah, 02h
	            mov    bh, 0
	            mov    dh, 10
	            mov    dl, 28
	            int    10h

	; Check for escape
	            cmp    al, 27
	            jz     End_program

	; Check for "B"
	            cmp    al, 98
	            jz     Reset

	            mov    cx, 10
	            mov    ah, '0'
	Exam:       
	            cmp    al, ah
	            jz     Store
	            inc    ah
	            loop   Exam

	; Set cursor position
	            mov    ah, 02h
	            mov    bh, 0
	            mov    dh, 10
	            mov    dl, 28
	            int    10h

	; Since loop ran, we display fault
	            mov    dx, offset fault
	            mov    ah, 09
	            int    21h
	            jmp    Input
	
	Jank_jump:  
	            jmp    Second

	Reset:      
	            mov    [di], al                  	; write input to address of di
	            dec    di                        	; decrease offset
	            mov    al, '$'                   	; write line terminator in place of number
	            mov    [di], al                  	; write line terminator
	            jmp    Check

	Store:      
	            mov    [di], al                  	; srite input to address of di
	            inc    di                        	; increase offset
	            mov    al, '$'                   	; write line terminator
	            mov    [di], al                  	; write line terminator
	

	Check:      
	; set cursor
	            mov    ah, 02h
	            mov    bh, 0
	            mov    dh, 5
	            mov    dl, 28
	            int    10h

	; display value
	            mov    dx, offset value
	            mov    ah, 09
	            int    21h

	            mov    ax, offset value          	; move value to ax
	            add    ax, 4                     	; increase ax by 4
	            cmp    ax, di                    	; compare ax with di
	            jnz    Input                     	; If di does not have 4 characters, its offset differs from ax

	            mov    ah, 02h
	            mov    bh, 0
	            mov    dh, 7
	            mov    dl, 0
	            int    10h

	            mov    dx, offset message
	            mov    ah, 09h
	            int    21h

	            xor    ax, ax
	            int    16h

	            mov    di, offset program_c
	            mov    ah, [di]
	            cmp    ah, 01
	            jz     Jank_jump
	            jmp    End_program



	End_program:
	            mov    ax, 4c00h
	            int    21h

	fault:      db     'illegal character!$'
	value:      db     '*****$'
	message:    db     'End of input, press any key to continue$'
	start_1:    db     'Begin input 1:$'
	start_2:    db     'Begin input 2:$'
	program_c   db     00d
Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start