%class.A = type { i8* }
%class.C = type { i8* }
%class.B = type { %class.C }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [7 x i8*] [
  i8* bitcast (i1(i8*)* @A__t to i8*),
  i8* bitcast (i32(i8*)* @A__t2 to i8*),
  i8* bitcast (i32(i8*, i32*)* @A__lispy to i8*),
  i8* bitcast (i1(i8*)* @A__t3 to i8*),
  i8* bitcast (i1(i8*, i32, i32*)* @A__t4 to i8*),
  i8* bitcast (i32(i8*, i32*)* @A__t5 to i8*),
  i8* bitcast (i1(i8*, i1, i32*)* @A__t6 to i8*)
]

define i1 @A__t(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = icmp slt i32 1, 2
  %v2 = icmp eq i1 %v1, false
  br i1 %v2, label %and, label %and_end

and:
  br i1 true, label %and1, label %and_end1

and1:
  br label %and_end1

and_end1:
  %v3 = phi i1 [ false, %and ], [ false, %and1 ]
  br label %and_end

and_end:
  %v4 = phi i1 [ false, %entry ], [ %v3, %and_end1 ]
  ret i1 %v4
}

define i32 @A__t2(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = add i32 1, 2
  %v2 = add i32 %v1, 3
  %v3 = add i32 %v2, 4
  ret i32 %v3
}

define i32 @A__lispy(i8* %v0, i32* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i32*
  store i32* %v1, i32** %v2
  %v3 = add i32 1, 2
  %v4 = load i32*, i32** %v2
  %v5 = load i32, i32* %v4
  %v6 = icmp sge i32 3, %v5
  br i1 %v6, label %bounds, label %bounds_end

bounds:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end:
  %v7 = icmp slt i32 3, 0
  br i1 %v7, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v8 = add i32 3, 1
  %v9 = getelementptr inbounds i32, i32* %v4, i32 %v8
  %v10 = load i32, i32* %v9
  %v11 = add i32 %v3, %v10
  ret i32 %v11
}

define i1 @A__t3(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = alloca i32
  store i32 0, i32* %v1
  %v2 = alloca i32
  store i32 0, i32* %v2
  store i32 2, i32* %v1
  store i32 2, i32* %v2
  %v3 = add i32 349, 908
  %v4 = load i32, i32* %v1
  %v5 = mul i32 23, %v4
  %v6 = load i32, i32* %v2
  %v7 = sub i32 %v6, 2
  %v8 = sub i32 %v5, %v7
  %v9 = icmp slt i32 %v3, %v8
  ret i1 %v9
}

define i1 @A__t4(i8* %v0, i32 %v1, i32* %v2) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v3 = alloca i32
  store i32 %v1, i32* %v3
  %v4 = alloca i32*
  store i32* %v2, i32** %v4
  %v5 = alloca i32*
  store i32* null, i32** %v5
  %v6 = icmp slt i32 10, 0
  br i1 %v6, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v7 = add i32 10, 1
  %v8 = mul i32 %v7, 4
  %v9 = call i8* @calloc(i32 1, i32 %v8)
  %v10 = bitcast i8* %v9 to i32*
  store i32 10, i32* %v10
  store i32* %v10, i32** %v5
  %v11 = bitcast i8* %v0 to i8***
  %v12 = load i8**, i8*** %v11
  %v13 = getelementptr inbounds i8*, i8** %v12, i32 1
  %v14 = load i8*, i8** %v13
  %v15 = bitcast i8* %v14 to i32(i8*)*
  ; A__t2
  %v16 = call i32 %v15(i8* %v0)
  %v17 = add i32 29347, %v16
  %v18 = icmp slt i32 %v17, 12
  br i1 %v18, label %and, label %and_end

and:
  %v19 = load i32, i32* %v3
  %v20 = load i32*, i32** %v5
  %v21 = load i32, i32* %v20
  %v22 = icmp sge i32 0, %v21
  br i1 %v22, label %bounds, label %bounds_end

bounds:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end:
  %v23 = icmp slt i32 0, 0
  br i1 %v23, label %neg_index1, label %neg_index_end1

neg_index1:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end1:
  %v24 = add i32 0, 1
  %v25 = getelementptr inbounds i32, i32* %v20, i32 %v24
  %v26 = load i32, i32* %v25
  %v27 = icmp slt i32 %v19, %v26
  br i1 %v27, label %and1, label %and_end1

