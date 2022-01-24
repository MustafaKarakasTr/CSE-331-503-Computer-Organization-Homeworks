.data
	#fileName: .asciiz "C:/Users/musta/OneDrive/Masaüstü/OrgOdev/arrays.txt"
	#
	toWrite:	 .asciiz "123"
	intToWriteFile: .asciiz "123" # max int has three digit, because every int is 1 byte
	fileName: .asciiz "arrays.txt"
	outputFile: .asciiz "output.txt"
	
	
	
	numberOfArrays: .byte 7
	maxSizeOfArrays: .byte 10
	currentArray: .space 10 # readed array will be stored here
	allArrays: .space 200 # there is 60 element max, I will put -1 to end of every array
	newLineChar: .asciiz "\n"
	seperator: .asciiz "-"
	arr: .space 10 # max arraySize is 10
	space: .asciiz ","
	size: .space 1
	temp: .space 1
	store: .space 16
	arraysIndex: .byte 0
	
	#----------
	lengths: .space 10
	newLine: .asciiz "\n"
	sizeOfSequence: .byte 1
	found: .asciiz "\n"
	sizeString: .asciiz "size= "
	fileWords: .space 250
	newLineWindows: .asciiz "\r\n"
	sizeDigitString: .asciiz "0"
	tenString: .asciiz "10"
	
.text

main:
	#addi $a1,$zero,0
	#lb	$a2,maxSizeOfArrays
	#jal allocateSpaceToReadNumbers
	jal Read
	#fileWords holds all of the arrays
	jal OpenFileToWrite
	jal convertIntegerArrays
	ArrayProcessing:
	addi $s4,$zero,0 # read index start from zero
	programLoop:
		jal saveArrayToProcess
		j giveOutputForCurrentArray

		IsItEndOfFile:
			lb $t0,allArrays($s4) # if  reading index ($s4) holds the ýndex of -1, there is/are still array(s) to process 
					      # if it holds index of zero, then there is no more array to process, writing them to file process should start
			beq $t0,$zero,Exit
			# there is/arr array(s) to process
			addi $s4,$s4,1 # look at next array's head
			j programLoop  # continue from other array
		
	

	# outputs will be written to the file
	
	j Exit

#pre:s4 holds the index of element to be readed in allArrays
#post: arr holds the array to be processed. Additionally size value is stored, size byte will hold size of the readed array
saveArrayToProcess:
	addi $t0,$zero,0 # start writing from 0. index to arr
	addi $t2,$zero,-1 # end of array flag
	saveLoop:
		lb $t1,allArrays($s4)
		beq $t1,$zero,saveSizeAndGoBack # last array is readed
		beq $t1,$t2,saveSizeAndGoBack   # array is readed there are other arrays
		
		
		sb $t1,arr($t0) # store element of array which is being ready for processed
		addi $t0,$t0,1 #increment writing index
		addi $s4,$s4,1 # increment reading index
		j saveLoop
	# if loop is about to be broken save the size	
	saveSizeAndGoBack:
	#addi $v1,$zero,$t0 # v1 will hold size ýf the readed arra
	sb $t0,size($zero) # store size of readed array	
	jr	$ra
