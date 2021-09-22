%class.A = type { i8* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [2 x i8*] [
  i8* bitcast (i32(i8*)* @A__foo to i8*),
  i8* bitcast (i32(i8*, i32, i1)* @A__bar to i8*)
]

define i32 @A__foo(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = alloca i32
  store i32 0, i32* %v1
  %v2 = alloca i32
  store i32 0, i32* %v2
  store i32 3, i32* %v1
  br label %header

header:
  %v3 = load i32, i32* %v1
  %v4 = icmp slt i32 %v3, 4
  br i1 %v4, label %loop_body, label %exit_block

loop_body:
  %v5 = load i32, i32* %v1
  %v6 = add i32 %v5, 1
  store i32 %v6, i32* %v1
  br label %header

exit_block:
  %v7 = load i32, i32* %v1
  %v8 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v8, i32 %v7)
  %v9 = bitcast i8* %v0 to i8***
  %v10 = load i8**, i8*** %v9
  %v11 = getelementptr inbounds i8*, i8** %v10, i32 1
  %v12 = load i8*, i8** %v11
  %v13 = bitcast i8* %v12 to i32(i8*, i32, i1)*
  ; A__bar
  %v14 = call i32 %v13(i8* %v0, i32 7, i1 true)
  store i32 %v14, i32* %v2
  %v15 = load i32, i32* %v2
  %v16 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v16, i32 %v15)
  ret i32 0
}

define i32 @A__bar(i8* %v0, i32 %v1, i1 %v2) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v3 = alloca i32
  store i32 %v1, i32* %v3
  %v4 = alloca i1
  store i1 %v2, i1* %v4
  %v5 = alloca i32
  store i32 0, i32* %v5
  br label %header

header:
  %v6 = load i1, i1* %v4
  br i1 %v6, label %loop_body, label %exit_block

loop_body:
  %v7 = load i32, i32* %v3
  store i32 %v7, i32* %v5
  %v8 = load i1, i1* %v4
  br i1 %v8, label %if, label %else

if:
  store i32 2, i32* %v3
  br label %if_end

else:
  br label %if_end

if_end:
  store i1 false, i1* %v4
  br label %header

exit_block:
  %v9 = load i32, i32* %v5
  ret i32 %v9
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca i32
  store i32 0, i32* %v0
  %v1 = alloca %class.A*
  store %class.A* null, %class.A** %v1
  %v2 = call i8* @calloc(i32 1, i32 8)
  %v3 = bitcast i8* %v2 to [2 x i8*]**
  store [2 x i8*]* @A__vtable, [2 x i8*]** %v3
  %v4 = bitcast i8* %v2 to %class.A*
  store %class.A* %v4, %class.A** %v1
  %v5 = load %class.A*, %class.A** %v1
  %v6 = bitcast %class.A* %v5 to i8***
  %v7 = load i8**, i8*** %v6
  %v8 = load i8*, i8** %v7
  %v9 = bitcast i8* %v8 to i32(i8*)*
  %v10 = bitcast %class.A* %v5 to i8*
  ; A__foo
  %v11 = call i32 %v9(i8* %v10)
  store i32 %v11, i32* %v0
  ret i32 0
}

