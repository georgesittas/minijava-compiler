%class.A = type { i8* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [1 x i8*] [
  i8* bitcast (i32(i8*)* @A__getData to i8*)
]

define i32 @A__getData(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 100
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca i32
  store i32 0, i32* %v0
  %v1 = alloca i32
  store i32 0, i32* %v1
  store i32 10, i32* %v0
  store i32 20, i32* %v1
  %v2 = add i32 1, 2
  %v3 = add i32 %v2, 3
  %v4 = load i32, i32* %v0
  %v5 = add i32 %v3, %v4
  %v6 = load i32, i32* %v1
  %v7 = add i32 %v5, %v6
  %v8 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v8, i32 %v7)
  %v9 = mul i32 1, 2
  %v10 = mul i32 %v9, 3
  %v11 = load i32, i32* %v0
  %v12 = mul i32 %v10, %v11
  %v13 = load i32, i32* %v1
  %v14 = mul i32 %v12, %v13
  %v15 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v15, i32 %v14)
  %v16 = mul i32 1, 2
  %v17 = mul i32 %v16, 3
  %v18 = load i32, i32* %v0
  %v19 = sub i32 %v17, %v18
  %v20 = load i32, i32* %v1
  %v21 = add i32 %v19, %v20
  %v22 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v22, i32 %v21)
  %v23 = call i8* @calloc(i32 1, i32 8)
  %v24 = bitcast i8* %v23 to [1 x i8*]**
  store [1 x i8*]* @A__vtable, [1 x i8*]** %v24
  %v25 = bitcast i8* %v23 to %class.A*
  %v26 = bitcast %class.A* %v25 to i8***
  %v27 = load i8**, i8*** %v26
  %v28 = load i8*, i8** %v27
  %v29 = bitcast i8* %v28 to i32(i8*)*
  %v30 = bitcast %class.A* %v25 to i8*
  ; A__getData
  %v31 = call i32 %v29(i8* %v30)
  %v32 = mul i32 1, %v31
  %v33 = mul i32 %v32, 3
  %v34 = load i32, i32* %v0
  %v35 = sub i32 %v33, %v34
  %v36 = add i32 %v35, 20
  %v37 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v37, i32 %v36)
  ret i32 0
}

