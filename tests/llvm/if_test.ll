%class.A = type { i8* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [1 x i8*] [
  i8* bitcast (i32(i8*, i32)* @A__foo to i8*)
]

define i32 @A__foo(i8* %v0, i32 %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i32
  store i32 %v1, i32* %v2
  %v3 = load i32, i32* %v2
  %v4 = icmp slt i32 %v3, 2
  br i1 %v4, label %if, label %else

if:
  store i32 3, i32* %v2
  br label %if_end

else:
  store i32 4, i32* %v2
  br label %if_end

if_end:
  %v5 = load i32, i32* %v2
  ret i32 %v5
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = call i8* @calloc(i32 1, i32 8)
  %v1 = bitcast i8* %v0 to [1 x i8*]**
  store [1 x i8*]* @A__vtable, [1 x i8*]** %v1
  %v2 = bitcast i8* %v0 to %class.A*
  %v3 = bitcast %class.A* %v2 to i8***
  %v4 = load i8**, i8*** %v3
  %v5 = load i8*, i8** %v4
  %v6 = bitcast i8* %v5 to i32(i8*, i32)*
  %v7 = bitcast %class.A* %v2 to i8*
  ; A__foo
  %v8 = call i32 %v6(i8* %v7, i32 1)
  %v9 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v9, i32 %v8)
  %v10 = call i8* @calloc(i32 1, i32 8)
  %v11 = bitcast i8* %v10 to [1 x i8*]**
  store [1 x i8*]* @A__vtable, [1 x i8*]** %v11
  %v12 = bitcast i8* %v10 to %class.A*
  %v13 = bitcast %class.A* %v12 to i8***
  %v14 = load i8**, i8*** %v13
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i32(i8*, i32)*
  %v17 = bitcast %class.A* %v12 to i8*
  ; A__foo
  %v18 = call i32 %v16(i8* %v17, i32 2)
  %v19 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v19, i32 %v18)
  ret i32 0
}

