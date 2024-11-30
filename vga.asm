; Handling a 320x200 screen drawing

Code Segment
	            assume CS:Code, DS:Data, SS:Stack

	Start:      
	            mov    ax, Code
	            mov    DS, AX

	            mov    dx, 1                     	; X coord
	            mov    ax, 1                     	; Y coord
	            push   ax                        	; push Y
	            push   dx                        	; push X
	            mov    cl, 30                    	; Set initial pixel color

	            mov    ax, 13h                   	; change vga mode
	            int    10h

	            mov    ax, 0a000h                	; Video memory beginning address
	            mov    es, ax                    	; Extra segment

	; Pixel = Y * 320 + X
	Draw:       
	            pop    dx                        	; pop x
	            pop    ax                        	; pop Y
	            push   ax                        	; push Y
	            push   dx                        	; push X
	            mov    bx, 320
	            mul    bx                        	; Y * 320 (dx:ax = ax*bx)
	            pop    dx                        	; pop X
	            push   dx                        	; push X
	            add    ax, dx                    	; Add Y * 320 and X
	            mov    di, ax                    	; Save to di
	CheckUp:    
	            inc    cl
	            cmp    cl, 61
	            jnc    Reset
	            jmp    Pixel
	Reset:      
	            mov    cl, 30
	Pixel:      
	            mov    es:[di], cl               	; moving pixel color to extra segment memory;
	Waiting:    
	            xor    ah, ah
	            int    16h

	            cmp    al, 27
	            jz     End_program

	            cmp    al, 'a'
	            jz     Left

	            cmp    al, 'd'
	            jz     Right

	            cmp    al, 'w'
	            jz     Up

	            cmp    al, 's'
	            jz     Down

	            jmp    Waiting

	Left:       
	            pop    ax
	            dec    ax
	            cmp    ax, 0
	            jnc    Store1
	            inc    ax                        	; Check until reaches X < 1, inrease back if not
	Store1:     
	            push   ax
	            jmp    Draw
	Right:      
	            pop    ax
	            inc    ax
	            cmp    ax, 320                   	; Check right edge x > 320
	            jc     Store2
	            dec    ax
	Store2:     
	            push   ax
	            jmp    Draw
	Up:         
	            pop    ax                        	; pop x
	            pop    dx                        	; pop y
	            dec    dx
	            cmp    dx, 0
	            jnc    Store3
	            inc    dx
	Store3:     
	            push   dx                        	; push y
	            push   ax                        	; push x
	            jmp    Draw
	Down:       
	            pop    ax                           ; pop x
	            pop    dx							; pop y
	            inc    dx
	            cmp    dx, 200
	            jc     Store4
	            dec    dx
	Store4:     
	            push   dx							
	            push   ax
	            jmp    Draw
	
	End_program:
	            mov    ax, 03h
	            int    10h                       	; Restore VGA mode

	            pop    dx
				pop    ax

	            mov    ax, 4c00h
	            int    21h
Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

