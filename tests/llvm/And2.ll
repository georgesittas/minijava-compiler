%class.A = type { i8* }
%class.B = type { i8* }

declare i8* @calloc(i32, i32)
declare void @exit(i32)
declare i32 @printf(i8*, ...)
@.str = constant [4 x i8] c"%d\0A\00"

@.out = private unnamed_addr constant [15 x i8] c"Out of bounds\0A\00"

%bool_array = type { i32, i8* }

@A__vtable = global [3 x i8*] [
  i8* bitcast (i1(i8*, i1, i1, i1)* @A__foo to i8*),
  i8* bitcast (i1(i8*, i1, i1)* @A__bar to i8*),
  i8* bitcast (i1(i8*, i1)* @A__print to i8*)
]

define i1 @A__foo(i8* %v0, i1 %v1, i1 %v2, i1 %v3) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v4 = alloca i1
  store i1 %v1, i1* %v4
  %v5 = alloca i1
  store i1 %v2, i1* %v5
  %v6 = alloca i1
  store i1 %v3, i1* %v6
  %v7 = load i1, i1* %v4
  br i1 %v7, label %and, label %and_end

and:
  %v8 = load i1, i1* %v5
  br label %and_end

and_end:
  %v9 = phi i1 [ false, %entry ], [ %v8, %and ]
  br i1 %v9, label %and1, label %and_end1

and1:
  %v10 = load i1, i1* %v6
  br label %and_end1

and_end1:
  %v11 = phi i1 [ false, %and_end ], [ %v10, %and1 ]
  ret i1 %v11
}

define i1 @A__bar(i8* %v0, i1 %v1, i1 %v2) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v3 = alloca i1
  store i1 %v1, i1* %v3
  %v4 = alloca i1
  store i1 %v2, i1* %v4
  %v5 = load i1, i1* %v3
  br i1 %v5, label %and, label %and_end

and:
  %v6 = load i1, i1* %v3
  %v7 = load i1, i1* %v4
  %v8 = bitcast i8* %v0 to i8***
  %v9 = load i8**, i8*** %v8
  %v10 = load i8*, i8** %v9
  %v11 = bitcast i8* %v10 to i1(i8*, i1, i1, i1)*
  ; A__foo
  %v12 = call i1 %v11(i8* %v0, i1 %v6, i1 %v7, i1 true)
  br label %and_end

and_end:
  %v13 = phi i1 [ false, %entry ], [ %v12, %and ]
  br i1 %v13, label %and1, label %and_end1

and1:
  %v14 = load i1, i1* %v4
  br label %and_end1

and_end1:
  %v15 = phi i1 [ false, %and_end ], [ %v14, %and1 ]
  ret i1 %v15
}

define i1 @A__print(i8* %v0, i1 %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i1
  store i1 %v1, i1* %v2
  %v3 = load i1, i1* %v2
  br i1 %v3, label %if, label %else

if:
  %v4 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v4, i32 1)
  br label %if_end

else:
  %v5 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v5, i32 0)
  br label %if_end

if_end:
  ret i1 true
}

@B__vtable = global [2 x i8*] [
  i8* bitcast (i1(i8*, i32)* @B__foo to i8*),
  i8* bitcast (i1(i8*, i32, i32, i1, i1)* @B__t to i8*)
]

define i1 @B__foo(i8* %v0, i32 %v1) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v2 = alloca i32
  store i32 %v1, i32* %v2
  %v3 = load i32, i32* %v2
  %v4 = add i32 %v3, 2
  %v5 = icmp slt i32 3, %v4
  %v6 = icmp eq i1 %v5, false
  br i1 %v6, label %and, label %and_end

and:
  %v7 = icmp eq i1 false, false
  br label %and_end

and_end:
  %v8 = phi i1 [ false, %entry ], [ %v7, %and ]
  ret i1 %v8
}

