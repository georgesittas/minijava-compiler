@.MoreThan4_vtable = global [0 x i8*] []
@.MT4_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*,i32, i32, i32, i32, i32, i32)* @MT4.Start to i8*), i8* bitcast (i32 (i8*,i32, i32, i32, i32, i32, i32)* @MT4.Change to i8*)]


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
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.MT4_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; MT4.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32, i32, i32, i32, i32, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6)
	call void (i32) @print_int(i32 %_8)
	
	ret i32 0
}

define i32 @MT4.Start(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
	%p1 = alloca i32
	store i32 %.p1, i32* %p1
	%p2 = alloca i32
	store i32 %.p2, i32* %p2
	%p3 = alloca i32
	store i32 %.p3, i32* %p3
	%p4 = alloca i32
	store i32 %.p4, i32* %p4
	%p5 = alloca i32
	store i32 %.p5, i32* %p5
	%p6 = alloca i32
	store i32 %.p6, i32* %p6
	%aux = alloca i32
	
	%_0 = load i32, i32* %p1
	call void (i32) @print_int(i32 %_0)
	
	%_1 = load i32, i32* %p2
	call void (i32) @print_int(i32 %_1)
	
	%_2 = load i32, i32* %p3
	call void (i32) @print_int(i32 %_2)
	
	%_3 = load i32, i32* %p4
	call void (i32) @print_int(i32 %_3)
	
	%_4 = load i32, i32* %p5
	call void (i32) @print_int(i32 %_4)
	
	%_5 = load i32, i32* %p6
	call void (i32) @print_int(i32 %_5)
	
	; MT4.Change : 1
	%_6 = bitcast i8* %this to i8***
	%_7 = load i8**, i8*** %_6
	%_8 = getelementptr i8*, i8** %_7, i32 1
	%_9 = load i8*, i8** %_8
	%_10 = bitcast i8* %_9 to i32 (i8*,i32, i32, i32, i32, i32, i32)*
	%_12 = load i32, i32* %p6
	%_13 = load i32, i32* %p5
	%_14 = load i32, i32* %p4
	%_15 = load i32, i32* %p3
	%_16 = load i32, i32* %p2
	%_17 = load i32, i32* %p1
	%_11 = call i32 %_10(i8* %this, i32 %_12, i32 %_13, i32 %_14, i32 %_15, i32 %_16, i32 %_17)
	store i32 %_11, i32* %aux
	
	%_18 = load i32, i32* %aux
	ret i32 %_18
}

define i32 @MT4.Change(i8* %this, i32 %.p1, i32 %.p2, i32 %.p3, i32 %.p4, i32 %.p5, i32 %.p6) {
	%p1 = alloca i32
	store i32 %.p1, i32* %p1
	%p2 = alloca i32
	store i32 %.p2, i32* %p2
	%p3 = alloca i32
	store i32 %.p3, i32* %p3
	%p4 = alloca i32
	store i32 %.p4, i32* %p4
	%p5 = alloca i32
	store i32 %.p5, i32* %p5
	%p6 = alloca i32
	store i32 %.p6, i32* %p6
	%_0 = load i32, i32* %p1
	call void (i32) @print_int(i32 %_0)
	
	%_1 = load i32, i32* %p2
	call void (i32) @print_int(i32 %_1)
	
	%_2 = load i32, i32* %p3
	call void (i32) @print_int(i32 %_2)
	
	%_3 = load i32, i32* %p4
	call void (i32) @print_int(i32 %_3)
	
	%_4 = load i32, i32* %p5
	call void (i32) @print_int(i32 %_4)
	
	%_5 = load i32, i32* %p6
	call void (i32) @print_int(i32 %_5)
	
	ret i32 0
}
