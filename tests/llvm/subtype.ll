%class.A = type { i8* }
%class.B = type { %class.A }
%class.C = type { %class.A }
%class.D = type { %class.B }
%class.Receiver = type { i8* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [3 x i8*] [
  i8* bitcast (i32(i8*)* @A__foo to i8*),
  i8* bitcast (i32(i8*)* @A__bar to i8*),
  i8* bitcast (i32(i8*)* @A__test to i8*)
]

define i32 @A__foo(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 1
}

define i32 @A__bar(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 2
}

define i32 @A__test(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 3
}

@B__vtable = global [5 x i8*] [
  i8* bitcast (i32(i8*)* @A__foo to i8*),
  i8* bitcast (i32(i8*)* @B__bar to i8*),
  i8* bitcast (i32(i8*)* @A__test to i8*),
  i8* bitcast (i32(i8*)* @B__not_overriden to i8*),
  i8* bitcast (i32(i8*)* @B__another to i8*)
]

define i32 @B__bar(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 12
}

define i32 @B__not_overriden(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 14
}

define i32 @B__another(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 15
}

@C__vtable = global [3 x i8*] [
  i8* bitcast (i32(i8*)* @A__foo to i8*),
  i8* bitcast (i32(i8*)* @C__bar to i8*),
  i8* bitcast (i32(i8*)* @A__test to i8*)
]

define i32 @C__bar(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 22
}

@D__vtable = global [6 x i8*] [
  i8* bitcast (i32(i8*)* @A__foo to i8*),
  i8* bitcast (i32(i8*)* @D__bar to i8*),
  i8* bitcast (i32(i8*)* @A__test to i8*),
  i8* bitcast (i32(i8*)* @B__not_overriden to i8*),
  i8* bitcast (i32(i8*)* @D__another to i8*),
  i8* bitcast (i32(i8*)* @D__stef to i8*)
]

define i32 @D__bar(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 32
}

define i32 @D__another(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 35
}

define i32 @D__stef(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 36
}

@Receiver__vtable = global [8 x i8*] [
  i8* bitcast (i1(i8*, %class.A*)* @Receiver__A to i8*),
  i8* bitcast (i1(i8*, %class.B*)* @Receiver__B to i8*),
  i8* bitcast (i1(i8*, %class.C*)* @Receiver__C to i8*),
  i8* bitcast (i1(i8*, %class.D*)* @Receiver__D to i8*),
  i8* bitcast (%class.A*(i8*)* @Receiver__alloc_B_for_A to i8*),
  i8* bitcast (%class.A*(i8*)* @Receiver__alloc_C_for_A to i8*),
  i8* bitcast (%class.A*(i8*)* @Receiver__alloc_D_for_A to i8*),
  i8* bitcast (%class.B*(i8*)* @Receiver__alloc_D_for_B to i8*)
]

define i1 @Receiver__A(i8* %v0, %class.A* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca %class.A*
  store %class.A* %v1, %class.A** %v2
  %v3 = load %class.A*, %class.A** %v2
  %v4 = bitcast %class.A* %v3 to i8***
  %v5 = load i8**, i8*** %v4
  %v6 = load i8*, i8** %v5
  %v7 = bitcast i8* %v6 to i32(i8*)*
  %v8 = bitcast %class.A* %v3 to i8*
  ; A__foo
  %v9 = call i32 %v7(i8* %v8)
  %v10 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v10, i32 %v9)
  %v11 = load %class.A*, %class.A** %v2
  %v12 = bitcast %class.A* %v11 to i8***
  %v13 = load i8**, i8*** %v12
  %v14 = getelementptr inbounds i8*, i8** %v13, i32 1
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i32(i8*)*
  %v17 = bitcast %class.A* %v11 to i8*
  ; A__bar
  %v18 = call i32 %v16(i8* %v17)
  %v19 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v19, i32 %v18)
  %v20 = load %class.A*, %class.A** %v2
  %v21 = bitcast %class.A* %v20 to i8***
  %v22 = load i8**, i8*** %v21
  %v23 = getelementptr inbounds i8*, i8** %v22, i32 2
  %v24 = load i8*, i8** %v23
  %v25 = bitcast i8* %v24 to i32(i8*)*
  %v26 = bitcast %class.A* %v20 to i8*
  ; A__test
  %v27 = call i32 %v25(i8* %v26)
  %v28 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v28, i32 %v27)
  ret i1 true
}