and1:
  %v28 = bitcast i8* %v0 to i8***
  %v29 = load i8**, i8*** %v28
  %v30 = getelementptr inbounds i8*, i8** %v29, i32 3
  %v31 = load i8*, i8** %v30
  %v32 = bitcast i8* %v31 to i1(i8*)*
  ; A__t3
  %v33 = call i1 %v32(i8* %v0)
  br label %and_end1

and_end1:
  %v34 = phi i1 [ false, %neg_index_end1 ], [ %v33, %and1 ]
  br i1 %v34, label %and2, label %and_end2

and2:
  %v35 = bitcast i8* %v0 to i8***
  %v36 = load i8**, i8*** %v35
  %v37 = getelementptr inbounds i8*, i8** %v36, i32 1
  %v38 = load i8*, i8** %v37
  %v39 = bitcast i8* %v38 to i32(i8*)*
  ; A__t2
  %v40 = call i32 %v39(i8* %v0)
  %v41 = load i32*, i32** %v5
  %v42 = bitcast i8* %v0 to i8***
  %v43 = load i8**, i8*** %v42
  %v44 = getelementptr inbounds i8*, i8** %v43, i32 4
  %v45 = load i8*, i8** %v44
  %v46 = bitcast i8* %v45 to i1(i8*, i32, i32*)*
  ; A__t4
  %v47 = call i1 %v46(i8* %v0, i32 %v40, i32* %v41)
  br label %and_end2

and_end2:
  %v48 = phi i1 [ false, %and_end1 ], [ %v47, %and2 ]
  br label %and_end

and_end:
  %v49 = phi i1 [ false, %neg_index_end ], [ %v48, %and_end2 ]
  ret i1 %v49
}

define i32 @A__t5(i8* %v0, i32* %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i32*
  store i32* %v1, i32** %v2
  %v3 = alloca i32
  store i32 0, i32* %v3
  %v4 = bitcast i8* %v0 to i8***
  %v5 = load i8**, i8*** %v4
  %v6 = getelementptr inbounds i8*, i8** %v5, i32 1
  %v7 = load i8*, i8** %v6
  %v8 = bitcast i8* %v7 to i32(i8*)*
  ; A__t2
  %v9 = call i32 %v8(i8* %v0)
  %v10 = load i32*, i32** %v2
  %v11 = load i32, i32* %v10
  %v12 = icmp sge i32 0, %v11
  br i1 %v12, label %bounds, label %bounds_end

bounds:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end:
  %v13 = icmp slt i32 0, 0
  br i1 %v13, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v14 = add i32 0, 1
  %v15 = getelementptr inbounds i32, i32* %v10, i32 %v14
  %v16 = load i32, i32* %v15
  %v17 = icmp slt i32 %v16, 0
  br i1 %v17, label %neg_index1, label %neg_index_end1

neg_index1:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end1:
  %v18 = add i32 %v16, 1
  %v19 = mul i32 %v18, 4
  %v20 = call i8* @calloc(i32 1, i32 %v19)
  %v21 = bitcast i8* %v20 to i32*
  store i32 %v16, i32* %v21
  %v22 = bitcast i8* %v0 to i8***
  %v23 = load i8**, i8*** %v22
  %v24 = getelementptr inbounds i8*, i8** %v23, i32 2
  %v25 = load i8*, i8** %v24
  %v26 = bitcast i8* %v25 to i32(i8*, i32*)*
  ; A__lispy
  %v27 = call i32 %v26(i8* %v0, i32* %v21)
  %v28 = add i32 %v9, %v27
  %v29 = icmp slt i32 %v28, 0
  br i1 %v29, label %neg_index2, label %neg_index_end2

neg_index2:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end2:
  %v30 = add i32 %v28, 1
  %v31 = mul i32 %v30, 4
  %v32 = call i8* @calloc(i32 1, i32 %v31)
  %v33 = bitcast i8* %v32 to i32*
  store i32 %v28, i32* %v33
  %v34 = load i32, i32* %v33
  %v35 = icmp sge i32 0, %v34
  br i1 %v35, label %bounds1, label %bounds_end1

bounds1:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end1:
  %v36 = icmp slt i32 0, 0
  br i1 %v36, label %neg_index3, label %neg_index_end3

neg_index3:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end3:
  %v37 = add i32 0, 1
  %v38 = getelementptr inbounds i32, i32* %v33, i32 %v37
  %v39 = load i32, i32* %v38
  %v40 = add i32 %v39, 10
  %v41 = icmp slt i32 %v40, 0
  br i1 %v41, label %neg_index4, label %neg_index_end4

neg_index4:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end4:
  %v42 = add i32 %v40, 1
  %v43 = mul i32 %v42, 4
  %v44 = call i8* @calloc(i32 1, i32 %v43)
  %v45 = bitcast i8* %v44 to i32*
  store i32 %v40, i32* %v45
  %v46 = load i32, i32* %v45
  %v47 = icmp sge i32 2, %v46
  br i1 %v47, label %bounds2, label %bounds_end2

bounds2:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end2:
  %v48 = icmp slt i32 2, 0
  br i1 %v48, label %neg_index5, label %neg_index_end5

neg_index5:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end5:
  %v49 = add i32 2, 1
  %v50 = getelementptr inbounds i32, i32* %v45, i32 %v49
  %v51 = load i32, i32* %v50
  store i32 %v51, i32* %v3
  %v52 = load i32*, i32** %v2
  %v53 = load i32, i32* %v3
  %v54 = load i32, i32* %v52
  %v55 = icmp sge i32 %v53, %v54
  br i1 %v55, label %bounds3, label %bounds_end3

bounds3:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end3:
  %v56 = icmp slt i32 %v53, 0
  br i1 %v56, label %neg_index6, label %neg_index_end6

neg_index6:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end6:
  %v57 = add i32 %v53, 1
  %v58 = getelementptr inbounds i32, i32* %v52, i32 %v57
  %v59 = load i32, i32* %v58
  ret i32 %v59
}