#s1 holds the rest of the number, a0 will be added as a last readed digit
convertIntegerArrays:
	addi $s0,$zero,0 # s0 will hold index of reading pointer
	addi $s1,$zero,0 # s1 will hold index of writing pointer
	readArray:# at the head of new array
		lb $t0,fileWords($s0) # readed element
		bne $t0,$zero,continue # end of file has not come
		jr $ra # go back
		continue:
			addi $a0,$s0,0 # a0 will go to the procedure 
			jal takeInteger # v1 will hold the readed integer 
			addi $s0,$a0,0  # a0 may be updated give back index value
			sb $v1,allArrays($s1) # store the readed integer
			jal incrementWritingPointer	# increment writing pointer
			addi $a0,$s0,0 # a0 will be argument for takeCommaOrNewLineOrEndOfFile
			# v1 will hold 1 if the readed element is comma,
			# 	       2 if the readed element is newLine,
			#	       0 if the readed element is endOfFile.
			jal takeCommaOrNewLineOrEndOfFile
			addi $t0,$zero,0
			addi $t1,$zero,1
			addi $t2,$zero,2
			#beq $v1,$t0,goBack # all elements are readed and saved
			beq $v1,$t0,writeTakenIntegerArrays
			beq $v1,$t1,justIncrementIndex
			beq $v1, $t2,endOfArrayFlag
			
			
			
			endOfArrayFlag:
				addi $t0,$zero,-1
				sb $t0,allArrays($s1) # end of array flag is -1, because all array elements are positive
				addi $s0,$s0,1 # increment read index because at the end of line there are 2 character which indicate that end of line has come
				jal incrementWritingPointer
			justIncrementIndex:
				addi $s0,$s0,1 #increment reading index
			j readArray
writeTakenIntegerArrays:
addi $t0,$zero,0 # convertion is done.
sb $t0,allArrays($s1)
#t0=0

printIntegerArr:
	addi	$v0,$zero,1
	lb	$a0,allArrays($t0)
	beq	$a0,$zero,ArrayProcessing
	#syscall
	#addi $v0,$zero,4
	#lb   $a0
	#addi $v0,$zero, 4 
	#la $a0, newLineChar
	#syscall
	addi 	$t0,$t0,1
	j 	printIntegerArr

#pre:
	#a0 will hold index to read
#post:
# v1 will hold 1 if the readed element is comma(ASCII:44),
# 	       2 if the readed element is newLine(ASCII: 13 and 10), in txt at the end of each line there are values which have 13 and 10 as a ascii value 
#	       0 if the readed element is endOfFile(ASCII: 0).

takeCommaOrNewLineOrEndOfFile:
	lb 	$t0,fileWords($a0)
	addi 	$t1,$zero, 44
	addi 	$t2,$zero, 13
	#addi 	$t3,$zero, 10
	addi 	$t4,$zero, 0
	
	
	beq 	$t0,$t1,commaIsReaded
	beq	$t0,$t2,newLineisReaded
	beq	$t0,$t4,endOfFileisReaded
	
	commaIsReaded:
		addi 	$v1,$zero,1
		jr 	$ra
	newLineisReaded:
		lb 	$t0,fileWords($a0) # read 10, it is also garbage
		addi 	$v1,$zero,2
		jr 	$ra
	endOfFileisReaded:
		addi 	$v1,$zero,0
		jr 	$ra


# pre : a0 holds the index to read fileWords
# post:v1 will hold the readed integer
takeInteger:
	addi	$v1,$zero,0
	addi	$t1,$zero,57 # integer nine's ascii value is 57
	addi 	$t2,$zero,48 # integer zero's ascii value is 48
	readDigit:
		lb 	$t0,fileWords($a0)
		bgt	$t0,$t1,goBack # it is greater than digit nine so it is not a digit
		blt 	$t0,$t2,goBack  # it is less than digit zeroine so it is not a digit
		
		# it is digit
		#increment read index
		addi $a0,$a0,1
		# atoi 
		atoi:
			addi $t0,$t0,-48 # 0's ascii value is 48,48 - 48 = 0, character to digit
			addi $t3,$zero,10
			mult $v1,$t3 # we will add new digit so multiply by 10
			mflo $v1	     #take new value
			add $v1,$v1,$t0	#add new digit
			j readDigit
			
		
	jr $ra		
goBack:
	jr $ra
incrementWritingPointer:
	addi $s1,$s1,1
	jr $ra
CharToInt:
	addi $a0,$a0,-48
	#addi $t9,$zero,10
		
	#mult $s1,$t9 # mult rest of the number by 1
	#mflo $t8
	#add $s1,$a0,$t8 #add new digit to the number
	jr $ra
saveNumbersToAllArrays:
		
	jr $ra
