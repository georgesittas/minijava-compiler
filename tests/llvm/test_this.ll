%class.A = type { i8*, i32 }
%class.B = type { %class.A, i32 }
%class.C = type { %class.B, i32 }
%class.D = type { %class.C, i32 }
%class.E = type { %class.D, i32 }
%class.F = type { i8*, %class.E* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [2 x i8*] [
  i8* bitcast (i32(i8*)* @A__InitA to i8*),
  i8* bitcast (i32(i8*)* @A__f1 to i8*)
]

define i32 @A__InitA(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 8
  %v2 = bitcast i8* %v1 to i32*
  store i32 1024, i32* %v2
  %v3 = getelementptr inbounds i8, i8* %v0, i32 8
  %v4 = bitcast i8* %v3 to i32*
  %v5 = load i32, i32* %v4
  ret i32 %v5
}

define i32 @A__f1(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 1
}

@B__vtable = global [4 x i8*] [
  i8* bitcast (i32(i8*)* @A__InitA to i8*),
  i8* bitcast (i32(i8*)* @A__f1 to i8*),
  i8* bitcast (i32(i8*)* @B__InitB to i8*),
  i8* bitcast (i32(i8*)* @B__f2 to i8*)
]

define i32 @B__InitB(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 12
  %v2 = bitcast i8* %v1 to i32*
  store i32 2048, i32* %v2
  %v3 = getelementptr inbounds i8, i8* %v0, i32 12
  %v4 = bitcast i8* %v3 to i32*
  %v5 = load i32, i32* %v4
  %v6 = bitcast i8* %v0 to i8***
  %v7 = load i8**, i8*** %v6
  %v8 = load i8*, i8** %v7
  %v9 = bitcast i8* %v8 to i32(i8*)*
  ; B__InitA
  %v10 = call i32 %v9(i8* %v0)
  %v11 = add i32 %v5, %v10
  ret i32 %v11
}

define i32 @B__f2(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = bitcast i8* %v0 to i8***
  %v2 = load i8**, i8*** %v1
  %v3 = getelementptr inbounds i8*, i8** %v2, i32 1
  %v4 = load i8*, i8** %v3
  %v5 = bitcast i8* %v4 to i32(i8*)*
  ; B__f1
  %v6 = call i32 %v5(i8* %v0)
  %v7 = add i32 2, %v6
  ret i32 %v7
}

@C__vtable = global [6 x i8*] [
  i8* bitcast (i32(i8*)* @A__InitA to i8*),
  i8* bitcast (i32(i8*)* @A__f1 to i8*),
  i8* bitcast (i32(i8*)* @B__InitB to i8*),
  i8* bitcast (i32(i8*)* @B__f2 to i8*),
  i8* bitcast (i32(i8*)* @C__InitC to i8*),
  i8* bitcast (i32(i8*)* @C__f3 to i8*)
]

define i32 @C__InitC(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 16
  %v2 = bitcast i8* %v1 to i32*
  store i32 4096, i32* %v2
  %v3 = getelementptr inbounds i8, i8* %v0, i32 16
  %v4 = bitcast i8* %v3 to i32*
  %v5 = load i32, i32* %v4
  %v6 = bitcast i8* %v0 to i8***
  %v7 = load i8**, i8*** %v6
  %v8 = getelementptr inbounds i8*, i8** %v7, i32 2
  %v9 = load i8*, i8** %v8
  %v10 = bitcast i8* %v9 to i32(i8*)*
  ; C__InitB
  %v11 = call i32 %v10(i8* %v0)
  %v12 = add i32 %v5, %v11
  ret i32 %v12
}

define i32 @C__f3(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = bitcast i8* %v0 to i8***
  %v2 = load i8**, i8*** %v1
  %v3 = getelementptr inbounds i8*, i8** %v2, i32 3
  %v4 = load i8*, i8** %v3
  %v5 = bitcast i8* %v4 to i32(i8*)*
  ; C__f2
  %v6 = call i32 %v5(i8* %v0)
  %v7 = add i32 3, %v6
  ret i32 %v7
}

@D__vtable = global [8 x i8*] [
  i8* bitcast (i32(i8*)* @A__InitA to i8*),
  i8* bitcast (i32(i8*)* @A__f1 to i8*),
  i8* bitcast (i32(i8*)* @B__InitB to i8*),
  i8* bitcast (i32(i8*)* @B__f2 to i8*),
  i8* bitcast (i32(i8*)* @C__InitC to i8*),
  i8* bitcast (i32(i8*)* @C__f3 to i8*),
  i8* bitcast (i32(i8*)* @D__InitD to i8*),
  i8* bitcast (i32(i8*)* @D__f4 to i8*)
]

define i32 @D__InitD(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 20
  %v2 = bitcast i8* %v1 to i32*
  store i32 8192, i32* %v2
  %v3 = getelementptr inbounds i8, i8* %v0, i32 20
  %v4 = bitcast i8* %v3 to i32*
  %v5 = load i32, i32* %v4
  %v6 = bitcast i8* %v0 to i8***
  %v7 = load i8**, i8*** %v6
  %v8 = getelementptr inbounds i8*, i8** %v7, i32 4
  %v9 = load i8*, i8** %v8
  %v10 = bitcast i8* %v9 to i32(i8*)*
  ; D__InitC
  %v11 = call i32 %v10(i8* %v0)
  %v12 = add i32 %v5, %v11
  ret i32 %v12
}

define i32 @D__f4(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = bitcast i8* %v0 to i8***
  %v2 = load i8**, i8*** %v1
  %v3 = getelementptr inbounds i8*, i8** %v2, i32 5
  %v4 = load i8*, i8** %v3
  %v5 = bitcast i8* %v4 to i32(i8*)*
  ; D__f3
  %v6 = call i32 %v5(i8* %v0)
  %v7 = add i32 4, %v6
  ret i32 %v7
}

@E__vtable = global [10 x i8*] [
  i8* bitcast (i32(i8*)* @A__InitA to i8*),
  i8* bitcast (i32(i8*)* @A__f1 to i8*),
  i8* bitcast (i32(i8*)* @B__InitB to i8*),
  i8* bitcast (i32(i8*)* @B__f2 to i8*),
  i8* bitcast (i32(i8*)* @C__InitC to i8*),
  i8* bitcast (i32(i8*)* @C__f3 to i8*),
  i8* bitcast (i32(i8*)* @D__InitD to i8*),
  i8* bitcast (i32(i8*)* @D__f4 to i8*),
  i8* bitcast (i32(i8*)* @E__InitE to i8*),
  i8* bitcast (i32(i8*)* @E__f5 to i8*)
]

define i32 @E__InitE(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 24
  %v2 = bitcast i8* %v1 to i32*
  store i32 16384, i32* %v2
  %v3 = getelementptr inbounds i8, i8* %v0, i32 24
  %v4 = bitcast i8* %v3 to i32*
  %v5 = load i32, i32* %v4
  %v6 = bitcast i8* %v0 to i8***
  %v7 = load i8**, i8*** %v6
  %v8 = getelementptr inbounds i8*, i8** %v7, i32 6
  %v9 = load i8*, i8** %v8
  %v10 = bitcast i8* %v9 to i32(i8*)*
  ; E__InitD
  %v11 = call i32 %v10(i8* %v0)
  %v12 = add i32 %v5, %v11
  ret i32 %v12
}

define i32 @E__f5(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = bitcast i8* %v0 to i8***
  %v2 = load i8**, i8*** %v1
  %v3 = getelementptr inbounds i8*, i8** %v2, i32 7
  %v4 = load i8*, i8** %v3
  %v5 = bitcast i8* %v4 to i32(i8*)*
  ; E__f4
  %v6 = call i32 %v5(i8* %v0)
  %v7 = add i32 5, %v6
  ret i32 %v7
}

@F__vtable = global [1 x i8*] [
  i8* bitcast (i32(i8*, %class.E*)* @F__InitF to i8*)
]

define i32 @F__InitF(i8* %v0, %class.E* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca %class.E*
  store %class.E* %v1, %class.E** %v2
  %v3 = load %class.E*, %class.E** %v2
  %v4 = getelementptr inbounds i8, i8* %v0, i32 8
  %v5 = bitcast i8* %v4 to %class.E**
  store %class.E* %v3, %class.E** %v5
  %v6 = load %class.E*, %class.E** %v2
  %v7 = bitcast %class.E* %v6 to i8***
  %v8 = load i8**, i8*** %v7
  %v9 = getelementptr inbounds i8*, i8** %v8, i32 9
  %v10 = load i8*, i8** %v9
  %v11 = bitcast i8* %v10 to i32(i8*)*
  %v12 = bitcast %class.E* %v6 to i8*
  ; E__f5
  %v13 = call i32 %v11(i8* %v12)
  ret i32 %v13
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca %class.E*
  store %class.E* null, %class.E** %v0
  %v1 = alloca %class.F*
  store %class.F* null, %class.F** %v1
  %v2 = call i8* @calloc(i32 1, i32 28)
  %v3 = bitcast i8* %v2 to [10 x i8*]**
  store [10 x i8*]* @E__vtable, [10 x i8*]** %v3
  %v4 = bitcast i8* %v2 to %class.E*
  store %class.E* %v4, %class.E** %v0
  %v5 = call i8* @calloc(i32 1, i32 16)
  %v6 = bitcast i8* %v5 to [1 x i8*]**
  store [1 x i8*]* @F__vtable, [1 x i8*]** %v6
  %v7 = bitcast i8* %v5 to %class.F*
  store %class.F* %v7, %class.F** %v1
  %v8 = load %class.E*, %class.E** %v0
  %v9 = bitcast %class.E* %v8 to i8***
  %v10 = load i8**, i8*** %v9
  %v11 = getelementptr inbounds i8*, i8** %v10, i32 8
  %v12 = load i8*, i8** %v11
  %v13 = bitcast i8* %v12 to i32(i8*)*
  %v14 = bitcast %class.E* %v8 to i8*
  ; E__InitE
  %v15 = call i32 %v13(i8* %v14)
  %v16 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v16, i32 %v15)
  %v17 = load %class.E*, %class.E** %v0
  %v18 = bitcast %class.E* %v17 to i8***
  %v19 = load i8**, i8*** %v18
  %v20 = getelementptr inbounds i8*, i8** %v19, i32 9
  %v21 = load i8*, i8** %v20
  %v22 = bitcast i8* %v21 to i32(i8*)*
  %v23 = bitcast %class.E* %v17 to i8*
  ; E__f5
  %v24 = call i32 %v22(i8* %v23)
  %v25 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v25, i32 %v24)
  %v26 = load %class.F*, %class.F** %v1
  %v27 = load %class.E*, %class.E** %v0
  %v28 = bitcast %class.F* %v26 to i8***
  %v29 = load i8**, i8*** %v28
  %v30 = load i8*, i8** %v29
  %v31 = bitcast i8* %v30 to i32(i8*, %class.E*)*
  %v32 = bitcast %class.F* %v26 to i8*
  ; F__InitF
  %v33 = call i32 %v31(i8* %v32, %class.E* %v27)
  %v34 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v34, i32 %v33)
  ret i32 0
}

