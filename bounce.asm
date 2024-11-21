
Code Segment
	             assume CS:Code, DS:Data, SS:Stack

	Start:       
	             mov    ax, Code
	             mov    DS, AX

	             mov    dh, 0                     	; X - row
	             mov    dl, 0                     	; Y - col
	             push   dh                        	; push X
	             push   dl                        	; push Y
	Setpos:      
	             pop    dl                        	; pop y
	             pop    dh                        	; pop x
	             mov    bh, 0
	             mov    ah, 2
	             int    10h
	             push   dh                        	; push x
	             push   dl                        	; push y

	Write:       
	             mov    dx, offset Bouncingtext
	             mov    ah, 09h
	             int    21h

	Right:       
	             pop    dl
	             inc    dl
	             cmp    dl, 255
	             je     Reset2
	Reset2:      
	             xor    dl,dl
	             push   dl
	             jmp    Setpos

	Down:        
	             pop    dl
	             pop    dh
	             inc    dh
	             cmp    dh, 200
	             jnc    Reset
	Reset:       
	             xor    dh, dh
	             push   dh
	             push   dl
	             jmp    Setpos
	

    
				 








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