allocateSpaceToReadNumbers:
	#calculate needed space
	lb	$t0,maxSizeOfArrays
	lb	$t1,numberOfArrays
	mult $t0,$t1 # it will be max 60
	mflo $t2

	
	
	jr $ra
Read:
	
	li 	 $v0,	13	 # open file syscall
	la	 $a0, fileName   # get the file name
	li	 $a1,	0	 # read file
	syscall
	move 	 $s0,$v0		#save the file descriptor
	#read the file
	li 	$v0,14		#read_file syscall code = 14
	move	$a0,$s0		# file decriptor
	la	$a1, fileWords	#the buffer that holds the string of the whole file
	la 	$a2, 1024	#buffer length
	syscall
	
	# close the file
	li $v0, 16
	move $a0,$s0
	syscall
	jr $ra
	
Exit:
	li 	$v0,16		#close file syscall code = 16
	move 	$a0,$s6		#file descriptor to close
	syscall

	li $v0, 10 #exit
	syscall
	
	
#############################################
giveOutputForCurrentArray:
#la $a1, arr
lb $s2, size # load size of array
addi $a0,$zero,0 # a0 will be used as an index holder to fill all lengths array with ones
addi $a1,$zero,1 # a1 will be 1 to place it every position of lengths
jal fill_lengths_with_one # initially all values of lenghts are 1

li $a3, 1   # outer loop's start index is 1
li $a0, 0   # inner loop's start index is 0
addi $v1,$zero,1 # v1 will hold the size of the longest sequence
j outerLoop

fill_lengths_with_one:
	beq $a0,$s2,goBack # check border
	sb $a1,lengths($a0) # update lengths[a0]
	addi $a0,$a0,1 # increase index
	j fill_lengths_with_one # loop

outerLoop:

#check if the end of array is reached
addi $a0,$v1,0 # load size of the longest sequence to a0 if the findSequence call works it will need it
beq $a3, $s2, findSequence

#take byte from array
lb $s0, arr($a3)

addi $a0,$zero,0 #inner loop always starts from zero
addi $s1, $a3, 0 # save index
#addi $s2, $a2,0 # save size of Array
jal innerLoop #enter the innerLoop
lb $a3,lengths($s1) # take current length, it may be changed in inner loop, a3 will hold current length temporarily, index value saved to the s1 anyways

# if currentLength <= maxSizeEverFound jumpOverDecleration
blt $a3,$v1,doNotUpdateMaxSize 
beq $a3,$v1,doNotUpdateMaxSize
#update size of the longest sequence
add $v1,$zero,$a3

doNotUpdateMaxSize:
#blt 
#if(lengths[i]>sizeOfFoundSequence)
            #sizeOfFoundSequence = lengths[i];

#addi $a2,s2,0

addi $a3,$s1,0
#increase the index, because of the array consist of bytes, we added 1
addi $a3, $a3, 1



# call itself
j outerLoop

#s1 = outer loop's index , s3 = inner Loop's index
findLengths:
	lb $t9, arr($s1) # outer loops value is in $t9
	lb $t8, arr($s3) # inner loops value is in $ t8
	slt $t7, $t8, $t9 # t7 = nums[innerLoopsIndex]<nums[outerLoopsIndex]
	
	#slt #nums[j]<nums[i]
	jr $ra

innerLoop:
addi $t0,$t0,10
ble $t0,$s1,Exit
beq $s1, $a0, goBack # if the outer loops element is reached dont go any further, a0 holds the ýndex of inner loop, s1 holds index of current element of outer loop
lb $t0, arr($a0) #take the inner loop's element
addi $s3 , $a0,0 # save the inner loops index, s3 was not used before no need to save it
#jal checkValuesChangeLengthsAccordingly # t0 holds nums[j] s0 holds length[i]
#s1 = outer loop's index , s3 = inner Loop's index
#jal findLengths

