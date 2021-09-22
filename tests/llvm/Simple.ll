@.Simple_vtable = global [0 x i8*] []

; Everything below up until main is boilerplate and will be included in all
; your outputs.

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
    ; Allocate 4 bytes of memory on the stack for the local variable x, and return
    ; the address of the first byte.
    ; These allocations will be automatically released on function return.
    %x = alloca i32

    ; Assign 10 to x
    store i32 10, i32* %x

    ; Load the value of local variable x
    %_0 = load i32, i32* %x

    ; Call print, passing %_0 as argument
    call void (i32) @print_int(i32 %_0)

    ret i32 0
}

