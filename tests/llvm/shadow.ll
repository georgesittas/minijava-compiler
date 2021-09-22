%class.A = type { i8*, i32, i32 }
%class.B = type { %class.A, i32 }
%class.C = type { i8*, i32 }
%class.D = type { %class.C, i1 }
%class.E = type { %class.D, i1 }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [3 x i8*] [
  i8* bitcast (i1(i8*)* @A__set_x to i8*),
  i8* bitcast (i32(i8*)* @A__x to i8*),
  i8* bitcast (i32(i8*)* @A__y to i8*)
]

define i1 @A__set_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 8
  %v2 = bitcast i8* %v1 to i32*
  store i32 1, i32* %v2
  ret i1 true
}

define i32 @A__x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 8
  %v2 = bitcast i8* %v1 to i32*
  %v3 = load i32, i32* %v2
  ret i32 %v3
}

define i32 @A__y(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 12
  %v2 = bitcast i8* %v1 to i32*
  %v3 = load i32, i32* %v2
  ret i32 %v3
}

@B__vtable = global [3 x i8*] [
  i8* bitcast (i1(i8*)* @B__set_x to i8*),
  i8* bitcast (i32(i8*)* @B__x to i8*),
  i8* bitcast (i32(i8*)* @A__y to i8*)
]

define i1 @B__set_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 16
  %v2 = bitcast i8* %v1 to i32*
  store i32 2, i32* %v2
  ret i1 true
}

define i32 @B__x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 16
  %v2 = bitcast i8* %v1 to i32*
  %v3 = load i32, i32* %v2
  ret i32 %v3
}

@C__vtable = global [3 x i8*] [
  i8* bitcast (i32(i8*)* @C__get_class_x to i8*),
  i8* bitcast (i32(i8*)* @C__get_method_x to i8*),
  i8* bitcast (i1(i8*)* @C__set_int_x to i8*)
]

define i32 @C__get_class_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 8
  %v2 = bitcast i8* %v1 to i32*
  %v3 = load i32, i32* %v2
  ret i32 %v3
}

define i32 @C__get_method_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = alloca i32
  store i32 0, i32* %v1
  store i32 3, i32* %v1
  %v2 = load i32, i32* %v1
  ret i32 %v2
}

define i1 @C__set_int_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 8
  %v2 = bitcast i8* %v1 to i32*
  store i32 20, i32* %v2
  ret i1 true
}

@D__vtable = global [4 x i8*] [
  i8* bitcast (i32(i8*)* @C__get_class_x to i8*),
  i8* bitcast (i32(i8*)* @C__get_method_x to i8*),
  i8* bitcast (i1(i8*)* @C__set_int_x to i8*),
  i8* bitcast (i1(i8*)* @D__get_class_x2 to i8*)
]

define i1 @D__get_class_x2(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 12
  %v2 = bitcast i8* %v1 to i1*
  %v3 = load i1, i1* %v2
  ret i1 %v3
}

@E__vtable = global [6 x i8*] [
  i8* bitcast (i32(i8*)* @C__get_class_x to i8*),
  i8* bitcast (i32(i8*)* @C__get_method_x to i8*),
  i8* bitcast (i1(i8*)* @C__set_int_x to i8*),
  i8* bitcast (i1(i8*)* @D__get_class_x2 to i8*),
  i8* bitcast (i1(i8*)* @E__set_bool_x to i8*),
  i8* bitcast (i1(i8*)* @E__get_bool_x to i8*)
]

define i1 @E__set_bool_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 13
  %v2 = bitcast i8* %v1 to i1*
  store i1 true, i1* %v2
  ret i1 true
}

