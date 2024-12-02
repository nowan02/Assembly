
;2021.11.22
;==========================================================================
;Name:
;Neptun code:
;Date: 19.12.2016
;
;==========================================================================
Code Segment
	              assume CS:Code, DS:Data, SS:Stack

	Start:        

	              mov    ax, Code
	              mov    DS, AX

	              mov    ax, 03h
	              int    10h

	              mov    ah,9
	              mov    dx, offset task1
	              int    21h
	
	              mov    dh, 2
	              mov    dl, 5
	              xor    bx, bx
	              mov    ah, 02
	              int    10h
	
	              xor    ax, ax
	              xor    bx, bx
	              xor    cx, cx
	              xor    dx, dx
	              xor    di, di
	              xor    si, si
	
	;Task_1:
	;==========================================================================
	;1. Task:
	; Fill the "name" string (you can be found it at strings) with your own name, with lowercase letters
	; using only english letters (eg "joe black"), and then display it in the next form:
	; BLACK, Joe
	; That is : SURENAME, Firstname
	;==========================================================================
	
	;**************************************************************************
	;Write here the appropriate program part, using the code found here!
	
	              mov    di, offset nev
	Lastname:     
	              mov    dl, [di]
	              cmp    dl, 20h
	              jz     Write
	              inc    di
	              loop   Lastname
	Write:        
	              mov    dl, [di]
	              cmp    dl, '$'
	              jz     WriteLast
	              sub    dl, 32
	              mov    ah, 2
	              int    21h
	              inc    di
	              loop   Write

	WriteLast:    
	              mov    dl, ','
	              mov    ah, 2
	              int    21h
	              mov    dl, 20h
	              mov    ah, 2
	              int    21h

	              mov    di, offset nev
	              mov    dl, [di]
	              sub    dl, 32
	              mov    ah, 2
	              int    21h
	              inc    di
	WriteLastLoop:
	              mov    dl, [di]
	              cmp    dl, 20h
	              jz     EndTask1
	              mov    ah, 2
	              int    21h
	              inc    di
	              loop   WriteLastLoop
	EndTask1:     
	;so far
	;**************************************************************************
	              xor    ax, ax
	              int    16h

	;==========================================================================
	;2. task:
	; VGA (320x200px, 8bit)
	; Draw a square standing on his vertex.
	; length of side: 80 pixels,
	; coordinates of the upper vertex is in CX register!
	;
	;**************************************************************************
	;VGA mode
	              mov    ax, 13h
	              int    10h
	              mov    ax, 0a000h
	              mov    es, ax
	
	              xor    ax, ax
	              xor    bx, bx
	              xor    dx, dx
	              xor    di, di
	              xor    si, si
	
	;start coordinates
	              mov    cl,100                     	;row
	              mov    ch,150                     	;column

	;**************************************************************************
	;Write here the appropriate program part!
	
	              push   cx
	              mov    cx, 80
	Draw:         
	              pop    dx
	              xor    ah, ah
	              mov    al, dh
	              push   dx
	              mov    bx, 320
	              mul    bx
	              pop    dx
	              push   dx
	              xor    dh, dh
	              add    ax, dx
	Pixel:        
	              mov    di, ax
	              mov    di, ax
	              mov    al, 45
	              mov    es:[di], al
	DownLeft:     
	              pop    dx
	              inc    dl
	              dec    dh
	              push   dx
	              loop   Draw
	              mov    cx, 80
	Draw1:        
	              pop    dx
	              xor    ah, ah
	              mov    al, dh
	              push   dx
	              mov    bx, 320
	              mul    bx
	              pop    dx
	              push   dx
	              xor    dh, dh
	              add    ax, dx
	Pixel1:       
	              mov    di, ax
	              mov    di, ax
	              mov    al, 45
	              mov    es:[di], al
	DownRight:    
	              pop    dx
	              dec    dl
	              dec    dh
	              push   dx
	              loop   Draw1
	              mov    cx, 80
	Draw2:        
	              pop    dx
	              xor    ah, ah
	              mov    al, dh
	              push   dx
	              mov    bx, 320
	              mul    bx
	              pop    dx
	              push   dx
	              xor    dh, dh
	              add    ax, dx
	Pixel2:       
	              mov    di, ax
	              mov    di, ax
	              mov    al, 45
	              mov    es:[di], al
	UpRight:      
	              pop    dx
	              dec    dl
	              inc    dh
	              push   dx
	              loop   Draw2
	              mov    cx, 80
	Draw3:        
	              pop    dx
	              xor    ah, ah
	              mov    al, dh
	              push   dx
	              mov    bx, 320
	              mul    bx
	              pop    dx
	              push   dx
	              xor    dh, dh
	              add    ax, dx
	Pixel3:       
	              mov    di, ax
	              mov    di, ax
	              mov    al, 45
	              mov    es:[di], al
	UpLeft:       
	              pop    dx
	              inc    dl
	              inc    dh
	              push   dx
	              loop   Draw3

	;so far
	;==========================================================================
	Var:          
	              xor    ax,ax
	              int    16h
	
	Task_3:       
	;===========================================================================
	; 3. task:
	;
	; Perform the operation founded in 'operation' string!
	; The two number (0..9, single digits!), and the operation(+,-,*,/) can be any,
	; the string content has to process!
	;
	; There is enough to display only one character as a result! The div enough to display the result,
	; the residue should not!
	;
	; Display the operation, and the result (single digits)!
	; eg: 3+2=5
	; 3-2=1
	; 3*2=6
	; 3/2=1
	;===========================================================================
	              mov    ax, 03h
	              int    10h

	              mov    ah,9
	              mov    dx, offset task3
	              int    21h

	              mov    dh, 2
	              mov    dl, 5
	              xor    bx, bx
	              mov    ah, 02
	              int    10h
	
	              mov    ah,9
	              mov    dx, offset operation
	              int    21h

	
	              xor    ax, ax
	              xor    bx, bx
	              xor    cx, cx
	              xor    dx, dx
	              xor    di, di
	              xor    si, si
	

	; --------------------------------------------------------------------------
	;Write here the appropriate program part!
	              mov    di, offset operation
	Compare:      
	              mov    dl, [di]
	              sub    dl, 48
	              mov    ch, dl

	              add    di, 2

	              mov    dl, [di]
	              sub    dl, 48
	              mov    cl, dl

	DecideOp:     
	              mov    di, offset operation
	              inc    di
	              mov    dl, [di]
	              cmp    dl, '-'
	              jz     Subtract

	              cmp    dl, '+'
	              jz     Addition

	              cmp    dl, '/'
	              jz     Divide

	              cmp    dl, '*'
	              jz     Multiply
	              jnz    Error
	Subtract:     
	              sub    ch, cl
	              xor    ax, ax
	              mov    al, ch
	              jmp    Display
	Addition:     
	              add    ch, cl
	              xor    ax, ax
	              mov    al, ch
	              jmp    Display
	Divide:       
	              xor    ax, ax
	              mov    al, ch
	              div    cl
	              jmp    Display
	Multiply:     
	              xor    ax, ax
	              mov    al, ch
	              mul    cl
	              jmp    Display

	Display:      
	              mov    dx, ax
	              mov    di, offset operation
	              mov    ah, 09h
	              int    21h

	              add    dl, 48
	              mov    bl, dl
	              mov    ah, 02h
	              int    21h
	Error:        
				
	; so far
	; --------------------------------------------------------------------------
	; Waiting for a keystroke
	              xor    ax, ax
	              int    16h
	

	Task_4:       
	;------------------------------------------------------------------------
	; 4. task:
	;
	; Display the sentence4 string at the 10th row!
	; The string shall move from left side to right side on tbe screen,
	; and back, twice.
	;
	;===========================================================================
	              mov    ax, 03h
	              int    10h
	
	              mov    ah,9
	              mov    dx, offset task4
	              int    21h

	              xor    ax, ax
	              xor    bx, bx
	              xor    cx, cx
	              xor    dx, dx
	              xor    di, di
	              xor    si, si
	

	;-------------------------------------------------------------------------
	;Write here the appropriate program part!

	              mov    di, 0                      	; Y - col
	              mov    si, 1                      	; Direction
	              mov    bl, 2
	SetCursor:    
	              cmp    bl, 0
	              jz     End4
	              mov    dx, di
	              mov    dh, 10
	              mov    bh, 0
	              mov    ah, 2
	              int    10h
	              cmp    si, 1
	              jz     CheckRight
	              jnz    CheckLeft
	CheckRight:   
	              inc    di
	              cmp    di, 50
	              jc     Writeout
	              mov    si, -1
	              jmp    Writeout
	CheckLeft:    
	              dec    di
	              cmp    di, 1
	              jnc    Writeout
	              mov    si, 1
	              dec    bl
	              jmp    Writeout

	Writeout:     
	              mov    dx, offset sentence4
	              mov    ah, 09
	              int    21h
	Time:         
	              xor    ah, ah
	              int    1ah                        	; Gets ticks since midnight into DX
	              push   dx                         	; Save old time
				 
	Elapsed:      
	              xor    ah, ah
	              int    1ah                        	; Gets ticks since midnight into DX

	              pop    cx                         	; Get old time
	              push   cx                         	; Save old time

	              sub    dx, cx                     	; Telapsed = Tcurrent - Told

	              cmp    dx, 1                      	; Loop if dx < 1
	              jc     Elapsed
	              pop    cx
	Clear:        
	              mov    ax, 03h                    	; mod the screen to display space in old pos
	              int    10h

	              xor    dx, dx                     	; (using 16 bits register) Clear to 0

	              xor    bh, bh
	              mov    ah, 02h
	              int    10h
	              jmp    SetCursor
	End4:         
	; so far
	; ------------------------------------------------------------------------
	; Waiting for a keystroke
	              xor    ax, ax
	              int    16h
	;===========================================================================

	End_Program:  
	              mov    ax, 3
	              int    10h
	
	              pop    ax
	              mov    ax, 4c00h
	              int    21h

	;strings:
	task1         db     "1. task, Name: $"
	nev           db     "gergely stark$"

	task3         db     "3. task: Operation: $"
	operation     db     "3+2=$"


	task4         db     "4. task: Moving string: $"
	sentence4     db     "Wow moves!$"






Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

