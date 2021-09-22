
declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca i32*
  store i32* null, i32** %v0
  %v1 = alloca i32
  store i32 0, i32* %v1
  %v2 = sub i32 1, 2
  store i32 %v2, i32* %v1
  %v3 = load i32, i32* %v1
  %v4 = icmp slt i32 %v3, 0
  br i1 %v4, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v5 = add i32 %v3, 1
  %v6 = mul i32 %v5, 4
  %v7 = call i8* @calloc(i32 1, i32 %v6)
  %v8 = bitcast i8* %v7 to i32*
  store i32 %v3, i32* %v8
  store i32* %v8, i32** %v0
  ret i32 0
}