define i1 @E__get_bool_x(i8* %v0) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v1 = getelementptr inbounds i8, i8* %v0, i32 13
  %v2 = bitcast i8* %v1 to i1*
  %v3 = load i1, i1* %v2
  ret i1 %v3
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca %class.A*
  store %class.A* null, %class.A** %v0
  %v1 = alloca %class.C*
  store %class.C* null, %class.C** %v1
  %v2 = alloca %class.D*
  store %class.D* null, %class.D** %v2
  %v3 = alloca %class.E*
  store %class.E* null, %class.E** %v3
  %v4 = alloca i1
  store i1 false, i1* %v4
  %v5 = call i8* @calloc(i32 1, i32 16)
  %v6 = bitcast i8* %v5 to [3 x i8*]**
  store [3 x i8*]* @A__vtable, [3 x i8*]** %v6
  %v7 = bitcast i8* %v5 to %class.A*
  store %class.A* %v7, %class.A** %v0
  %v8 = load %class.A*, %class.A** %v0
  %v9 = bitcast %class.A* %v8 to i8***
  %v10 = load i8**, i8*** %v9
  %v11 = load i8*, i8** %v10
  %v12 = bitcast i8* %v11 to i1(i8*)*
  %v13 = bitcast %class.A* %v8 to i8*
  ; A__set_x
  %v14 = call i1 %v12(i8* %v13)
  store i1 %v14, i1* %v4
  %v15 = load %class.A*, %class.A** %v0
  %v16 = bitcast %class.A* %v15 to i8***
  %v17 = load i8**, i8*** %v16
  %v18 = getelementptr inbounds i8*, i8** %v17, i32 1
  %v19 = load i8*, i8** %v18
  %v20 = bitcast i8* %v19 to i32(i8*)*
  %v21 = bitcast %class.A* %v15 to i8*
  ; A__x
  %v22 = call i32 %v20(i8* %v21)
  %v23 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v23, i32 %v22)
  %v24 = load %class.A*, %class.A** %v0
  %v25 = bitcast %class.A* %v24 to i8***
  %v26 = load i8**, i8*** %v25
  %v27 = getelementptr inbounds i8*, i8** %v26, i32 2
  %v28 = load i8*, i8** %v27
  %v29 = bitcast i8* %v28 to i32(i8*)*
  %v30 = bitcast %class.A* %v24 to i8*
  ; A__y
  %v31 = call i32 %v29(i8* %v30)
  %v32 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v32, i32 %v31)
  %v33 = call i8* @calloc(i32 1, i32 20)
  %v34 = bitcast i8* %v33 to [3 x i8*]**
  store [3 x i8*]* @B__vtable, [3 x i8*]** %v34
  %v35 = bitcast i8* %v33 to %class.B*
  %v36 = bitcast %class.B* %v35 to %class.A*
  store %class.A* %v36, %class.A** %v0
  %v37 = load %class.A*, %class.A** %v0
  %v38 = bitcast %class.A* %v37 to i8***
  %v39 = load i8**, i8*** %v38
  %v40 = load i8*, i8** %v39
  %v41 = bitcast i8* %v40 to i1(i8*)*
  %v42 = bitcast %class.A* %v37 to i8*
  ; A__set_x
  %v43 = call i1 %v41(i8* %v42)
  store i1 %v43, i1* %v4
  %v44 = load %class.A*, %class.A** %v0
  %v45 = bitcast %class.A* %v44 to i8***
  %v46 = load i8**, i8*** %v45
  %v47 = getelementptr inbounds i8*, i8** %v46, i32 1
  %v48 = load i8*, i8** %v47
  %v49 = bitcast i8* %v48 to i32(i8*)*
  %v50 = bitcast %class.A* %v44 to i8*
  ; A__x
  %v51 = call i32 %v49(i8* %v50)
  %v52 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v52, i32 %v51)
  %v53 = load %class.A*, %class.A** %v0
  %v54 = bitcast %class.A* %v53 to i8***
  %v55 = load i8**, i8*** %v54
  %v56 = getelementptr inbounds i8*, i8** %v55, i32 2
  %v57 = load i8*, i8** %v56
  %v58 = bitcast i8* %v57 to i32(i8*)*
  %v59 = bitcast %class.A* %v53 to i8*
  ; A__y
  %v60 = call i32 %v58(i8* %v59)
  %v61 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v61, i32 %v60)
  %v62 = call i8* @calloc(i32 1, i32 12)
  %v63 = bitcast i8* %v62 to [3 x i8*]**
  store [3 x i8*]* @C__vtable, [3 x i8*]** %v63
  %v64 = bitcast i8* %v62 to %class.C*
  store %class.C* %v64, %class.C** %v1
  %v65 = load %class.C*, %class.C** %v1
  %v66 = bitcast %class.C* %v65 to i8***
  %v67 = load i8**, i8*** %v66
  %v68 = getelementptr inbounds i8*, i8** %v67, i32 1
  %v69 = load i8*, i8** %v68
  %v70 = bitcast i8* %v69 to i32(i8*)*
  %v71 = bitcast %class.C* %v65 to i8*
  ; C__get_method_x
  %v72 = call i32 %v70(i8* %v71)
  %v73 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v73, i32 %v72)
  %v74 = load %class.C*, %class.C** %v1
  %v75 = bitcast %class.C* %v74 to i8***
  %v76 = load i8**, i8*** %v75
  %v77 = load i8*, i8** %v76
  %v78 = bitcast i8* %v77 to i32(i8*)*
  %v79 = bitcast %class.C* %v74 to i8*
  ; C__get_class_x
  %v80 = call i32 %v78(i8* %v79)
  %v81 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v81, i32 %v80)
  %v82 = call i8* @calloc(i32 1, i32 13)
  %v83 = bitcast i8* %v82 to [4 x i8*]**
  store [4 x i8*]* @D__vtable, [4 x i8*]** %v83
  %v84 = bitcast i8* %v82 to %class.D*
  store %class.D* %v84, %class.D** %v2
  %v85 = load %class.D*, %class.D** %v2
  %v86 = bitcast %class.D* %v85 to i8***
  %v87 = load i8**, i8*** %v86
  %v88 = getelementptr inbounds i8*, i8** %v87, i32 2
  %v89 = load i8*, i8** %v88
  %v90 = bitcast i8* %v89 to i1(i8*)*
  %v91 = bitcast %class.D* %v85 to i8*
  ; D__set_int_x
  %v92 = call i1 %v90(i8* %v91)
  store i1 %v92, i1* %v4
  %v93 = load %class.D*, %class.D** %v2
  %v94 = bitcast %class.D* %v93 to i8***
  %v95 = load i8**, i8*** %v94
  %v96 = getelementptr inbounds i8*, i8** %v95, i32 3
  %v97 = load i8*, i8** %v96
  %v98 = bitcast i8* %v97 to i1(i8*)*
  %v99 = bitcast %class.D* %v93 to i8*
  ; D__get_class_x2
  %v100 = call i1 %v98(i8* %v99)
  br i1 %v100, label %if, label %else