define i1 @B__t(i8* %v0, i32 %v1, i32 %v2, i1 %v3, i1 %v4) {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v5 = alloca i32
  store i32 %v1, i32* %v5
  %v6 = alloca i32
  store i32 %v2, i32* %v6
  %v7 = alloca i1
  store i1 %v3, i1* %v7
  %v8 = alloca i1
  store i1 %v4, i1* %v8
  %v9 = load i32, i32* %v5
  %v10 = load i32, i32* %v6
  %v11 = icmp slt i32 %v9, %v10
  %v12 = icmp eq i1 %v11, false
  br i1 %v12, label %and, label %and_end

and:
  %v13 = load i1, i1* %v7
  br i1 %v13, label %and1, label %and_end1

and1:
  %v14 = load i1, i1* %v8
  br label %and_end1

and_end1:
  %v15 = phi i1 [ false, %and ], [ %v14, %and1 ]
  br label %and_end

and_end:
  %v16 = phi i1 [ false, %entry ], [ %v15, %and_end1 ]
  ret i1 %v16
}

define i32 @main() {
entry:
  ; Allocate stack space for all locals (params and vars).
  ; Initialize params to the passed argument and vars to 0.
  %v0 = alloca i1
  store i1 false, i1* %v0
  %v1 = alloca %class.A*
  store %class.A* null, %class.A** %v1
  %v2 = call i8* @calloc(i32 1, i32 8)
  %v3 = bitcast i8* %v2 to [3 x i8*]**
  store [3 x i8*]* @A__vtable, [3 x i8*]** %v3
  %v4 = bitcast i8* %v2 to %class.A*
  store %class.A* %v4, %class.A** %v1
  %v5 = load %class.A*, %class.A** %v1
  %v6 = load %class.A*, %class.A** %v1
  %v7 = bitcast %class.A* %v6 to i8***
  %v8 = load i8**, i8*** %v7
  %v9 = load i8*, i8** %v8
  %v10 = bitcast i8* %v9 to i1(i8*, i1, i1, i1)*
  %v11 = bitcast %class.A* %v6 to i8*
  ; A__foo
  %v12 = call i1 %v10(i8* %v11, i1 false, i1 false, i1 false)
  %v13 = bitcast %class.A* %v5 to i8***
  %v14 = load i8**, i8*** %v13
  %v15 = getelementptr inbounds i8*, i8** %v14, i32 2
  %v16 = load i8*, i8** %v15
  %v17 = bitcast i8* %v16 to i1(i8*, i1)*
  %v18 = bitcast %class.A* %v5 to i8*
  ; A__print
  %v19 = call i1 %v17(i8* %v18, i1 %v12)
  store i1 %v19, i1* %v0
  %v20 = load %class.A*, %class.A** %v1
  %v21 = load %class.A*, %class.A** %v1
  %v22 = bitcast %class.A* %v21 to i8***
  %v23 = load i8**, i8*** %v22
  %v24 = load i8*, i8** %v23
  %v25 = bitcast i8* %v24 to i1(i8*, i1, i1, i1)*
  %v26 = bitcast %class.A* %v21 to i8*
  ; A__foo
  %v27 = call i1 %v25(i8* %v26, i1 false, i1 false, i1 true)
  %v28 = bitcast %class.A* %v20 to i8***
  %v29 = load i8**, i8*** %v28
  %v30 = getelementptr inbounds i8*, i8** %v29, i32 2
  %v31 = load i8*, i8** %v30
  %v32 = bitcast i8* %v31 to i1(i8*, i1)*
  %v33 = bitcast %class.A* %v20 to i8*
  ; A__print
  %v34 = call i1 %v32(i8* %v33, i1 %v27)
  store i1 %v34, i1* %v0
  %v35 = load %class.A*, %class.A** %v1
  %v36 = load %class.A*, %class.A** %v1
  %v37 = bitcast %class.A* %v36 to i8***
  %v38 = load i8**, i8*** %v37
  %v39 = load i8*, i8** %v38
  %v40 = bitcast i8* %v39 to i1(i8*, i1, i1, i1)*
  %v41 = bitcast %class.A* %v36 to i8*
  ; A__foo
  %v42 = call i1 %v40(i8* %v41, i1 false, i1 true, i1 false)
  %v43 = bitcast %class.A* %v35 to i8***
  %v44 = load i8**, i8*** %v43
  %v45 = getelementptr inbounds i8*, i8** %v44, i32 2
  %v46 = load i8*, i8** %v45
  %v47 = bitcast i8* %v46 to i1(i8*, i1)*
  %v48 = bitcast %class.A* %v35 to i8*
  ; A__print
  %v49 = call i1 %v47(i8* %v48, i1 %v42)
  store i1 %v49, i1* %v0
  %v50 = load %class.A*, %class.A** %v1
  %v51 = load %class.A*, %class.A** %v1
  %v52 = bitcast %class.A* %v51 to i8***
  %v53 = load i8**, i8*** %v52
  %v54 = load i8*, i8** %v53
  %v55 = bitcast i8* %v54 to i1(i8*, i1, i1, i1)*
  %v56 = bitcast %class.A* %v51 to i8*
  ; A__foo
  %v57 = call i1 %v55(i8* %v56, i1 false, i1 true, i1 true)
  %v58 = bitcast %class.A* %v50 to i8***
  %v59 = load i8**, i8*** %v58
  %v60 = getelementptr inbounds i8*, i8** %v59, i32 2
  %v61 = load i8*, i8** %v60
  %v62 = bitcast i8* %v61 to i1(i8*, i1)*
  %v63 = bitcast %class.A* %v50 to i8*
  ; A__print
  %v64 = call i1 %v62(i8* %v63, i1 %v57)
  store i1 %v64, i1* %v0
  %v65 = load %class.A*, %class.A** %v1
  %v66 = load %class.A*, %class.A** %v1
  %v67 = bitcast %class.A* %v66 to i8***
  %v68 = load i8**, i8*** %v67
  %v69 = load i8*, i8** %v68
  %v70 = bitcast i8* %v69 to i1(i8*, i1, i1, i1)*
  %v71 = bitcast %class.A* %v66 to i8*
  ; A__foo
  %v72 = call i1 %v70(i8* %v71, i1 true, i1 false, i1 false)
  %v73 = bitcast %class.A* %v65 to i8***
  %v74 = load i8**, i8*** %v73
  %v75 = getelementptr inbounds i8*, i8** %v74, i32 2
  %v76 = load i8*, i8** %v75
  %v77 = bitcast i8* %v76 to i1(i8*, i1)*
  %v78 = bitcast %class.A* %v65 to i8*
  ; A__print
  %v79 = call i1 %v77(i8* %v78, i1 %v72)
  store i1 %v79, i1* %v0
  %v80 = load %class.A*, %class.A** %v1
  %v81 = load %class.A*, %class.A** %v1
  %v82 = bitcast %class.A* %v81 to i8***
  %v83 = load i8**, i8*** %v82
  %v84 = load i8*, i8** %v83
  %v85 = bitcast i8* %v84 to i1(i8*, i1, i1, i1)*
  %v86 = bitcast %class.A* %v81 to i8*
  ; A__foo
  %v87 = call i1 %v85(i8* %v86, i1 true, i1 false, i1 true)
  %v88 = bitcast %class.A* %v80 to i8***
  %v89 = load i8**, i8*** %v88
  %v90 = getelementptr inbounds i8*, i8** %v89, i32 2
  %v91 = load i8*, i8** %v90
  %v92 = bitcast i8* %v91 to i1(i8*, i1)*
  %v93 = bitcast %class.A* %v80 to i8*
  ; A__print
  %v94 = call i1 %v92(i8* %v93, i1 %v87)
  store i1 %v94, i1* %v0
  %v95 = load %class.A*, %class.A** %v1
  %v96 = load %class.A*, %class.A** %v1
  %v97 = bitcast %class.A* %v96 to i8***
  %v98 = load i8**, i8*** %v97
  %v99 = load i8*, i8** %v98
  %v100 = bitcast i8* %v99 to i1(i8*, i1, i1, i1)*
  %v101 = bitcast %class.A* %v96 to i8*
  ; A__foo
  %v102 = call i1 %v100(i8* %v101, i1 true, i1 true, i1 false)
  %v103 = bitcast %class.A* %v95 to i8***
  %v104 = load i8**, i8*** %v103
  %v105 = getelementptr inbounds i8*, i8** %v104, i32 2
  %v106 = load i8*, i8** %v105
  %v107 = bitcast i8* %v106 to i1(i8*, i1)*
  %v108 = bitcast %class.A* %v95 to i8*
  ; A__print
  %v109 = call i1 %v107(i8* %v108, i1 %v102)
  store i1 %v109, i1* %v0
  %v110 = load %class.A*, %class.A** %v1
  %v111 = load %class.A*, %class.A** %v1
  %v112 = bitcast %class.A* %v111 to i8***
  %v113 = load i8**, i8*** %v112
  %v114 = load i8*, i8** %v113
  %v115 = bitcast i8* %v114 to i1(i8*, i1, i1, i1)*
  %v116 = bitcast %class.A* %v111 to i8*
  ; A__foo
  %v117 = call i1 %v115(i8* %v116, i1 true, i1 true, i1 true)
  %v118 = bitcast %class.A* %v110 to i8***
  %v119 = load i8**, i8*** %v118
  %v120 = getelementptr inbounds i8*, i8** %v119, i32 2
  %v121 = load i8*, i8** %v120
  %v122 = bitcast i8* %v121 to i1(i8*, i1)*
  %v123 = bitcast %class.A* %v110 to i8*
  ; A__print
  %v124 = call i1 %v122(i8* %v123, i1 %v117)
  store i1 %v124, i1* %v0
  %v125 = load %class.A*, %class.A** %v1
  %v126 = load %class.A*, %class.A** %v1
  %v127 = bitcast %class.A* %v126 to i8***
  %v128 = load i8**, i8*** %v127
  %v129 = getelementptr inbounds i8*, i8** %v128, i32 1
  %v130 = load i8*, i8** %v129
  %v131 = bitcast i8* %v130 to i1(i8*, i1, i1)*
  %v132 = bitcast %class.A* %v126 to i8*
  ; A__bar
  %v133 = call i1 %v131(i8* %v132, i1 true, i1 true)
  %v134 = bitcast %class.A* %v125 to i8***
  %v135 = load i8**, i8*** %v134
  %v136 = getelementptr inbounds i8*, i8** %v135, i32 2
  %v137 = load i8*, i8** %v136
  %v138 = bitcast i8* %v137 to i1(i8*, i1)*
  %v139 = bitcast %class.A* %v125 to i8*
  ; A__print
  %v140 = call i1 %v138(i8* %v139, i1 %v133)
  store i1 %v140, i1* %v0
  %v141 = load %class.A*, %class.A** %v1
  %v142 = load %class.A*, %class.A** %v1
  %v143 = bitcast %class.A* %v142 to i8***
  %v144 = load i8**, i8*** %v143
  %v145 = getelementptr inbounds i8*, i8** %v144, i32 1
  %v146 = load i8*, i8** %v145
  %v147 = bitcast i8* %v146 to i1(i8*, i1, i1)*
  %v148 = bitcast %class.A* %v142 to i8*
  ; A__bar
  %v149 = call i1 %v147(i8* %v148, i1 false, i1 true)
  %v150 = bitcast %class.A* %v141 to i8***
  %v151 = load i8**, i8*** %v150
  %v152 = getelementptr inbounds i8*, i8** %v151, i32 2
  %v153 = load i8*, i8** %v152
  %v154 = bitcast i8* %v153 to i1(i8*, i1)*
  %v155 = bitcast %class.A* %v141 to i8*
  ; A__print
  %v156 = call i1 %v154(i8* %v155, i1 %v149)
  store i1 %v156, i1* %v0
  %v157 = load %class.A*, %class.A** %v1
  %v158 = call i8* @calloc(i32 1, i32 8)
  %v159 = bitcast i8* %v158 to [2 x i8*]**
  store [2 x i8*]* @B__vtable, [2 x i8*]** %v159
  %v160 = bitcast i8* %v158 to %class.B*
  %v161 = bitcast %class.B* %v160 to i8***
  %v162 = load i8**, i8*** %v161
  %v163 = load i8*, i8** %v162
  %v164 = bitcast i8* %v163 to i1(i8*, i32)*
  %v165 = bitcast %class.B* %v160 to i8*
  ; B__foo
  %v166 = call i1 %v164(i8* %v165, i32 1)
  %v167 = bitcast %class.A* %v157 to i8***
  %v168 = load i8**, i8*** %v167
  %v169 = getelementptr inbounds i8*, i8** %v168, i32 2
  %v170 = load i8*, i8** %v169
  %v171 = bitcast i8* %v170 to i1(i8*, i1)*
  %v172 = bitcast %class.A* %v157 to i8*
  ; A__print
  %v173 = call i1 %v171(i8* %v172, i1 %v166)
  store i1 %v173, i1* %v0
  %v174 = load %class.A*, %class.A** %v1
  %v175 = call i8* @calloc(i32 1, i32 8)
  %v176 = bitcast i8* %v175 to [2 x i8*]**
  store [2 x i8*]* @B__vtable, [2 x i8*]** %v176
  %v177 = bitcast i8* %v175 to %class.B*
  %v178 = bitcast %class.B* %v177 to i8***
  %v179 = load i8**, i8*** %v178
  %v180 = load i8*, i8** %v179
  %v181 = bitcast i8* %v180 to i1(i8*, i32)*
  %v182 = bitcast %class.B* %v177 to i8*
  ; B__foo
  %v183 = call i1 %v181(i8* %v182, i32 2)
  %v184 = bitcast %class.A* %v174 to i8***
  %v185 = load i8**, i8*** %v184
  %v186 = getelementptr inbounds i8*, i8** %v185, i32 2
  %v187 = load i8*, i8** %v186
  %v188 = bitcast i8* %v187 to i1(i8*, i1)*
  %v189 = bitcast %class.A* %v174 to i8*
  ; A__print
  %v190 = call i1 %v188(i8* %v189, i1 %v183)
  store i1 %v190, i1* %v0
  %v191 = load %class.A*, %class.A** %v1
  %v192 = call i8* @calloc(i32 1, i32 8)
  %v193 = bitcast i8* %v192 to [2 x i8*]**
  store [2 x i8*]* @B__vtable, [2 x i8*]** %v193
  %v194 = bitcast i8* %v192 to %class.B*
  %v195 = bitcast %class.B* %v194 to i8***
  %v196 = load i8**, i8*** %v195
  %v197 = getelementptr inbounds i8*, i8** %v196, i32 1
  %v198 = load i8*, i8** %v197
  %v199 = bitcast i8* %v198 to i1(i8*, i32, i32, i1, i1)*
  %v200 = bitcast %class.B* %v194 to i8*
  ; B__t
  %v201 = call i1 %v199(i8* %v200, i32 2, i32 2, i1 true, i1 true)
  %v202 = bitcast %class.A* %v191 to i8***
  %v203 = load i8**, i8*** %v202
  %v204 = getelementptr inbounds i8*, i8** %v203, i32 2
  %v205 = load i8*, i8** %v204
  %v206 = bitcast i8* %v205 to i1(i8*, i1)*
  %v207 = bitcast %class.A* %v191 to i8*
  ; A__print
  %v208 = call i1 %v206(i8* %v207, i1 %v201)
  store i1 %v208, i1* %v0
  ret i32 0
}