define i1 @Receiver__B(i8* %v0, %class.B* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca %class.B*
  store %class.B* %v1, %class.B** %v2
  %v3 = load %class.B*, %class.B** %v2
  %v4 = bitcast %class.B* %v3 to i8***
  %v5 = load i8**, i8*** %v4
  %v6 = load i8*, i8** %v5
  %v7 = bitcast i8* %v6 to i32(i8*)*
  %v8 = bitcast %class.B* %v3 to i8*
  ; B__foo
  %v9 = call i32 %v7(i8* %v8)
  %v10 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v10, i32 %v9)
  %v11 = load %class.B*, %class.B** %v2
  %v12 = bitcast %class.B* %v11 to i8***
  %v13 = load i8**, i8*** %v12
  %v14 = getelementptr inbounds i8*, i8** %v13, i32 1
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i32(i8*)*
  %v17 = bitcast %class.B* %v11 to i8*
  ; B__bar
  %v18 = call i32 %v16(i8* %v17)
  %v19 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v19, i32 %v18)
  %v20 = load %class.B*, %class.B** %v2
  %v21 = bitcast %class.B* %v20 to i8***
  %v22 = load i8**, i8*** %v21
  %v23 = getelementptr inbounds i8*, i8** %v22, i32 2
  %v24 = load i8*, i8** %v23
  %v25 = bitcast i8* %v24 to i32(i8*)*
  %v26 = bitcast %class.B* %v20 to i8*
  ; B__test
  %v27 = call i32 %v25(i8* %v26)
  %v28 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v28, i32 %v27)
  %v29 = load %class.B*, %class.B** %v2
  %v30 = bitcast %class.B* %v29 to i8***
  %v31 = load i8**, i8*** %v30
  %v32 = getelementptr inbounds i8*, i8** %v31, i32 3
  %v33 = load i8*, i8** %v32
  %v34 = bitcast i8* %v33 to i32(i8*)*
  %v35 = bitcast %class.B* %v29 to i8*
  ; B__not_overriden
  %v36 = call i32 %v34(i8* %v35)
  %v37 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v37, i32 %v36)
  %v38 = load %class.B*, %class.B** %v2
  %v39 = bitcast %class.B* %v38 to i8***
  %v40 = load i8**, i8*** %v39
  %v41 = getelementptr inbounds i8*, i8** %v40, i32 4
  %v42 = load i8*, i8** %v41
  %v43 = bitcast i8* %v42 to i32(i8*)*
  %v44 = bitcast %class.B* %v38 to i8*
  ; B__another
  %v45 = call i32 %v43(i8* %v44)
  %v46 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v46, i32 %v45)
  ret i1 true
}

define i1 @Receiver__C(i8* %v0, %class.C* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca %class.C*
  store %class.C* %v1, %class.C** %v2
  %v3 = load %class.C*, %class.C** %v2
  %v4 = bitcast %class.C* %v3 to i8***
  %v5 = load i8**, i8*** %v4
  %v6 = load i8*, i8** %v5
  %v7 = bitcast i8* %v6 to i32(i8*)*
  %v8 = bitcast %class.C* %v3 to i8*
  ; C__foo
  %v9 = call i32 %v7(i8* %v8)
  %v10 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v10, i32 %v9)
  %v11 = load %class.C*, %class.C** %v2
  %v12 = bitcast %class.C* %v11 to i8***
  %v13 = load i8**, i8*** %v12
  %v14 = getelementptr inbounds i8*, i8** %v13, i32 1
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i32(i8*)*
  %v17 = bitcast %class.C* %v11 to i8*
  ; C__bar
  %v18 = call i32 %v16(i8* %v17)
  %v19 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v19, i32 %v18)
  %v20 = load %class.C*, %class.C** %v2
  %v21 = bitcast %class.C* %v20 to i8***
  %v22 = load i8**, i8*** %v21
  %v23 = getelementptr inbounds i8*, i8** %v22, i32 2
  %v24 = load i8*, i8** %v23
  %v25 = bitcast i8* %v24 to i32(i8*)*
  %v26 = bitcast %class.C* %v20 to i8*
  ; C__test
  %v27 = call i32 %v25(i8* %v26)
  %v28 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v28, i32 %v27)
  ret i1 true
}

