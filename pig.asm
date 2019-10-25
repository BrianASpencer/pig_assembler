; Name: Brian Spencer
; Date: 02/21/19
; Purpose: Allows two players to play the game of pig.

INCLUDE Irvine32.inc

; play a simple guessing game
;  The computer will generate a random number from 1 to 100 inclusive
;  The user will try to guess it in as few guesses as possible

.data
prompt	BYTE	"Roll again? (1 for yes or 0 for no): ",0
prompt2	BYTE	"Roll? (1 for yes or 0 for no): ",0
p1win	BYTE	"P1 Wins!",0
p2win	BYTE	"P2 Wins!",0
passed	BYTE	"You rolled a 1.",0
score1	BYTE	"P1 Score: ",0
score2	BYTE	"     P2 Score: ",0
roll	BYTE	"Roll: ",0
p1score		DWORD	0
p2score		DWORD	0

.code
main	PROC
		mov		ecx,0

startroll:
		mov		eax,0
		mov		edx,OFFSET prompt2				; ask the user to go again or pass
		call	WriteString
		call	ReadInt							; get the input
		call	CrLf
		cmp		eax,0
		jg		roll_dice1
		jz		p1passed


roll_dice1:
; generate a random number from 1 to 6
		mov		eax,0
		call	Randomize						; don't want fixed numbers
		mov		eax,6							; random from 0-5
		call	RandomRange						; generate a random number from 0 to 5
		inc		eax
		mov		edx,OFFSET roll					; roll:
		call	WriteString
		call	WriteInt						; display roll result
		call	CrLf
		mov		ebx,eax							; save for later
		add		p1score,ebx
			
; too big, too small, or correct?
		cmp		ebx,1							; compare guess and answer
		je		oofp1
		je		p1passed							; does roll = 1?
		jg		goodrollp1						; is roll > 1?


oofp1:
		dec		p1score
		jmp		p1passed

p1passed:
		mov		eax,0
		mov		ecx,0
		mov		edx,OFFSET passed				; display message
		call	WriteString
		call	CrLf
		mov		eax,p1score
		mov		edx,OFFSET score1				; display message
		call	WriteString
		call	WriteInt
		mov		p1score,eax
		mov		edx,OFFSET score2				; display message
		call	WriteString
		mov		eax,p2score
		call	WriteInt
		mov		p2score,eax
		call	CrLf
		jmp		roll_dice2

goodrollp1:
		mov		eax,0
		add		p1score, ecx
		mov		ecx,0
		mov		eax,p1score
		mov		edx,OFFSET score1				; display message
		call	WriteString
		call	WriteInt
		mov		p1score,eax
		mov		edx,OFFSET score2				; display message
		call	WriteString
		mov		eax,p2score
		call	WriteInt
		mov		p2score,eax
		call	CrLf

		cmp		p1score,100
		jge		p1wins

		mov		edx,OFFSET prompt				; ask the user to go again or pass
		call	WriteString
		call	ReadInt							; get the input
		call	CrLf
		cmp		eax,0
		jg		roll_dice1
		jz		p1passed





oofp2:
		dec		p2score
		jmp		p2passed


goodrollp2:
		mov		eax,0
		add		p2score, ecx
		mov		ecx,0
		mov		edx,OFFSET score1				; display message
		call	WriteString
		mov		eax,p1score
		call	WriteInt
		mov		p1score,eax
		mov		eax,p2score
		mov		edx,OFFSET score2				; display message
		call	WriteString
		call	WriteInt
		call	CrLf
		mov		p2score,eax

		cmp		p2score,100
		jge		p2wins

		mov		edx,OFFSET prompt				; ask the user to go again or pass
		call	WriteString
		call	ReadInt							; get the input
		call	CrLf
		cmp		eax,0
		jg		roll_dice2
		jz		p2passed

roll_dice2:
; generate a random number from 1 to 6
		mov		eax,0
		call	Randomize						; don't want fixed numbers
		mov		eax,6							; random from 0-5
		call	RandomRange						; generate a random number from 0 to 5
		inc		eax
		mov		edx,OFFSET roll					; roll:
		call	WriteString
		call	WriteInt						; display roll result
		call	CrLf
		mov		ebx,eax							; save for later
		add		p2score,ebx

; too big, too small, or correct?
		cmp		ebx,1							; compare guess and answer
		je		oofp2
		je		p2passed							; does roll = 1?
		jg		goodrollp2						; is roll > 1?

p2passed:
		mov		eax,0
		mov		ecx,0
		mov		edx,OFFSET passed				; display message
		call	WriteString
		call	CrLf
		mov		edx,OFFSET score1				; display message
		call	WriteString
		mov		eax,p1score
		call	WriteInt
		mov		p1score,eax
		mov		eax,p2score
		mov		edx,OFFSET score2				; display message
		call	WriteString
		call	WriteInt
		call	CrLf
		mov		p2score,eax
		jmp		roll_dice1

p1wins:
		mov		edx,OFFSET p1win				; display message
		call	WriteString
		call	CrLf
		call	ecksdee
p2wins:
		mov		edx,OFFSET p2win				; display message
		call	WriteString
		call	CrLf
ecksdee:
		
		exit
main	ENDP
END	main