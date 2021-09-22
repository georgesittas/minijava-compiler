@.Factorial_vtable = global [0 x i8*] []
@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i32)* @Fac.ComputeFac to i8*)]


declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
    %_str = bitcast [4 x i8]* @_cint to i8*
    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
    ret void
}

define void @throw_oob() {
    %_str = bitcast [15 x i8]* @_cOOB to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() {
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Fac_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; Fac.ComputeFac : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)
	
	ret i32 0
}

define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%num_aux = alloca i32
	
	%_3 = load i32, i32* %num
	%_4 = icmp slt i32 %_3, 1
	br i1 %_4, label %if0, label %if1

if0:
		store i32 1, i32* %num_aux
		
		br label %if2

if1:

		%_5 = load i32, i32* %num
		; Fac.ComputeFac : 0
		%_6 = bitcast i8* %this to i8***
		%_7 = load i8**, i8*** %_6
		%_8 = getelementptr i8*, i8** %_7, i32 0
		%_9 = load i8*, i8** %_8
		%_10 = bitcast i8* %_9 to i32 (i8*,i32)*
		%_12 = load i32, i32* %num
		%_13 = sub i32 %_12, 1
		%_11 = call i32 %_10(i8* %this, i32 %_13)
		%_14 = mul i32 %_5, %_11
		store i32 %_14, i32* %num_aux
		
		br label %if2

if2:
	
	%_15 = load i32, i32* %num_aux
	ret i32 %_15
}
