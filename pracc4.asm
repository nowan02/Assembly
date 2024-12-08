;==========================================================================
;Name:
;Neptun code:
;Date: 28.11.2022
;
;==========================================================================
Code Segment
                   assume CS:Code, DS:Data, SS:Stack
	
    Start:         

                   mov    ax, Code
                   mov    DS, ax

    Task_1:        
    ;==========================================================================
    ;1. task:
    ; Add the sum of the digits in the string 'gps_str' and display it to decimal
    ;(max. value 99)!
    ; Manage numbers separately for each character (0 ... 9)
    ; Sample string:
    ; "GM,205496,A,4916,45,N,123.12,W,054,19104,020,E$"
    ; That is, 2 + 0 + 5 + 4 ... etc.
    ;**************************************************************************

                   mov    ax, 03h
                   int    10h

                   mov    ah,9
                   mov    dx, offset task1
                   int    21h

                   xor    ax,ax
                   int    16h
	
                   xor    ax, ax
                   xor    bx, bx
                   xor    cx, cx
                   xor    dx, dx
                   xor    di, di
                   xor    si, si

    ;**************************************************************************
    ;Write here the appropriate program part, using the code found here!

                   mov    si, 0

                   mov    di, offset gps_str
    Checkfornums:  
                   mov    al, [di]
                   cmp    al, '$'
                   jz     Exit1
                   cmp    al, '0'
                   jc     Skip
                   cmp    al, ':'
                   jnc    Skip
                   sub    al, 48d
                   xor    ah, ah
                   add    si, ax
    Skip:          
                   inc    di
                   jmp    Checkfornums
    Exit1:         
                   cmp    si, 99
                   jnc    Exit1

                   mov    ax, si
                   mov    bl, 10d
                   div    bl
                 
                   mov    bx, ax

                   mov    dl, bl
                   add    dl, 48d
                   mov    ah, 02h
                   int    21h

                   mov    dl, bh
                   add    dl, 48d
                   mov    ah, 02h
                   int    21h


    ;So far
    ;==========================================================================

                   xor    ax,ax
                   int    16h
                   mov    ax, 03h
                   int    10h
	
    Task_2:        
    ;===========================================================================
    ; 2nd task:
    ; In graphics mode, draw a solid square with the same colour.
    ; Let the starting coordinate the (50,50) and let the length of the sides of the
    ; square 40 pixels
    ; Press ESC to advance to the next task
    ; (no need to react when you press another button)
    ;===========================================================================
	
                   mov    ah,9
                   mov    dx, offset task2
                   int    21h

                   xor    ax,ax
                   int    16h
	
    ;VGA mode
                   mov    ax, 13h
                   int    10h
                   mov    ax, 0a000h
                   mov    es, ax
	
    ; --------------------------------------------------------------------------
    ; Write here the appropriate program part, using the code found here!

                   mov    dl, 50                                               ; X
                   mov    dh, 50                                               ; Y
                   push   dx

                   mov    cx, 40
                   mov    si, 40
    ; Pixel = Y * 320 + X
    Draw:          
                   pop    dx
                   xor    ah, ah
                   mov    al, dh
                   push   dx
                   mov    bx, 320
                   mul    bx ; AX = AL * (BX)
                   pop    dx
                   push   dx
                   xor    dh, dh
                   add    ax, dx
    Pixel:         
                   mov    di, ax
                   mov    al, 40
                   mov    es:[di], al
    
    Increase:      
                   pop    dx
                   inc    dh
                   push   dx
                   loop   Draw

                   pop    dx
                   inc    dl ; X++
                   mov    dh, 50 ; Y = 50
                   push   dx

                   dec    si
                   cmp    si, 0
                   jz     End2
                   mov    cx, 40
                   jmp    Draw
    End2:          
    ; So far
    ; --------------------------------------------------------------------------
    ; Waiting for a keystroke
    ; RESTORE VGA MODE
                   xor    ax,ax
                   int    16h

                   mov    ax, 03h
                   int    10h

                   jmp    Task_4

    Task_3:        
    ;===========================================================================
    ; 3rd task:
    ; In character mode, display the SI:DI value in binary format
    ; in the middle of the screen (12th row)
    ;===========================================================================
                   mov    ax, 03h
                   int    10h
	
                   mov    ah,9
                   mov    dx, offset task3
                   int    21h
                   xor    ax,ax
                   int    16h


                   xor    ax, ax
                   xor    bx, bx
                   xor    cx, cx
                   xor    dx, dx
                   xor    di, di
                   xor    si, si
	
                   mov    si, 684
                   mov    di, 4
   
    ; --------------------------------------------------------------------------
    ; Write here the appropriate program part, using the code found here!
    ; 4684
                   mov    ax, 1000
                   mul    di
                   add    si, ax
    
                   mov    ah, 02
                   mov    bh, 0
                   mov    dh, 12
                   mov    dl, 16
                   int    10h

    CalculateDigit:
                   cmp    ax, 1
                   jz     End3
                   mov    bx, 2
                   mov    ax, si
                   div    bx
                   mov    si, ax
                   cmp    dx, 1
                   jz     Writeone
                   jnz    Writezero
    
    Writeone:      
                   xor    ax, ax
                   mov    dl, '1'
                   mov    ah, 02h
                   int    21h
                   jmp    CalculateDigit

    Writezero:     
                   xor    ax, ax
                   mov    dl, '0'
                   mov    ah, 02h
                   int    21h
                   jmp    CalculateDigit

    ; 4684 / 2 = 2342 0
    ;            1171 0
    ;            585  1
    ;            292  1
    ;            146  0
    ;            73   0
    ;            36   1
    ;            18   0
    ;            9    0
    ;            4    1
    ;            2    0
    ;            1    0
    ;                 1

    End3:          
    ; So far
    ; --------------------------------------------------------------------------
    ; Waiting for a keystroke
                   xor    ax, ax
                   int    16h
	
    Task_4:        
    ;-------------------------------------------------------------------------
    ; 4. task:
    ; Display the sentence4 string at the 20th row!
    ; The string shall move from left side to right side on tbe screen,
    ; and back, once.
    ;-------------------------------------------------------------------------

                   mov    ax, 03h
                   int    10h

                   mov    dx, offset task4
                   mov    ah, 09h
                   int    21h

                   xor    ax,ax
                   int    16h

                   xor    ax, ax
                   xor    bx, bx
                   xor    cx, cx
                   xor    dx, dx
                   xor    di, di
                   xor    si, si

    ;-------------------------------------------------------------------------
    ; Write here the appropriate program part, using the code found here!
                   mov    si, 1
                   mov    dh, 20                                               ;row
                   mov    dl, 0
                   push   dx
                   jmp    SetCursor1
    SetDir:        
                   dec    si                                                   ; Itt az irány meghatározására kell

    Time:          
                   mov    ax, 0                                                ; GEt régi idő
                   int    1ah
                   push   dx

    Delay:         
                   mov    ax, 0                                                
                   int    1ah

                   mov    cx, dx
                   pop    cx
                   push   cx
                   sub    dx, cx
                   cmp    dx, 1
                   jc     Delay
                   pop    cx

    Write1:        
                   mov    dx, offset sentence4
                   mov    ah, 09h
                   int    21h

    SetCursor1:    
                   mov    ah, 02
                   mov    bh, 0
                   pop    dx
                   push   dx
                   int    10h
                   cmp    si, 1
                   jz     MoveRight
                   jmp    MoveLeft
    MoveRight:     
                   pop    dx
                   inc    dl
                   push   dx
                   cmp    dl, 60
                   jnc    SetDir
                   jmp    Time
    MoveLeft:      
                   pop    dx
                   dec    dl
                   push   dx
                   cmp    dl, 1
                   jz     End4
                   jmp    Time
    Reset:         
                   mov    ax, 03h
                   int    10h

                   xor    dx, dx
                   xor    bh, bh
                   
                   mov    ah, 02h
                   int    10h
                   jmp    Time
    End4:          
    ;So far
    ;==========================================================================
    ;Waiting for a keystroke
                   xor    ax,ax
                   int    16h
	
    End_Program:   
                   mov    ax, 3
                   int    10h
	
                   pop    ax
                   mov    ax, 4c00h
                   int    21h

    ;strings:
    task1          db     "First task, : add the numbers in string:$"
    gps_str        db     "GM,205496,A,4916,45,N,123.12,W,054,19104,020,E$"

    task2          db     "2nd task: Draw in VGA mode $"

    task3          db     "3rd task: SI:DI in binary format $"


    task4          db     "4th task: Moving string: $"
    sentence4      db     " Ho-Ho-Ho-HOOOO! $"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