######################
#increment lengths
	lb $t9, arr($s1) # outer loops value is in $t9
	lb $t8, arr($s3) # inner loops value is in $ t8
	addi $t2,$zero,0 # t2 = 0
	
	slt $t7, $t8,$t9 # t7 = t8 < t9
	beq $t7,$t2,jumpOverOtherComparisons # jump over the next Lines
	lb $t9, lengths($s1) # length value which is in the index of outer loop
	lb $t8, lengths($s3) ## length value which is in the index of inner loop
	
	addi $t2,$zero,1
	slt $t7,$t9,$t8 # t7 =len[outerLoopindex] < len[innerLoopindex]
	beq $t7,$t2,incrementLengthinOuterLoopsIndex
	# last comparison
	bne $t8,$t9,jumpOverOtherComparisons # len[inner]!=len[outer]
	#if(nums[i]>nums[j] && (lengths[i]<lengths[j] || lengths[i]==lengths[j]))
        #        lengths[i] = lengths[j]+1;
        
	incrementLengthinOuterLoopsIndex:
	addi $t6,$t8,1 # t6 = lengths[inner] +1 
	sb $t6,lengths($s1) # lengths[outer] = t6
	
	jumpOverOtherComparisons:
	
######################

addi $a0,$s3,0 # give back the inner loop's index
addi $a0, $a0, 1 #increase index

#li $v0, 4
#la $a0, innerLoopString
#syscall
j innerLoop # repeat the inner loop
#jr $ra # jumo back to printArr 

findSequence:
	sb $a0,sizeOfSequence # store size of sequence
	li $v0, 9 #allocate
	# a0 holds the size of the longest sequence
	#addi $a0,$a0,0
	syscall 
	addi $a1,$v0,0 # save pointer to allocated array
	#sw $v0,addressOfLongestSequence
	
	#a1 holds the pointer, a0 holds the size of allocated array
	lb $a2, size # load size of given array
	#addi $t1,$t0,-1 t1 = size-1
	jal takeLongestSequenceLoop
		
		
		
	j IsItEndOfFile
	
#a1 holds the pointer, a0 holds the size of allocated array
#a2 holds the size of given array
takeLongestSequenceLoop:
	addi $a2,$a2,-1 # a2 = --size
	addi $t0,$zero,0
	blt $a2,$zero,printLongestSequence
	#take length of index
	lb $t1,lengths($a2)
	bne $t1,$a0,Else
	addi $a0,$a0,-1 # decrease allocated array's index by 1
	lb $t2,arr($a2)
	add $t3,$a0,$a1
	sb $t2,($t3)  # store to heap
	
	
	#addi $v0,$zero,4
	#la $a0,newLine
	#syscall
	#sb $t2,$a0($a1)
	#sb $t2,addressOfLongestSequence($a0)
	Else:
	
	j takeLongestSequenceLoop
# $a1 will be written but first it should be converted to char
# $a0 writing index
storeToWrite:
	addi $a1,$a1,48
	sb $a1,toWrite($a0)
	
	jr $ra

# $s7 holds the int to write to file
# will be used to hold digit
# s5,t2,t3,t4 can be used

