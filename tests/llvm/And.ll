@.And_vtable = global [0 x i8*] []

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
@_cNSZ = constant [15 x i8] c"Negative size\0a\00"
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

define void @throw_nsz() {
    %_str = bitcast [15 x i8]* @_cNSZ to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() {
    ; Allocating space on the stack for the local variables
    %b = alloca i1

    %c = alloca i1

    %x = alloca i32

    ; Write false (0) and true (1) to b and c respectively
    store i1 0, i1* %b

    store i1 1, i1* %c

    ; Code for loading b
    %_0 = load i1, i1* %b
    
    ; Check result, short circuit if false
    br i1 %_0, label %exp_res_1, label %exp_res_0

    exp_res_0:
    br label %exp_res_3

    exp_res_1:
    %_1 = load i1, i1* %c
    br label %exp_res_2

    exp_res_2:
    br label %exp_res_3

    ; Get apporopriate value, depending on the predecesor block
    exp_res_3:
    %_2 = phi i1  [ 0, %exp_res_0 ], [ %_1, %exp_res_2 ]
    br i1 %_2, label %if_then_0, label %if_else_0
    if_else_0:
    store i32 1, i32* %x

    br label %if_end_0
    if_then_0:
    store i32 0, i32* %x

    br label %if_end_0
    if_end_0:

    %_3 = load i32, i32* %x
    call void (i32) @print_int(i32 %_3)

    ret i32 0
}

