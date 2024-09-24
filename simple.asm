Code    Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov ax, Code
    mov DS, ax

    ;set cursor
    mov ah, 02
    mov bh, 0
    mov dh, 12
    mov dl, 30
    int 10h

    ;
    mov dl, 2
    mov ah, 02h
    int 21h

    mov dx, offset uzenet
    mov ah, 09
    int 21h

Exit:
    mov ax, 4c00h
    int 21h

uzenet db "This is a message$"

Code    Ends

Data    Segment

Data    Ends

Stack   Segment

Stack   Ends
    End Start
