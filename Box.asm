// Box.asm  -  K = 52
// Box: starts at row 52, 20 rows tall, 64 pixels (4 words) wide, left edge.
// Row 52 starts at 16384 + 32*52 = 18048.
// Key pressed -> black box; key released -> box cleared.

(MAIN)
    @KBD
    D=M
    @PRESSED
    D;JNE
    @color          // no key: color = 0 (white)
    M=0
    @DRAW
    0;JMP
(PRESSED)
    @color          // key: color = -1 (black)
    M=-1
(DRAW)
    @18048          // address of first word of row 52
    D=A
    @addr
    M=D
    @20             // 20 rows
    D=A
    @rows
    M=D
(ROWLOOP)
    @addr
    D=M
    @ptr            // ptr = start of this row
    M=D
    @4              // 4 words per row
    D=A
    @cols
    M=D
(COLLOOP)
    @color
    D=M
    @ptr
    A=M
    M=D             // RAM[ptr] = color
    @ptr
    M=M+1
    @cols
    M=M-1
    D=M
    @COLLOOP
    D;JGT
    @32             // next row
    D=A
    @addr
    M=D+M
    @rows
    M=M-1
    D=M
    @ROWLOOP
    D;JGT
    @MAIN
    0;JMP
