
Code Segment
	             assume CS:Code, DS:Data, SS:Stack

	Start:       
	             mov    ax, Code
	             mov    DS, AX

	             mov    dh, 0                     	; X - row
	             mov    dl, 0                     	; Y - col
	             push   dx                        	; push Y
	Time:        
	             xor    ah, ah
	             int    1ah                       	; Gets ticks since midnight into DX
	             push   dx                        	; Save old time
				 
	Elapsed:     
	             xor    ah, ah
	             int    1ah                       	; Gets ticks since midnight into DX

	             pop    cx                        	; Get old time
	             push   cx                        	; Save old time

	             sub    dx, cx                    	; Telapsed = Tcurrent - Told

	             cmp    dx, 1                    	; Loop if dx < 100
	             jc     Elapsed
	             pop    cx
	Clear:       
	             mov    ax, 03h                   	; mod the screen to display space in old pos
	             int    10h

	             xor    dx, dx                    	; (using 16 bits register) Clear to 0

	             xor    bh, bh
	             mov    ah, 02h
	             int    10h
	Setpos:      
	             pop    dx                        	; pop x
	             mov    bh, 0
	             mov    ah, 2
	             int    10h
	             push   dx
	Write:       
	             mov    dx, offset Bouncingtext
	             mov    ah, 09h
	             int    21h

	Right:       
	             pop    dx
	             inc    dl
	             cmp    dl, 255
	             je     Reset2
	             push   dx
	             jmp    Time
	Reset2:      
	             xor    dl,dl
	             jmp    Down
	Down:        
	             inc    dh
	             cmp    dh, 200
	             je     Reset
	             push   dx
	             jmp    Time
	Reset:       
	             xor    dh, dh
	             push   dx
	             jmp    Time
	End_program: 
	             mov    ax, 4c00h
	             int    21h

	Bouncingtext:
	             db     "Wow, it's moving!$"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