define i1 @A__t6(i8* %v0, i1 %v1, i32* %v2) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v3 = alloca i1
  store i1 %v1, i1* %v3
  %v4 = alloca i32*
  store i32* %v2, i32** %v4
  %v5 = alloca i32
  store i32 0, i32* %v5
  %v6 = alloca %class.C*
  store %class.C* null, %class.C** %v6
  store i32 2, i32* %v5
  %v7 = call i8* @calloc(i32 1, i32 8)
  %v8 = bitcast i8* %v7 to [1 x i8*]**
  store [1 x i8*]* @C__vtable, [1 x i8*]** %v8
  %v9 = bitcast i8* %v7 to %class.C*
  store %class.C* %v9, %class.C** %v6
  %v10 = bitcast i8* %v0 to i8***
  %v11 = load i8**, i8*** %v10
  %v12 = getelementptr inbounds i8*, i8** %v11, i32 1
  %v13 = load i8*, i8** %v12
  %v14 = bitcast i8* %v13 to i32(i8*)*
  ; A__t2
  %v15 = call i32 %v14(i8* %v0)
  %v16 = add i32 29347, %v15
  %v17 = icmp slt i32 %v16, 12
  br i1 %v17, label %and, label %and_end

and:
  %v18 = load i32, i32* %v5
  %v19 = load i32*, i32** %v4
  %v20 = load i32, i32* %v19
  %v21 = icmp sge i32 0, %v20
  br i1 %v21, label %bounds, label %bounds_end

bounds:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end:
  %v22 = icmp slt i32 0, 0
  br i1 %v22, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v23 = add i32 0, 1
  %v24 = getelementptr inbounds i32, i32* %v19, i32 %v23
  %v25 = load i32, i32* %v24
  %v26 = icmp slt i32 %v18, %v25
  br i1 %v26, label %and1, label %and_end1

and1:
  %v27 = bitcast i8* %v0 to i8***
  %v28 = load i8**, i8*** %v27
  %v29 = getelementptr inbounds i8*, i8** %v28, i32 3
  %v30 = load i8*, i8** %v29
  %v31 = bitcast i8* %v30 to i1(i8*)*
  ; A__t3
  %v32 = call i1 %v31(i8* %v0)
  br label %and_end1

and_end1:
  %v33 = phi i1 [ false, %neg_index_end ], [ %v32, %and1 ]
  br i1 %v33, label %and2, label %and_end2