writeIntToFile:

		#clear old int
	storeValues:
		addi $t2,$zero,0
		sw $v0,store($t2)
		addi $t2,$t2,4
		sw $a0,store($t2)
		addi $t2,$t2,4
		sw $a1,store($t2)
		addi $t2,$t2,4
		sw $a2,store($t2)
	
	
	
	#li $v0,1
	#addi $a0,$s7,0
	#syscall
	#clear old int
	addi $a0,$zero,0
	addi $t2,$zero,0
	sb $a0,toWrite($t2)
	#addi $a0,$zero,0
	addi $t2,$t2,1
	sb $a0,toWrite($t2)
	#addi $a0,$zero,0
	addi $t2,$t2,1
	sb $a0,toWrite($t2)
	
	addi $a2,$zero,1
	addi $a0,$zero,0 # a0 will hold the writing index
	addi $a1,$zero,0
	takeHundredsDigit:
		addi $t2,$zero,100
		blt $s7,$t2,takeTensDigit
		#greater than 100
		addi $a2,$a2,1
		div $s7,$t2
		mflo $a1 # $a1 will be written but first it should be converted to char
		mfhi $s7 # remainder will be processed in the future
		#jal storeToWrite
		addi $a1,$a1,48
		sb $a1,toWrite($a0)
		addi $a0,$a0,1
		
	takeTensDigit:
		addi $t2,$zero,10
		bne $a1,$zero,TensDigitShouldBeTaken
		blt $s7,$t2,takeOnesDigit
		TensDigitShouldBeTaken:
		div $s7,$t2
		mflo $a1
		mfhi $s7
		addi $a1,$a1,48
		sb $a1,toWrite($a0)
		addi $a0,$a0,1
		#greater than 10
		addi $a2,$a2,1
		#
	#addi $a2,$zero,55
	#sb $a2,toWrite($zero)
	
	takeOnesDigit:
	addi $s7,$s7,48
	sb $s7,toWrite($a0)
		#addi $a0,$a0,1
	
	
	
	
	li $v0,15
	move $a0,$s6
	la $a1,toWrite
	#a2 holds the number of digits
	syscall
	
	
	#lb $v0,sizeOfSequence
	#addi $v0,$v0,-1
	li $v0,15
	move $a0,$s6
	la $a1,space
	li $a2,1
	syscall
	
	lb $v0,sizeOfSequence
	addi $v0,$v0,-1
	bne $v0,$t0,loadValues # t0 holds the index, if sizeOfSequence -1 is equal to it, it is last element, new line is neeeded 
	
	li $v0,15
	move $a0,$s6
	la $a1,sizeString
	li $a2,6
	syscall
	
	addi $a2,$zero,10
	li $v0,15
	move $a0,$s6
	lb $a1,sizeOfSequence
	
	bne $a1,$a2,sizeIsNotTen
	#size is ten
	la $a1,tenString
	li $a2,2 # two character
	j callSyscall # ten will be printed
	
	sizeIsNotTen: # size has 1 digit
	addi $a1,$a1,48
	sb $a1,sizeDigitString($zero)
	la $a1,sizeDigitString
	#addi $a1,$a1,48
	li $a2,1
	callSyscall:
	syscall
	
	
	li $v0,15
	move $a0,$s6
	la $a1,newLineWindows
	li $a2,2
	syscall
	
	loadValues:
		addi $t2,$zero,0
		lw $v0,store($t2)
		addi $t2,$t2,4
		lw $a0,store($t2)
		addi $t2,$t2,4
		lw $a1,store($t2)
		addi $t2,$t2,4
		lw $a2,store($t2)
		j doNotWriteToFile
#a1 holds the pointer to the allocated array, sizeOfSequence is in the memory
printLongestSequence:
	#WriteToFILE
	
	li $v0, 4
	la $a0, found
	syscall
	addi $t0,$zero,0 # index starts from 0
	lb $t1,sizeOfSequence # t1 will hold size of allocated array
	loopToPrintArr:
		beq $t0,$t1,goBack
		addi $v0,$zero,1
		
		add $t2,$t0,$a1
		lb $a0,($t2) #write to consol
		syscall
		# do not use t0,t1
		addi $s7,$a0,0 #write to file
		#beq $s7,$zero,doNotWriteToFile
		#t1 holds the index check if it is the last, if it is write size 
		j writeIntToFile 
		
		doNotWriteToFile:

		
		li $v0, 4
		la $a0, space
		syscall
		
		addi $t0,$t0,1
		j loopToPrintArr


OpenFileToWrite:
	li 	 $v0,	13	 # open file syscall
	la	 $a0, outputFile   # get the file name
	li	 $a1,	1	 # file flag = write(1)
	syscall
	move 	 $s6,$v0		#save the file descriptor	
	jr $ra
