
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
  %v0 = alloca i32
  store i32 0, i32* %v0
  %v1 = alloca i32
  store i32 0, i32* %v1
  %v2 = alloca i32
  store i32 0, i32* %v2
  %v3 = alloca i32
  store i32 0, i32* %v3
  %v4 = alloca i32
  store i32 0, i32* %v4
  %v5 = alloca i1
  store i1 false, i1* %v5
  store i32 0, i32* %v4
  store i32 0, i32* %v0
  br label %header

header:
  %v6 = load i32, i32* %v0
  %v7 = icmp slt i32 %v6, 6
  br i1 %v7, label %loop_body, label %exit_block

loop_body:
  store i32 0, i32* %v1
  br label %header1

header1:
  %v8 = load i32, i32* %v1
  %v9 = icmp slt i32 %v8, 5
  br i1 %v9, label %loop_body1, label %exit_block1

loop_body1:
  store i32 0, i32* %v2
  br label %header2

header2:
  %v10 = load i32, i32* %v2
  %v11 = icmp slt i32 %v10, 4
  br i1 %v11, label %loop_body2, label %exit_block2

loop_body2:
  store i32 0, i32* %v3
  br label %header3

header3:
  %v12 = load i32, i32* %v3
  %v13 = icmp slt i32 %v12, 4
  br i1 %v13, label %loop_body3, label %exit_block3

loop_body3:
  %v14 = load i32, i32* %v4
  %v15 = load i32, i32* %v0
  %v16 = load i32, i32* %v1
  %v17 = add i32 %v15, %v16
  %v18 = load i32, i32* %v2
  %v19 = add i32 %v17, %v18
  %v20 = load i32, i32* %v3
  %v21 = add i32 %v19, %v20
  %v22 = add i32 %v14, %v21
  store i32 %v22, i32* %v4
  %v23 = load i32, i32* %v3
  %v24 = add i32 %v23, 1
  store i32 %v24, i32* %v3
  br label %header3

exit_block3:
  %v25 = load i32, i32* %v2
  %v26 = add i32 %v25, 1
  store i32 %v26, i32* %v2
  br label %header2

exit_block2:
  %v27 = load i32, i32* %v1
  %v28 = add i32 %v27, 1
  store i32 %v28, i32* %v1
  br label %header1

exit_block1:
  %v29 = load i32, i32* %v0
  %v30 = add i32 %v29, 1
  store i32 %v30, i32* %v0
  br label %header

exit_block:
  %v31 = load i32, i32* %v4
  %v32 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v32, i32 %v31)
  store i32 0, i32* %v4
  store i32 0, i32* %v0
  store i1 true, i1* %v5
  br label %header4

header4:
  %v33 = load i32, i32* %v0
  %v34 = icmp slt i32 %v33, 6
  br i1 %v34, label %loop_body4, label %exit_block4

loop_body4:
  store i32 0, i32* %v1
  %v35 = load i1, i1* %v5
  br i1 %v35, label %if, label %else

if:
  br label %header5

header5:
  %v36 = load i32, i32* %v1
  %v37 = icmp slt i32 %v36, 5
  br i1 %v37, label %loop_body5, label %exit_block5

loop_body5:
  store i32 0, i32* %v2
  br label %header6

header6:
  %v38 = load i32, i32* %v2
  %v39 = icmp slt i32 %v38, 4
  br i1 %v39, label %loop_body6, label %exit_block6

loop_body6:
  store i32 0, i32* %v3
  br label %header7

header7:
  %v40 = load i32, i32* %v3
  %v41 = icmp slt i32 %v40, 4
  br i1 %v41, label %loop_body7, label %exit_block7

loop_body7:
  %v42 = load i32, i32* %v4
  %v43 = load i32, i32* %v0
  %v44 = load i32, i32* %v1
  %v45 = add i32 %v43, %v44
  %v46 = load i32, i32* %v2
  %v47 = add i32 %v45, %v46
  %v48 = load i32, i32* %v3
  %v49 = add i32 %v47, %v48
  %v50 = add i32 %v42, %v49
  store i32 %v50, i32* %v4
  %v51 = load i32, i32* %v3
  %v52 = add i32 %v51, 1
  store i32 %v52, i32* %v3
  br label %header7

exit_block7:
  %v53 = load i32, i32* %v2
  %v54 = add i32 %v53, 1
  store i32 %v54, i32* %v2
  br label %header6

exit_block6:
  %v55 = load i32, i32* %v1
  %v56 = add i32 %v55, 1
  store i32 %v56, i32* %v1
  br label %header5

exit_block5:
  store i1 false, i1* %v5
  br label %if_end

else:
  br label %header8

header8:
  %v57 = load i32, i32* %v1
  %v58 = icmp slt i32 %v57, 4
  br i1 %v58, label %loop_body8, label %exit_block8

loop_body8:
  store i32 0, i32* %v2
  br label %header9

header9:
  %v59 = load i32, i32* %v2
  %v60 = icmp slt i32 %v59, 10
  br i1 %v60, label %loop_body9, label %exit_block9

loop_body9:
  store i32 0, i32* %v3
  br label %header10

header10:
  %v61 = load i32, i32* %v3
  %v62 = icmp slt i32 %v61, 4
  br i1 %v62, label %loop_body10, label %exit_block10

loop_body10:
  %v63 = load i32, i32* %v4
  %v64 = load i32, i32* %v0
  %v65 = load i32, i32* %v1
  %v66 = mul i32 %v64, %v65
  %v67 = load i32, i32* %v2
  %v68 = add i32 %v66, %v67
  %v69 = load i32, i32* %v3
  %v70 = add i32 %v68, %v69
  %v71 = add i32 %v63, %v70
  store i32 %v71, i32* %v4
  %v72 = load i32, i32* %v3
  %v73 = add i32 %v72, 1
  store i32 %v73, i32* %v3
  br label %header10

exit_block10:
  %v74 = load i32, i32* %v2
  %v75 = add i32 %v74, 1
  store i32 %v75, i32* %v2
  br label %header9

exit_block9:
  %v76 = load i32, i32* %v1
  %v77 = add i32 %v76, 1
  store i32 %v77, i32* %v1
  br label %header8

exit_block8:
  store i1 false, i1* %v5
  br label %if_end

if_end:
  %v78 = load i32, i32* %v0
  %v79 = add i32 %v78, 1
  store i32 %v79, i32* %v0
  br label %header4

exit_block4:
  %v80 = load i32, i32* %v4
  %v81 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v81, i32 %v80)
  ret i32 0
}

