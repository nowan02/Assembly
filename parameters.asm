
Code Segment
	            assume CS:Code, DS:Data, SS:Stack

	Start:      
	            mov    di, 82h                   	; Program Segment Prefix, 256 bytes allocated before running code at 80h, length of the param at 81h: space
	            mov    cx, 10                    	; Set cycle

	Find:       
	            mov    dl, [di]                  	; Dereference di to dl
	            cmp    dl, "/"
	            jz     Start_param               	; Processing found digits
	            inc    di
	            loop   Find
	            jmp    Default                   	; Command not found

	Start_param:
	            inc    di
	            mov    bl, [di]                  	; decimals
	            sub    bl, 48
	           
	            inc    di
	            mov    bh, [di]                  	; tens
	            sub    bh, 48

	            mov    ax, 10
	            mul    bl                        	; multiple decimal by 10

	            add    al, bh                    	; adding two nums
	            mov    cx, ax                    	; set v0 using param

	            jmp    Init

	Default:    
	            mov    cx, 10                    	; Default speed

	Init:       
	            mov    ax, Code
	            mov    ds, ax

	            xor    di, di                    	; row pos
	            xor    si, si                    	; column pos

	            xor    dx, dx
	            push   dx                        	; push time (0) to stack

	Delete:     
	            mov    ax, 03h                   	; Clear screen
	            int    10h

	Draw:       
	            mov    bx, di                    	; Row coordinate
	            mov    dh, bl                    	; Lower byte of di
	            mov    bx, si                    	; Column coord
	            mov    dl, bl                    	; lower byte of si
	            xor    bh, bh
	            mov    ah, 02h                   	; Cursor pos
	            int    10h

	            mov    dx, offset Ball           	; BALL
	            mov    ah, 09h
	            int    21h

	            pop    ax                        	; Pop time from stack to ax
	            push   ax

	            mul    al                        	; time squared result to ax
	            shr    ax, 1                     	; divide by 2
	            mov    di, ax

	            pop    ax                        	; pop time
	            inc    ax                        	; increase time
	            push   ax                        	; push back time
	            dec    ax                        	; decrease it

	            mul    cl                        	; square time store in al
	            mov    si, ax                    	; squared time to si

	            cmp    si, 80                    	; Right edege?
	            jnc    Waiting

	            cmp    si, 25                    	; Low edge?
	            jnc    Waiting

	            jmp    Delete

	Waiting:    
	            xor    ax, ax                    	; Wait for keystroke
	            int    16h

	End_program:
	            pop    cx
	            mov    ax, 4c00h
	            int    21h

	Ball:       
	            db     "O$"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

