
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
  %v0 = alloca i1
  store i1 false, i1* %v0
  br i1 true, label %if, label %else

if:
  br i1 true, label %if1, label %else1

if1:
  br i1 true, label %if2, label %else2

if2:
  br i1 true, label %if3, label %else3

if3:
  br i1 true, label %if4, label %else4

if4:
  %v1 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v1, i32 1)
  br label %if_end4

else4:
  %v2 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v2, i32 0)
  br label %if_end4

if_end4:
  %v3 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v3, i32 2)
  br label %if_end3

else3:
  %v4 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v4, i32 0)
  br label %if_end3

if_end3:
  %v5 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v5, i32 3)
  br label %if_end2

else2:
  %v6 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v6, i32 0)
  br label %if_end2

if_end2:
  %v7 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v7, i32 4)
  br label %if_end1

else1:
  %v8 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v8, i32 0)
  br label %if_end1

if_end1:
  %v9 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v9, i32 5)
  br label %if_end

else:
  %v10 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v10, i32 0)
  br label %if_end

if_end:
  br i1 true, label %and, label %and_end

and:
  br label %and_end

and_end:
  %v11 = phi i1 [ false, %if_end ], [ true, %and ]
  br i1 %v11, label %and1, label %and_end1

and1:
  %v12 = icmp eq i1 false, false
  br i1 %v12, label %and2, label %and_end2

and2:
  %v13 = icmp eq i1 false, false
  br label %and_end2

and_end2:
  %v14 = phi i1 [ false, %and1 ], [ %v13, %and2 ]
  br label %and_end1

and_end1:
  %v15 = phi i1 [ false, %and_end ], [ %v14, %and_end2 ]
  br i1 %v15, label %and3, label %and_end3

and3:
  %v16 = icmp slt i32 100, 1000
  br label %and_end3

and_end3:
  %v17 = phi i1 [ false, %and_end1 ], [ %v16, %and3 ]
  store i1 %v17, i1* %v0
  br i1 true, label %and4, label %and_end4

and4:
  %v18 = load i1, i1* %v0
  br label %and_end4

and_end4:
  %v19 = phi i1 [ false, %and_end3 ], [ %v18, %and4 ]
  br i1 %v19, label %and5, label %and_end5

and5:
  %v20 = icmp eq i1 false, false
  br i1 %v20, label %and6, label %and_end6

and6:
  %v21 = icmp eq i1 false, false
  br label %and_end6

and_end6:
  %v22 = phi i1 [ false, %and5 ], [ %v21, %and6 ]
  br label %and_end5

and_end5:
  %v23 = phi i1 [ false, %and_end4 ], [ %v22, %and_end6 ]
  br i1 %v23, label %if5, label %else5

if5:
  br i1 true, label %and7, label %and_end7

and7:
  %v24 = load i1, i1* %v0
  br label %and_end7

and_end7:
  %v25 = phi i1 [ false, %if5 ], [ %v24, %and7 ]
  br i1 %v25, label %and8, label %and_end8

and8:
  %v26 = icmp eq i1 false, false
  br i1 %v26, label %and9, label %and_end9

and9:
  %v27 = icmp eq i1 false, false
  br label %and_end9

and_end9:
  %v28 = phi i1 [ false, %and8 ], [ %v27, %and9 ]
  br label %and_end8

and_end8:
  %v29 = phi i1 [ false, %and_end7 ], [ %v28, %and_end9 ]
  br i1 %v29, label %if6, label %else6

if6:
  br i1 true, label %and10, label %and_end10

and10:
  %v30 = load i1, i1* %v0
  br label %and_end10

and_end10:
  %v31 = phi i1 [ false, %if6 ], [ %v30, %and10 ]
  br i1 %v31, label %and11, label %and_end11

and11:
  %v32 = icmp eq i1 false, false
  br i1 %v32, label %and12, label %and_end12

and12:
  %v33 = icmp eq i1 false, false
  br label %and_end12

and_end12:
  %v34 = phi i1 [ false, %and11 ], [ %v33, %and12 ]
  br label %and_end11

and_end11:
  %v35 = phi i1 [ false, %and_end10 ], [ %v34, %and_end12 ]
  br i1 %v35, label %if7, label %else7

if7:
  br i1 true, label %and13, label %and_end13

and13:
  %v36 = load i1, i1* %v0
  br label %and_end13

and_end13:
  %v37 = phi i1 [ false, %if7 ], [ %v36, %and13 ]
  br i1 %v37, label %and14, label %and_end14

and14:
  %v38 = icmp eq i1 false, false
  br i1 %v38, label %and15, label %and_end15

and15:
  %v39 = icmp eq i1 false, false
  br label %and_end15

and_end15:
  %v40 = phi i1 [ false, %and14 ], [ %v39, %and15 ]
  br label %and_end14

and_end14:
  %v41 = phi i1 [ false, %and_end13 ], [ %v40, %and_end15 ]
  br i1 %v41, label %if8, label %else8

if8:
  %v42 = load i1, i1* %v0
  br i1 %v42, label %and16, label %and_end16

and16:
  %v43 = load i1, i1* %v0
  br label %and_end16

and_end16:
  %v44 = phi i1 [ false, %if8 ], [ %v43, %and16 ]
  br i1 %v44, label %and17, label %and_end17

and17:
  %v45 = icmp eq i1 false, false
  br i1 %v45, label %and18, label %and_end18

and18:
  %v46 = icmp eq i1 false, false
  br label %and_end18

and_end18:
  %v47 = phi i1 [ false, %and17 ], [ %v46, %and18 ]
  br label %and_end17

and_end17:
  %v48 = phi i1 [ false, %and_end16 ], [ %v47, %and_end18 ]
  br i1 %v48, label %if9, label %else9

if9:
  %v49 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v49, i32 1)
  br label %if_end9

else9:
  %v50 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v50, i32 0)
  br label %if_end9

if_end9:
  %v51 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v51, i32 2)
  br label %if_end8

else8:
  %v52 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v52, i32 0)
  br label %if_end8

if_end8:
  %v53 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v53, i32 3)
  br label %if_end7

else7:
  %v54 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v54, i32 0)
  br label %if_end7

if_end7:
  %v55 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v55, i32 4)
  br label %if_end6

else6:
  %v56 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v56, i32 0)
  br label %if_end6

if_end6:
  %v57 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v57, i32 5)
  br label %if_end5

else5:
  %v58 = bitcast [4 x i8]* @.str to i8*
  call i32 (i8*, ...) @printf(i8* %v58, i32 0)
  br label %if_end5

if_end5:
  ret i32 0
}

