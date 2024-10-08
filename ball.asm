
Code Segment
	            assume CS:Code, DS:Data, SS:Stack

	Start:      
	            mov    ax, Code
	            mov    DS, AX

	            xor    di, di                    	; place of the bal (row)
	            mov    si, 1                     	; ball start downward (direction vector)
	            xor    dx, dx
	            push   dx                        	; old time to the stack (now 0)
	Clear:      
	            mov    ax, 03h
	            int    10h

	            mov    dx, di                    	; (using 16 bits register) Clear to 0
	            mov    dh, dl                    	; position to DI row (8 bits)

	            mov    dl, 40                    	; position 40. column
	            xor    bh, bh
	            mov    ah, 02h
	            int    10h
	; Display ball
	            mov    dx, offset Ball
	            mov    ah, 09h
	            int    21h

	Delay:      
	            mov    ah, 01h
	            int    16h
	            jnz    End_program
	            jz     Nokey

	            mov    ah, 00h
	            int    16h
	            cmp    al, 27
	            jz     End_program

	Nokey:      
	            xor    ah, ah
	            int    1ah                       	; Gets ticks since midnight into CX

	            pop    cx                        	; pop out old time (save to CX and delete from the stack)
	            push   cx                        	; push in old time (save to stack, CX value stays same)
	            mov    ax, dx                    	; saving current time to the stack
	            sub    dx, cx                    	; Telapsed = Tcurrent - Told
	            push   ax

	            cmp    di, 5
	            jnc    Time1                     	;jump, if di greater than or equal
	            mov    al, 16
	            jmp    Set

	Time1:      
	            cmp    di, 10
	            jnc    Time2                     	;jump, if di greater than or equal
	            mov    al, 8
	            jmp    Set
	Time2:      
	            cmp    di, 15
	            jnc    Time3                     	;jump, if di greater than or equal
	            mov    al, 4
	            jmp    Set
	Time3:      
	            cmp    di, 20
	            jnc    Time4                     	;jump, if di greater than or equal
	            mov    al, 2
	            jmp    Set
	Time4:      
	            mov    al, 1
	Set:        
	            xor    ah, ah
	            cmp    dx, ax
	            pop    ax                        	; Needed to update old time
	            jc     Delay

	            pop    cx                        	; Pop old time
	            push   ax                        	; push current time
				
	            cmp    di, 0
	            jz     Downwards

	            cmp    di, 24
	            jz     Upwards
	Movement:   
	            add    di, si                    	; New pos (direction vector + speed)
	            jmp    Clear
	Downwards:  
	            mov    si, 1
	            jmp    Movement
	Upwards:    
	            mov    si, -1
	            jmp    Movement
	

	End_program:
	            pop    cx
	            mov    ax, 4c00h
	            int    21h
	
	Ball:       
	            db     "o$"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

