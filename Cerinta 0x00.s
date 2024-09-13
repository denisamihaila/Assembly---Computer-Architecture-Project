.data
	m: .space 4 	#nr linii
	n: .space 4		#nr coloane
	p: .space 4 	#nr celule vii
	k: .space 4 	#nr evolutii
	a: .space 1600 	#matricea1, extinsa
	b: .space 1600 	#matricea2
	i: .space 4 	#index linie
	j: .space 4 	#index coloana
	index: .space 4 
	lineIndex: .space 4
	columnIndex: .space 4
	formatScanf: .asciz "%ld"
	formatPrintf: .asciz "%ld "
	newLine: .asciz "\n"
	suma: .space 4   #calculez suma vecinilor
.text

construct:   
	
	pushl %ebp  #punem pe stiva ebp vechi
	movl %esp, %ebp #schimbam valoarea lui ebp
	
	movl $0, %ecx   #index=0   
	 
	pushl %ebx
	#zona sigura pt %ebx
	movl 12(%ebp), %ebx
	addl $2, %ebx
	
	pushl %edi
	#zona sigura pt %edi
	movl 16(%ebp), %edi   # edi are adresa lui a
	
	subl $8, %esp   #2 variabile locale pt citire
	
	while:       #while(index<p)
		cmp 8(%ebp), %ecx
		je exit
		
		movl %ebp, %eax
		subl $12, %eax
		
		pusha #il citesc pe i si il pun la -12(%ebp)
		pushl %eax
		pushl $formatScanf
		call scanf
		popl %eax
		popl %eax
		popa
		
		movl %ebp, %eax
		subl $16, %eax
		
		pusha #il citesc pe j si il pun la -16(%ebp)
		pushl %eax
		pushl $formatScanf
		call scanf
		popl %eax
		popl %eax
		popa
	
		incl -12(%ebp)
		incl -16(%ebp)
		
		#trebuie ca a[i][j]=1; indexul este i*(n+2)+j
		
		movl -12(%ebp), %eax
		mull %ebx
		addl -16(%ebp), %eax
		movl $1, (%edi, %eax, 4)
		
		inc %ecx
		jmp while
	
	exit:
		popl %eax #variabila locala
		popl %eax #variabila locala
		popl %edi
		popl %ebx
		popl %ebp
		ret
	
	

.global main

main:

	pushl $m                #citire nr linii
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $n                #citire nr coloane
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

	pushl $p                #citire nr celule vii
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx

						#vom construi matricea a
						
et_construire_a:

	push $a
	push n
	push p
	call construct
	popl %ebx
	popl %ebx
	popl %ebx

et_k:
	
	pushl $k					#citire nr evolutii
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	lea a, %edi
	lea b, %esi
	
	movl $0, index
	
et_evolutie:

	movl index, %ecx      #while(index<k); fac acelasi lucru de k ori
	cmp %ecx, k
	je et_afisare_matrice
	
	movl $1, lineIndex
	
	for_lines1:
	
		movl lineIndex, %ecx
		movl m, %edx
		addl $1, %edx
		cmp %ecx, %edx
		je mutare    #am terminat o evolutie
		
		movl $1, columnIndex
		
			for_columns1:
			
				movl columnIndex, %ecx
				movl n, %edx
				addl $1, %edx
				cmp %ecx, %edx
				je cont1          
				
				movl lineIndex, %eax       #indexul este lineIndex*(n+2)+columnIndex
				movl $0, %edx
				addl $2, n
				mull n
				subl $2, n
				addl columnIndex, %eax     #in eax am indexul termenului curent
				
			movl $0, suma	#calculez suma tuturor vecinilor
				
			v1: #stanga
			subl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v2: #dreapta
			addl $2, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v3: #dreapta sus
			subl n, %eax
			subl $2, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v4: #sus
			subl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v5: #stanga sus
			subl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v6: #stanga jos
			addl n, %eax
			addl n, %eax
			addl $4, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v7: #jos
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			v8: #dreapta jos
			addl $1, %eax
			movl (%edi, %eax, 4), %ebx
			addl %ebx, suma
			
			subl n, %eax    #eax a redevenit indexul termenului curent
			subl $3, %eax
			
			
			
			movl 0(%edi, %eax, 4), %ebx
			cmp $1, %ebx
			je e_vie
			
			movl suma, %ebx
			cmp $3, %ebx
			je traieste
			jmp moare
			
			e_vie:
			movl suma, %ebx
			cmp $2, %ebx
			jl moare
			movl suma, %ebx
			cmp $3, %ebx
			jg moare
			
			jmp traieste
			
			traieste:
			movl $1, (%esi, %eax, 4)
			jmp cont2    
			
			moare:
			movl $0, (%esi, %eax, 4)
			
			cont2: 
			
				incl columnIndex
				jmp for_columns1
					
	cont1:
	
		incl lineIndex
		jmp for_lines1
	
	#trebuie sa copiez matricea b(%esi) in a(%edi) 
	
	mutare:
	
		movl $1, lineIndex
		
		for_lines2:
		
			movl lineIndex, %ecx
			movl m, %edx
			addl $1, %edx
			cmp %ecx, %edx
			je urm_evolutie   #am terminat de copiat matricea. ma intorc la urm evolutie
			
			movl $1, columnIndex
			
			for_columns2:
			
				movl columnIndex, %ecx
				movl n, %edx
				addl $1, %edx
				cmp %ecx, %edx    #s-a terminat linia
				je cont3
				
				movl lineIndex, %eax       #indexul este lineIndex*(n+2)+columnIndex
				movl $0, %edx
				addl $2, n
				mull n
				subl $2, n
				addl columnIndex, %eax		#in eax am indexl termenului curent
				
				movl (%esi, %eax, 4), %ebx
				movl %ebx, (%edi, %eax, 4)
				
				incl columnIndex
				jmp for_columns2
				
				cont3:
				incl lineIndex
				jmp for_lines2
		
	urm_evolutie: 
		incl index
		jmp et_evolutie
		
et_afisare_matrice:
	
	movl $1, lineIndex
	
	for_lines:
	
		movl lineIndex, %ecx
		movl m, %edx
		addl $1, %edx
		cmp %ecx, %edx
		je et_exit
		
		movl $1, columnIndex
		
		for_columns:
		
			movl columnIndex, %ecx
			movl n, %edx
			addl $1, %edx
			cmp %ecx, %edx
			je cont
			
			movl lineIndex, %eax       #indexul este lineIndex*(n+2)+columnIndex
			movl $0, %edx
			addl $2, n
			mull n
			subl $2, n
			addl columnIndex, %eax
			
			lea a, %edi
			movl (%edi, %eax, 4), %ebx
			
			pushl %ebx
			pushl $formatPrintf
			call printf
			popl %ebx
			popl %ebx
			
			pushl $0
			call fflush
			popl %ebx
			
			incl columnIndex
			jmp for_columns
			
		cont:
			
			movl $4, %eax
			movl $1, %ebx
			movl $newLine, %ecx
			movl $2, %edx
			int $0x80
			
			incl lineIndex
			jmp for_lines
		

et_exit:
	mov $1, %eax
	xor %ebx, %ebx
	int $0x80
