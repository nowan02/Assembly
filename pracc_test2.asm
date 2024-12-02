
;2021 11 29
;==========================================================================
;Name:
;Neptun code:
;Date: 11.29.2021
;
;==========================================================================
Code Segment
                 assume CS:Code, DS:Data, SS:Stack


    Start:       
                 mov    ax, Code
                 mov    DS, AX

                 mov    ax,3
                 int    10h


    ;==========================================================================
    ;1. task:
    ;Draw a full "square" of 11x5 characters in character mode.
    ;Let one of its corners be at the coordinate 5,20. You cannot use string!
    ;Use cycle.
    ;e.g.:
    ;      xxxxxxxxxxx
    ;      xxxxxxxxxxx
    ;      xxxxxxxxxxx
    ;      xxxxxxxxxxx
    ;      xxxxxxxxxxx
    ;
    ; 20 minutes, 0 or 1 point
    ;==========================================================================
                 mov    ah, 02h
                 mov    bh, 0
                 mov    dl,0                                                                     ;DL:X coordinate
                 mov    dh,2                                                                     ;DH:Y coordinate
                 int    10h

                 mov    dx, offset task1
                 mov    ah,9
                 int    21h
	
                 xor    ax, ax
                 xor    bx, bx
                 xor    cx, cx
                 xor    dx, dx
                 xor    di, di
                 xor    si, si

    ;**************************************************************************
    ;Write here the appropriate program part!
                 mov    dl,5                                                                     ;DL:X coordinate
                 mov    dh,20                                                                    ;DH:Y coordinate
                 push   dx
                 jmp    Draw
    Reset:       
                 pop    dx
                 mov    dl, 5
                 inc    dh
                 push   dx
                 cmp    dh, 26
                 jz     End1

    Draw:        
                 pop    dx
                 mov    ah, 02h
                 mov    bh, 0
                 int    10h
                 push   dx
                
                 mov    dl, '#'
                 mov    ah, 02h
                 int    21h

                 pop    dx
                 inc    dl
                 push   dx
                 cmp    dl, 17
                 jz     Reset
                 jmp    Draw

    End1:        

    ;So far
    ;**************************************************************************
                 xor    ax,ax
                 int    16h
    ;==========================================================================
    ;2. task:
    ; In character mode, display the AL value on the screen in hexadecimal form.
    ; AL can be anything from 0 to 255
    ; e.g.:
    ;	- in case of 0 		00
    ;	- in case of 15 	0F
    ;	- in case of 16 	10
    ;	- in case of 255    FF
    ; 20 minutes, 0 or 1 point
    ;==========================================================================
                 mov    ax, 03h
                 int    10h
	
                 mov    dx, offset task2
                 mov    ah,9
                 int    21h

                 mov    dl,10
                 mov    ah,2
                 int    21h
                 mov    dl,13
                 mov    ah,2
                 int    21h                                                                      ;NL+CR
	
                 xor    ax, ax
                 xor    bx, bx
                 xor    cx, cx
                 xor    dx, dx
                 xor    di, di
                 xor    si, si

                 mov    al,241                                                                   ;test value
    ;**************************************************************************
    ;Write here the appropriate program part!
                



    ;So far
    ;**************************************************************************
                 xor    ax,ax
                 int    16h
    ;==========================================================================
    ;3. task:
    ;Calculate the division specified in the string "operation1".
    ;The "/" symbol separating the two digits does not need to be processed!
    ;Display the result and remainder of the division in decimal form!
    ; 20 minutes, 0 or 1 point
    ;==========================================================================
                 mov    ax, 03h
                 int    10h

                 mov    dx, offset task3
                 mov    ah,9
                 int    21h

                 mov    dl,10
                 mov    ah,2
                 int    21h
                 mov    dl,13
                 mov    ah,2
                 int    21h                                                                      ;NL+CR
	
                 xor    ax, ax
                 xor    bx, bx
                 xor    cx, cx
                 xor    dx, dx
                 xor    di, di
                 xor    si, si

    ;**************************************************************************
    ;Write here the appropriate program part!

                 mov    di, offset operation1
                 mov    al, [di]
                 add    di, 2
                 mov    bl, [di]

                 sub    bl, 48
                 sub    al, 48

                 div    bl

                 add    al, 48
                 add    ah, 48

                 mov    bx, ax

                 mov    dl, bl
                 mov    ah, 02h
                 int    21h

                 mov    dl, ','
                 mov    ah, 02h
                 int    21h

                 mov    dl, ' '
                 mov    ah, 02h
                 int    21h

                 mov    dl, bh
                 mov    ah, 02h
                 int    21h

    ;So far
    ;**************************************************************************
                 xor    ax,ax
                 int    16h

    ;==========================================================================
    ;4. task:
    ; Count the words in the following sentence and display the result:
    ;
    ;	"The assembly language shouldn't be confused with the machine code!"
    ;
    ; Assume that there is always 1 space between words !
    ; Use the program's pre-written message (sentence)!
    ; The program should also display the correct value if the sentence is modified.
    ; 20 minutes, 0 or 1 point
    ;==========================================================================
                 mov    ax, 03h
                 int    10h

                 mov    ah,9
                 mov    dx, offset task4
                 int    21h

                 mov    dh, 2
                 mov    dl, 5
                 xor    bx, bx
                 mov    ah, 02
                 int    10h
	
                 mov    ah,9
                 mov    dx, offset sentence
                 int    21h

                 mov    dh, 3
                 mov    dl, 5
                 xor    bx, bx
                 mov    ah, 02
                 int    10h
	
                 mov    ah,9
                 mov    dx, offset task4_1
                 int    21h
	
                 xor    ax, ax
                 xor    bx, bx
                 xor    cx, cx
                 xor    dx, dx
                 xor    di, di
                 xor    si, si

    ;**************************************************************************
    ;Write here the appropriate program part!

                 mov    di, offset sentence
                 mov    dl, 0
                 mov    dh, 0
                 jmp    Lookforspace
    Clearone:    
                 xor    dl, dl
                 jmp    Countten
    Countone:    
                 cmp    dl, 9
                 jz     Clearone
                 inc    dl
                 cmp    al, '$'
                 jz     Write2
                 inc    di
                 jmp    Lookforspace
    Countten:    
                 inc    dh
                 cmp    al, '$'
                 jz     Write2
                 inc    di
                 
    Lookforspace:
                 mov    al, [di]
                 cmp    al, ' '
                 jz     Countone
                 cmp    al, '$'
                 jz     Countone
                 inc    di
                 jmp    Lookforspace
    Write2:      
                 mov    bx, dx

                 mov    dl, bh
                 add    dl, 48
                 mov    ah, 02h
                 int    21h


                 mov    dl, bl
                 add    dl, 48
                 mov    ah, 02h
                 int    21h
    ;Eddig
    ;**************************************************************************

                 xor    ax,ax
                 int    16h

    End_Program: 
                 mov    ax, 4c00h
                 int    21h

    operation1   db     "9/5$"
    sentence     db     "The assembly language shouldn't be confused with the machine code!$"
	
    task1        db     "1st task: Square$"
    task2        db     "2nd task: AL's value in hexa.$"
    task3        db     "3rd task: Perform division$"
    task4        db     "4th task: Number of words in the following sentence:$"
    task4_1      db     "Number of words: $"

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