if:
  %v101 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v101, i32 1)
  br label %if_end

else:
  %v102 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v102, i32 0)
  br label %if_end

if_end:
  %v103 = call i8* @calloc(i32 1, i32 14)
  %v104 = bitcast i8* %v103 to [6 x i8*]**
  store [6 x i8*]* @E__vtable, [6 x i8*]** %v104
  %v105 = bitcast i8* %v103 to %class.E*
  store %class.E* %v105, %class.E** %v3
  %v106 = load %class.E*, %class.E** %v3
  %v107 = bitcast %class.E* %v106 to i8***
  %v108 = load i8**, i8*** %v107
  %v109 = getelementptr inbounds i8*, i8** %v108, i32 2
  %v110 = load i8*, i8** %v109
  %v111 = bitcast i8* %v110 to i1(i8*)*
  %v112 = bitcast %class.E* %v106 to i8*
  ; E__set_int_x
  %v113 = call i1 %v111(i8* %v112)
  store i1 %v113, i1* %v4
  %v114 = load %class.E*, %class.E** %v3
  %v115 = bitcast %class.E* %v114 to i8***
  %v116 = load i8**, i8*** %v115
  %v117 = getelementptr inbounds i8*, i8** %v116, i32 3
  %v118 = load i8*, i8** %v117
  %v119 = bitcast i8* %v118 to i1(i8*)*
  %v120 = bitcast %class.E* %v114 to i8*
  ; E__get_class_x2
  %v121 = call i1 %v119(i8* %v120)
  br i1 %v121, label %if1, label %else1

if1:
  %v122 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v122, i32 1)
  br label %if_end1

else1:
  %v123 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v123, i32 0)
  br label %if_end1

if_end1:
  %v124 = load %class.E*, %class.E** %v3
  %v125 = bitcast %class.E* %v124 to i8***
  %v126 = load i8**, i8*** %v125
  %v127 = getelementptr inbounds i8*, i8** %v126, i32 4
  %v128 = load i8*, i8** %v127
  %v129 = bitcast i8* %v128 to i1(i8*)*
  %v130 = bitcast %class.E* %v124 to i8*
  ; E__set_bool_x
  %v131 = call i1 %v129(i8* %v130)
  store i1 %v131, i1* %v4
  %v132 = load %class.E*, %class.E** %v3
  %v133 = bitcast %class.E* %v132 to i8***
  %v134 = load i8**, i8*** %v133
  %v135 = getelementptr inbounds i8*, i8** %v134, i32 5
  %v136 = load i8*, i8** %v135
  %v137 = bitcast i8* %v136 to i1(i8*)*
  %v138 = bitcast %class.E* %v132 to i8*
  ; E__get_bool_x
  %v139 = call i1 %v137(i8* %v138)
  br i1 %v139, label %if2, label %else2

if2:
  %v140 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v140, i32 1)
  br label %if_end2

else2:
  %v141 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v141, i32 0)
  br label %if_end2

if_end2:
  ret i32 0
}

