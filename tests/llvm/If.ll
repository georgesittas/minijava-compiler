@.Simple_vtable = global [0 x i8*] []

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
    %x = alloca i32

    store i32 10, i32* %x

    %_0 = load i32, i32* %x
    %_1 = icmp slt i32 %_0, 2
    br i1 %_1, label %if_then_0, label %if_else_0

    if_else_0:
    call void (i32) @print_int(i32 1)
    br label %if_end_0

    if_then_0:
    call void (i32) @print_int(i32 0)
    br label %if_end_0

    if_end_0:
    ret i32 0
}

