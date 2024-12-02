
Code Segment
	            assume CS:Code, DS:Data, SS:Stack

	Start:      
	            mov    ax, Code
	            mov    DS, AX

	            mov    di, offset Result
	            mov    ax, Multip
	            mov    [di], ax                  	; First element

	            mov    cx, 2500                  	; 2500 cycle
	            mov    si, 3                     	; denominator of the second element of the sequence?

	Count:                                       	; Sequence element
	            mov    ax, Multip
	            xor    dx, dx
	            div    si
	            sub    [di], ax
	            add    si, 2

	            mov    ax, Multip
	            xor    dx, dx
	            div    si
	            add    [di], ax
	            add    si, 2

	            loop   Count

	            mov    ax, [di]
	            mov    cl, 2
	            shl    ax, cl

	            xor    dx, dx
	            mov    bx, Multip
	            div    bx
	            push   dx

	            call   Display

	            mov    al, "."
	            sub    al, 48

	            call   Display

	            pop    ax
	            xor    dx, dx
	            mov    bx, 1000
	            div    bx
	            push   dx

	            call   Display

	            pop    ax
	            xor    dx, dx
	            mov    bx, 100
	            div    bx
	            push   dx

	            call   Display

	            pop    ax
	            xor    dx, dx
	            mov    bx, 10
	            div    bx
	            push   dx

	            call   Display

	            pop    ax

	            call   Display
	End_program:
	            mov    ax, 4c00h
	            int    21h
	Display:    
	            mov    dl, al
	            add    dl, 48
	            mov    ah, 02h
	            int    21h
	            ret
	Result:     
	            db     "xx"
	Multip      =      10000d

Code Ends

Data Segment

Data Ends

Stack Segment

Stack Ends
	End	Start