and2:
  %v34 = call i8* @calloc(i32 1, i32 8)
  %v35 = bitcast i8* %v34 to [2 x i8*]**
  store [2 x i8*]* @B__vtable, [2 x i8*]** %v35
  %v36 = bitcast i8* %v34 to %class.B*
  %v37 = bitcast %class.B* %v36 to i8***
  %v38 = load i8**, i8*** %v37
  %v39 = load i8*, i8** %v38
  %v40 = bitcast i8* %v39 to i32*(i8*, i1)*
  %v41 = bitcast %class.B* %v36 to i8*
  ; B__test
  %v42 = call i32* %v40(i8* %v41, i1 true)
  %v43 = load i32, i32* %v42
  %v44 = icmp sge i32 0, %v43
  br i1 %v44, label %bounds1, label %bounds_end1

bounds1:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end1:
  %v45 = icmp slt i32 0, 0
  br i1 %v45, label %neg_index1, label %neg_index_end1

neg_index1:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end1:
  %v46 = add i32 0, 1
  %v47 = getelementptr inbounds i32, i32* %v42, i32 %v46
  %v48 = load i32, i32* %v47
  %v49 = load i32*, i32** %v4
  %v50 = bitcast i8* %v0 to i8***
  %v51 = load i8**, i8*** %v50
  %v52 = getelementptr inbounds i8*, i8** %v51, i32 4
  %v53 = load i8*, i8** %v52
  %v54 = bitcast i8* %v53 to i1(i8*, i32, i32*)*
  ; A__t4
  %v55 = call i1 %v54(i8* %v0, i32 %v48, i32* %v49)
  %v56 = load i32*, i32** %v4
  %v57 = load i32, i32* %v56
  %v58 = icmp sge i32 0, %v57
  br i1 %v58, label %bounds2, label %bounds_end2

bounds2:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

bounds_end2:
  %v59 = icmp slt i32 0, 0
  br i1 %v59, label %neg_index2, label %neg_index_end2

neg_index2:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end2:
  %v60 = add i32 0, 1
  %v61 = getelementptr inbounds i32, i32* %v56, i32 %v60
  %v62 = load i32, i32* %v61
  %v63 = icmp slt i32 %v62, 0
  br i1 %v63, label %neg_index3, label %neg_index_end3

neg_index3:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end3:
  %v64 = add i32 %v62, 1
  %v65 = mul i32 %v64, 4
  %v66 = call i8* @calloc(i32 1, i32 %v65)
  %v67 = bitcast i8* %v66 to i32*
  store i32 %v62, i32* %v67
  %v68 = bitcast i8* %v0 to i8***
  %v69 = load i8**, i8*** %v68
  %v70 = getelementptr inbounds i8*, i8** %v69, i32 6
  %v71 = load i8*, i8** %v70
  %v72 = bitcast i8* %v71 to i1(i8*, i1, i32*)*
  ; A__t6
  %v73 = call i1 %v72(i8* %v0, i1 %v55, i32* %v67)
  br label %and_end2

and_end2:
  %v74 = phi i1 [ false, %and_end1 ], [ %v73, %neg_index_end3 ]
  br label %and_end

and_end:
  %v75 = phi i1 [ false, %entry ], [ %v74, %and_end2 ]
  ret i1 %v75
}

@B__vtable = global [2 x i8*] [
  i8* bitcast (i32*(i8*, i1)* @C__test to i8*),
  i8* bitcast (i32*(i8*, i32)* @B__test2 to i8*)
]

define i32* @B__test2(i8* %v0, i32 %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i32
  store i32 %v1, i32* %v2
  %v3 = load i32, i32* %v2
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
  ret i32* %v8
}

@C__vtable = global [1 x i8*] [
  i8* bitcast (i32*(i8*, i1)* @C__test to i8*)
]

define i32* @C__test(i8* %v0, i1 %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i1
  store i1 %v1, i1* %v2
  %v3 = icmp slt i32 10, 0
  br i1 %v3, label %neg_index, label %neg_index_end

neg_index:
  call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.out, i64 0, i64 0))
  call void @exit(i32 1)
  unreachable

neg_index_end:
  %v4 = add i32 10, 1
  %v5 = mul i32 %v4, 4
  %v6 = call i8* @calloc(i32 1, i32 %v5)
  %v7 = bitcast i8* %v6 to i32*
  store i32 10, i32* %v7
  ret i32* %v7
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  ret i32 0
}

