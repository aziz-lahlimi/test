; 1) Definition d'etiquette        -> 1
; 2) Nom de l'instruction          -> 10
; 3) Operandes des instrutions     -> 20
; 4) Commentaires en fin de ligne  -> 35
; 5) Blocs de commentaires         -> 10
;
;        5
;        2         3              4
;        |         |              |
;============================================================================

         .MODEL    small          ; 
         .STACK    512            ; Taille de la pile

;============================================================================

         .DATA                    ; Vos variables dans cette section
         
                   input       db  0       
		           idx         db  0           
		           car         db  ' --> ' , '$'
		           math1       db  0
		           linefeed    db  13, 10, "$"
		           error_msg   db  'IMPOSSIBLE' , '$'
		 
;============================================================================

         .CODE

listing: MOV       AX, @DATA
         MOV       DS, AX

         ;-------------------------------------------------------------------
         ; Votre code entre les ligne ci-dessous
         ;-------------------------------------------------------------------




while_1: cmp       input, 46		             ;    while(input!='.')
		 je        place                         
                                                 
                                                 

		 mov       AH, 01                        ;    input = getchar();
		 int       33
		 mov       input, AL
		 
		 mov       AH, 09                        ;    printf("--> ");
		 mov       DX, offset car
         int       33		
		 
if_1:    cmp       input, 65                     ;    if (input >= 65 && input <= 90)
         jl        if_2
	     cmp       input, 90 
	     jg        if_2
		 
		 
		 
		 mov       bl, input 
		 sub       bl, 64
		 
		 
		 mov       idx, 0                        ;    for (index = 0; index < input-64; index++)
for_1:	 cmp       idx, bl
		 jge       e_for_1


      


         mov       al, idx
		 add       al, 65
		 
		 mov       ah, 2		                 ;    printf("%c ", 65 + index, " ");
		 mov       dl, al
		 int       33       
		 MOV       dl, " "          
		 int       33 



		 inc       idx			
		 jmp       for_1
e_for_1:
         mov       ah, 09                        ;    new line
         mov       dx, offset linefeed
         int       33

		 jmp       while_1
end_if_1:





place: 

jmp eop

if_2:    cmp       input, 97                      ;     if (input >= 97 && input <= 122)
         jl        end_if_2
	     cmp       input, 122
	     jg        end_if_2
		 
		 
		 
		 mov       bl, input 
		 sub       bl, 96
		 
		
		 
		 
		 mov       idx , 0                       ;    for (index = 0; index < input-96; index++)
for_2:	 cmp       idx, bl
		 jge       e_for_2



         mov       al, idx
		 add       al, 97
		 
		 
		 mov       ah, 2		                 ;     printf("%c ", 97 + index);
		 mov       dl, al
		 int       33
		 MOV       dl, " "         
		 int       33 



		 inc       idx			
		 jmp       for_2
e_for_2:
         mov        ah, 09                        ;    new line
         mov        dx, offset linefeed
         int        33

		 jmp        while_1		 
end_if_2:

 

 


if_3:    cmp      input, 48                       ;    (input >= 48 && input <= 57)
         jl       else_1
	     cmp      input, 57
	     jg       else_1
		 
		 
		 
		 mov      bl, input 
		 sub      bl, 47
		 
		
		 
		 
		 mov      idx, 0                          ;     for (index = 0; index < input-47; index++)
for_3:	 cmp      idx, bl
		 jge      e_for_3


      


         mov      al, idx
		 add      al, 48
		 
		 
		 mov      ah, 2		                      ;     printf("%c ",  index+48);
		 mov      dl, al
		 int      33
		 MOV      dl, " "         
		 int      33 



		 inc      idx			
		 jmp      for_3
e_for_3:
         mov      ah, 09                          ;    new line
         mov      dx, offset linefeed
         int      33
         jmp      while_1
end_if_3:


else_1:
         mov       AH, 09                        ;     printf("IMPOSSIBLE");   
		 mov       DX, offset error_msg
         int       33
		 
         mov       ah, 09                        ;    new line
         mov       dx, offset linefeed
         int       33
         		
        
e_while_1:

jmp while_1
         ;-------------------------------------------------------------------
         ; Fin de votre code
         ;-------------------------------------------------------------------
		
eop:     MOV       AX, 4C00h
         INT       33

         END       listing

;============================================================================