define i1 @Receiver__D(i8* %v0, %class.D* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca %class.D*
  store %class.D* %v1, %class.D** %v2
  %v3 = load %class.D*, %class.D** %v2
  %v4 = bitcast %class.D* %v3 to i8***
  %v5 = load i8**, i8*** %v4
  %v6 = load i8*, i8** %v5
  %v7 = bitcast i8* %v6 to i32(i8*)*
  %v8 = bitcast %class.D* %v3 to i8*
  ; D__foo
  %v9 = call i32 %v7(i8* %v8)
  %v10 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v10, i32 %v9)
  %v11 = load %class.D*, %class.D** %v2
  %v12 = bitcast %class.D* %v11 to i8***
  %v13 = load i8**, i8*** %v12
  %v14 = getelementptr inbounds i8*, i8** %v13, i32 1
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i32(i8*)*
  %v17 = bitcast %class.D* %v11 to i8*
  ; D__bar
  %v18 = call i32 %v16(i8* %v17)
  %v19 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v19, i32 %v18)
  %v20 = load %class.D*, %class.D** %v2
  %v21 = bitcast %class.D* %v20 to i8***
  %v22 = load i8**, i8*** %v21
  %v23 = getelementptr inbounds i8*, i8** %v22, i32 2
  %v24 = load i8*, i8** %v23
  %v25 = bitcast i8* %v24 to i32(i8*)*
  %v26 = bitcast %class.D* %v20 to i8*
  ; D__test
  %v27 = call i32 %v25(i8* %v26)
  %v28 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v28, i32 %v27)
  %v29 = load %class.D*, %class.D** %v2
  %v30 = bitcast %class.D* %v29 to i8***
  %v31 = load i8**, i8*** %v30
  %v32 = getelementptr inbounds i8*, i8** %v31, i32 3
  %v33 = load i8*, i8** %v32
  %v34 = bitcast i8* %v33 to i32(i8*)*
  %v35 = bitcast %class.D* %v29 to i8*
  ; D__not_overriden
  %v36 = call i32 %v34(i8* %v35)
  %v37 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v37, i32 %v36)
  %v38 = load %class.D*, %class.D** %v2
  %v39 = bitcast %class.D* %v38 to i8***
  %v40 = load i8**, i8*** %v39
  %v41 = getelementptr inbounds i8*, i8** %v40, i32 4
  %v42 = load i8*, i8** %v41
  %v43 = bitcast i8* %v42 to i32(i8*)*
  %v44 = bitcast %class.D* %v38 to i8*
  ; D__another
  %v45 = call i32 %v43(i8* %v44)
  %v46 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v46, i32 %v45)
  %v47 = load %class.D*, %class.D** %v2
  %v48 = bitcast %class.D* %v47 to i8***
  %v49 = load i8**, i8*** %v48
  %v50 = getelementptr inbounds i8*, i8** %v49, i32 5
  %v51 = load i8*, i8** %v50
  %v52 = bitcast i8* %v51 to i32(i8*)*
  %v53 = bitcast %class.D* %v47 to i8*
  ; D__stef
  %v54 = call i32 %v52(i8* %v53)
  %v55 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v55, i32 %v54)
  ret i1 true
}

