Code Segment
	            assume CS:Code, DS:Data, SS:Stack
	Start:      
	            mov    ax, Code
	            mov    ds, ax
	            mov    di, offset value
	; Clear screen
	            mov    ax, 03
	            int    10h
	Input:      
	; Wait for input
	            xor    ax, ax
	            int    16h

	; Clear screen again
	            mov    bx,ax                     	; save ax
	            mov    ax, 03
	            int    10h
	            mov    ax,bx                     	; restore ax

	; Check for escape
	            cmp    al, 27
	            jz     End_program

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
	Store:      
	            mov    [di], al                  	; srite input to address of di
	            inc    di                        	; increase offset
	            mov    al, '$'                   	; write line terminator
	            mov    [di], al                  	; write line terminator

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

				
	;jmp    Start
	End_program:
	            mov    ax, 4c00h
	            int    21h
	fault:      db     'illegal character!$'
	value:      db     '*****$'
	message:    db     'End of input$'
Code Ends
Data Segment
Data Ends
Stack Segment
Stack Ends
End Start