define %class.A* @Receiver__alloc_B_for_A(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = call i8* @calloc(i32 1, i32 8)
  %v2 = bitcast i8* %v1 to [5 x i8*]**
  store [5 x i8*]* @B__vtable, [5 x i8*]** %v2
  %v3 = bitcast i8* %v1 to %class.B*
  %v4 = bitcast %class.B* %v3 to %class.A*
  ret %class.A* %v4
}

define %class.A* @Receiver__alloc_C_for_A(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = call i8* @calloc(i32 1, i32 8)
  %v2 = bitcast i8* %v1 to [3 x i8*]**
  store [3 x i8*]* @C__vtable, [3 x i8*]** %v2
  %v3 = bitcast i8* %v1 to %class.C*
  %v4 = bitcast %class.C* %v3 to %class.A*
  ret %class.A* %v4
}

define %class.A* @Receiver__alloc_D_for_A(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = call i8* @calloc(i32 1, i32 8)
  %v2 = bitcast i8* %v1 to [6 x i8*]**
  store [6 x i8*]* @D__vtable, [6 x i8*]** %v2
  %v3 = bitcast i8* %v1 to %class.D*
  %v4 = bitcast %class.D* %v3 to %class.A*
  ret %class.A* %v4
}

define %class.B* @Receiver__alloc_D_for_B(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = call i8* @calloc(i32 1, i32 8)
  %v2 = bitcast i8* %v1 to [6 x i8*]**
  store [6 x i8*]* @D__vtable, [6 x i8*]** %v2
  %v3 = bitcast i8* %v1 to %class.D*
  %v4 = bitcast %class.D* %v3 to %class.B*
  ret %class.B* %v4
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca i1
  store i1 false, i1* %v0
  %v1 = alloca %class.A*
  store %class.A* null, %class.A** %v1
  %v2 = alloca %class.B*
  store %class.B* null, %class.B** %v2
  %v3 = alloca %class.C*
  store %class.C* null, %class.C** %v3
  %v4 = alloca %class.D*
  store %class.D* null, %class.D** %v4
  %v5 = alloca i32
  store i32 0, i32* %v5
  %v6 = alloca i32
  store i32 0, i32* %v6
  store i32 1111111111, i32* %v5
  store i32 333333333, i32* %v6
  %v7 = call i8* @calloc(i32 1, i32 8)
  %v8 = bitcast i8* %v7 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v8
  %v9 = bitcast i8* %v7 to %class.Receiver*
  %v10 = call i8* @calloc(i32 1, i32 8)
  %v11 = bitcast i8* %v10 to [3 x i8*]**
  store [3 x i8*]* @A__vtable, [3 x i8*]** %v11
  %v12 = bitcast i8* %v10 to %class.A*
  %v13 = bitcast %class.Receiver* %v9 to i8***
  %v14 = load i8**, i8*** %v13
  %v15 = load i8*, i8** %v14
  %v16 = bitcast i8* %v15 to i1(i8*, %class.A*)*
  %v17 = bitcast %class.Receiver* %v9 to i8*
  ; Receiver__A
  %v18 = call i1 %v16(i8* %v17, %class.A* %v12)
  store i1 %v18, i1* %v0
  %v19 = load i32, i32* %v5
  %v20 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v20, i32 %v19)
  %v21 = call i8* @calloc(i32 1, i32 8)
  %v22 = bitcast i8* %v21 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v22
  %v23 = bitcast i8* %v21 to %class.Receiver*
  %v24 = call i8* @calloc(i32 1, i32 8)
  %v25 = bitcast i8* %v24 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v25
  %v26 = bitcast i8* %v24 to %class.Receiver*
  %v27 = bitcast %class.Receiver* %v26 to i8***
  %v28 = load i8**, i8*** %v27
  %v29 = getelementptr inbounds i8*, i8** %v28, i32 4
  %v30 = load i8*, i8** %v29
  %v31 = bitcast i8* %v30 to %class.A*(i8*)*
  %v32 = bitcast %class.Receiver* %v26 to i8*
  ; Receiver__alloc_B_for_A
  %v33 = call %class.A* %v31(i8* %v32)
  %v34 = bitcast %class.Receiver* %v23 to i8***
  %v35 = load i8**, i8*** %v34
  %v36 = load i8*, i8** %v35
  %v37 = bitcast i8* %v36 to i1(i8*, %class.A*)*
  %v38 = bitcast %class.Receiver* %v23 to i8*
  ; Receiver__A
  %v39 = call i1 %v37(i8* %v38, %class.A* %v33)
  store i1 %v39, i1* %v0
  %v40 = load i32, i32* %v5
  %v41 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v41, i32 %v40)
  %v42 = call i8* @calloc(i32 1, i32 8)
  %v43 = bitcast i8* %v42 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v43
  %v44 = bitcast i8* %v42 to %class.Receiver*
  %v45 = call i8* @calloc(i32 1, i32 8)
  %v46 = bitcast i8* %v45 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v46
  %v47 = bitcast i8* %v45 to %class.Receiver*
  %v48 = bitcast %class.Receiver* %v47 to i8***
  %v49 = load i8**, i8*** %v48
  %v50 = getelementptr inbounds i8*, i8** %v49, i32 5
  %v51 = load i8*, i8** %v50
  %v52 = bitcast i8* %v51 to %class.A*(i8*)*
  %v53 = bitcast %class.Receiver* %v47 to i8*
  ; Receiver__alloc_C_for_A
  %v54 = call %class.A* %v52(i8* %v53)
  %v55 = bitcast %class.Receiver* %v44 to i8***
  %v56 = load i8**, i8*** %v55
  %v57 = load i8*, i8** %v56
  %v58 = bitcast i8* %v57 to i1(i8*, %class.A*)*
  %v59 = bitcast %class.Receiver* %v44 to i8*
  ; Receiver__A
  %v60 = call i1 %v58(i8* %v59, %class.A* %v54)
  store i1 %v60, i1* %v0
  %v61 = load i32, i32* %v5
  %v62 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v62, i32 %v61)
  %v63 = call i8* @calloc(i32 1, i32 8)
  %v64 = bitcast i8* %v63 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v64
  %v65 = bitcast i8* %v63 to %class.Receiver*
  %v66 = call i8* @calloc(i32 1, i32 8)
  %v67 = bitcast i8* %v66 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v67
  %v68 = bitcast i8* %v66 to %class.Receiver*
  %v69 = bitcast %class.Receiver* %v68 to i8***
  %v70 = load i8**, i8*** %v69
  %v71 = getelementptr inbounds i8*, i8** %v70, i32 6
  %v72 = load i8*, i8** %v71
  %v73 = bitcast i8* %v72 to %class.A*(i8*)*
  %v74 = bitcast %class.Receiver* %v68 to i8*
  ; Receiver__alloc_D_for_A
  %v75 = call %class.A* %v73(i8* %v74)
  %v76 = bitcast %class.Receiver* %v65 to i8***
  %v77 = load i8**, i8*** %v76
  %v78 = load i8*, i8** %v77
  %v79 = bitcast i8* %v78 to i1(i8*, %class.A*)*
  %v80 = bitcast %class.Receiver* %v65 to i8*
  ; Receiver__A
  %v81 = call i1 %v79(i8* %v80, %class.A* %v75)
  store i1 %v81, i1* %v0
  %v82 = load i32, i32* %v6
  %v83 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v83, i32 %v82)
  %v84 = call i8* @calloc(i32 1, i32 8)
  %v85 = bitcast i8* %v84 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v85
  %v86 = bitcast i8* %v84 to %class.Receiver*
  %v87 = call i8* @calloc(i32 1, i32 8)
  %v88 = bitcast i8* %v87 to [5 x i8*]**
  store [5 x i8*]* @B__vtable, [5 x i8*]** %v88
  %v89 = bitcast i8* %v87 to %class.B*
  %v90 = bitcast %class.Receiver* %v86 to i8***
  %v91 = load i8**, i8*** %v90
  %v92 = getelementptr inbounds i8*, i8** %v91, i32 1
  %v93 = load i8*, i8** %v92
  %v94 = bitcast i8* %v93 to i1(i8*, %class.B*)*
  %v95 = bitcast %class.Receiver* %v86 to i8*
  ; Receiver__B
  %v96 = call i1 %v94(i8* %v95, %class.B* %v89)
  store i1 %v96, i1* %v0
  %v97 = load i32, i32* %v5
  %v98 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v98, i32 %v97)
  %v99 = call i8* @calloc(i32 1, i32 8)
  %v100 = bitcast i8* %v99 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v100
  %v101 = bitcast i8* %v99 to %class.Receiver*
  %v102 = call i8* @calloc(i32 1, i32 8)
  %v103 = bitcast i8* %v102 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v103
  %v104 = bitcast i8* %v102 to %class.Receiver*
  %v105 = bitcast %class.Receiver* %v104 to i8***
  %v106 = load i8**, i8*** %v105
  %v107 = getelementptr inbounds i8*, i8** %v106, i32 7
  %v108 = load i8*, i8** %v107
  %v109 = bitcast i8* %v108 to %class.B*(i8*)*
  %v110 = bitcast %class.Receiver* %v104 to i8*
  ; Receiver__alloc_D_for_B
  %v111 = call %class.B* %v109(i8* %v110)
  %v112 = bitcast %class.Receiver* %v101 to i8***
  %v113 = load i8**, i8*** %v112
  %v114 = getelementptr inbounds i8*, i8** %v113, i32 1
  %v115 = load i8*, i8** %v114
  %v116 = bitcast i8* %v115 to i1(i8*, %class.B*)*
  %v117 = bitcast %class.Receiver* %v101 to i8*
  ; Receiver__B
  %v118 = call i1 %v116(i8* %v117, %class.B* %v111)
  store i1 %v118, i1* %v0
  %v119 = load i32, i32* %v6
  %v120 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v120, i32 %v119)
  %v121 = call i8* @calloc(i32 1, i32 8)
  %v122 = bitcast i8* %v121 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v122
  %v123 = bitcast i8* %v121 to %class.Receiver*
  %v124 = call i8* @calloc(i32 1, i32 8)
  %v125 = bitcast i8* %v124 to [3 x i8*]**
  store [3 x i8*]* @C__vtable, [3 x i8*]** %v125
  %v126 = bitcast i8* %v124 to %class.C*
  %v127 = bitcast %class.Receiver* %v123 to i8***
  %v128 = load i8**, i8*** %v127
  %v129 = getelementptr inbounds i8*, i8** %v128, i32 2
  %v130 = load i8*, i8** %v129
  %v131 = bitcast i8* %v130 to i1(i8*, %class.C*)*
  %v132 = bitcast %class.Receiver* %v123 to i8*
  ; Receiver__C
  %v133 = call i1 %v131(i8* %v132, %class.C* %v126)
  store i1 %v133, i1* %v0
  %v134 = load i32, i32* %v6
  %v135 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v135, i32 %v134)
  %v136 = call i8* @calloc(i32 1, i32 8)
  %v137 = bitcast i8* %v136 to [8 x i8*]**
  store [8 x i8*]* @Receiver__vtable, [8 x i8*]** %v137
  %v138 = bitcast i8* %v136 to %class.Receiver*
  %v139 = call i8* @calloc(i32 1, i32 8)
  %v140 = bitcast i8* %v139 to [6 x i8*]**
  store [6 x i8*]* @D__vtable, [6 x i8*]** %v140
  %v141 = bitcast i8* %v139 to %class.D*
  %v142 = bitcast %class.Receiver* %v138 to i8***
  %v143 = load i8**, i8*** %v142
  %v144 = getelementptr inbounds i8*, i8** %v143, i32 3
  %v145 = load i8*, i8** %v144
  %v146 = bitcast i8* %v145 to i1(i8*, %class.D*)*
  %v147 = bitcast %class.Receiver* %v138 to i8*
  ; Receiver__D
  %v148 = call i1 %v146(i8* %v147, %class.D* %v141)
  store i1 %v148, i1* %v0
  ret i32 0
}

