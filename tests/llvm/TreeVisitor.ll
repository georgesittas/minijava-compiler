@.TreeVisitor_vtable = global [0 x i8*] []
@.TV_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @TV.Start to i8*)]
@.Tree_vtable = global [21 x i8*] [i8* bitcast (i1 (i8*,i32)* @Tree.Init to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.SetRight to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.SetKey to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*,i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*,i32, i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*,i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*,i8*, i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*,i8*, i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*,i8*, i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*,i32)* @Tree.Search to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*,i8*)* @Tree.RecPrint to i8*), i8* bitcast (i32 (i8*,i8*)* @Tree.accept to i8*)]
@.Visitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @Visitor.visit to i8*)]
@.MyVisitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*,i8*)* @MyVisitor.visit to i8*)]


declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
    %_str = bitcast [4 x i8]* @_cint to i8*
    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
    ret void
}

define void @throw_oob() {
    %_str = bitcast [15 x i8]* @_cOOB to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() {
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; TV.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)
	call void (i32) @print_int(i32 %_8)
	
	ret i32 0
}

define i32 @TV.Start(i8* %this) {
	%root = alloca i8*
	
	%ntb = alloca i1
	
	%nti = alloca i32
	
	%v = alloca i8*
	
	%_0 = call i8* @calloc(i32 1, i32 38)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %root
	
	%_3 = load i8*, i8** %root
	; Tree.Init : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*,i32)*
	%_9 = call i1 %_8(i8* %_3, i32 16)
	store i1 %_9, i1* %ntb
	
	%_10 = load i8*, i8** %root
	; Tree.Print : 18
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 18
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*)*
	%_16 = call i1 %_15(i8* %_10)
	store i1 %_16, i1* %ntb
	
	call void (i32) @print_int(i32 100000000)
	
	%_17 = load i8*, i8** %root
	; Tree.Insert : 12
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 12
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*,i32)*
	%_23 = call i1 %_22(i8* %_17, i32 8)
	store i1 %_23, i1* %ntb
	
	%_24 = load i8*, i8** %root
	; Tree.Insert : 12
	%_25 = bitcast i8* %_24 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 12
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i1 (i8*,i32)*
	%_30 = call i1 %_29(i8* %_24, i32 24)
	store i1 %_30, i1* %ntb
	
	%_31 = load i8*, i8** %root
	; Tree.Insert : 12
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 12
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*,i32)*
	%_37 = call i1 %_36(i8* %_31, i32 4)
	store i1 %_37, i1* %ntb
	
	%_38 = load i8*, i8** %root
	; Tree.Insert : 12
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 12
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*,i32)*
	%_44 = call i1 %_43(i8* %_38, i32 12)
	store i1 %_44, i1* %ntb
	
	%_45 = load i8*, i8** %root
	; Tree.Insert : 12
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 12
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*,i32)*
	%_51 = call i1 %_50(i8* %_45, i32 20)
	store i1 %_51, i1* %ntb
	
	%_52 = load i8*, i8** %root
	; Tree.Insert : 12
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 12
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*,i32)*
	%_58 = call i1 %_57(i8* %_52, i32 28)
	store i1 %_58, i1* %ntb
	
	%_59 = load i8*, i8** %root
	; Tree.Insert : 12
	%_60 = bitcast i8* %_59 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 12
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i1 (i8*,i32)*
	%_65 = call i1 %_64(i8* %_59, i32 14)
	store i1 %_65, i1* %ntb
	
	%_66 = load i8*, i8** %root
	; Tree.Print : 18
	%_67 = bitcast i8* %_66 to i8***
	%_68 = load i8**, i8*** %_67
	%_69 = getelementptr i8*, i8** %_68, i32 18
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1 (i8*)*
	%_72 = call i1 %_71(i8* %_66)
	store i1 %_72, i1* %ntb
	
	call void (i32) @print_int(i32 100000000)
	
	%_73 = call i8* @calloc(i32 1, i32 24)
	%_74 = bitcast i8* %_73 to i8***
	%_75 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0
	store i8** %_75, i8*** %_74
	store i8* %_73, i8** %v
	
	call void (i32) @print_int(i32 50000000)
	
	%_76 = load i8*, i8** %root
	; Tree.accept : 20
	%_77 = bitcast i8* %_76 to i8***
	%_78 = load i8**, i8*** %_77
	%_79 = getelementptr i8*, i8** %_78, i32 20
	%_80 = load i8*, i8** %_79
	%_81 = bitcast i8* %_80 to i32 (i8*,i8*)*
	%_83 = load i8*, i8** %v
	%_82 = call i32 %_81(i8* %_76, i8* %_83)
	store i32 %_82, i32* %nti
	
	call void (i32) @print_int(i32 100000000)
	
	%_84 = load i8*, i8** %root
	; Tree.Search : 17
	%_85 = bitcast i8* %_84 to i8***
	%_86 = load i8**, i8*** %_85
	%_87 = getelementptr i8*, i8** %_86, i32 17
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i32 (i8*,i32)*
	%_90 = call i32 %_89(i8* %_84, i32 24)
	call void (i32) @print_int(i32 %_90)
	
	%_91 = load i8*, i8** %root
	; Tree.Search : 17
	%_92 = bitcast i8* %_91 to i8***
	%_93 = load i8**, i8*** %_92
	%_94 = getelementptr i8*, i8** %_93, i32 17
	%_95 = load i8*, i8** %_94
	%_96 = bitcast i8* %_95 to i32 (i8*,i32)*
	%_97 = call i32 %_96(i8* %_91, i32 12)
	call void (i32) @print_int(i32 %_97)
	
	%_98 = load i8*, i8** %root
	; Tree.Search : 17
	%_99 = bitcast i8* %_98 to i8***
	%_100 = load i8**, i8*** %_99
	%_101 = getelementptr i8*, i8** %_100, i32 17
	%_102 = load i8*, i8** %_101
	%_103 = bitcast i8* %_102 to i32 (i8*,i32)*
	%_104 = call i32 %_103(i8* %_98, i32 16)
	call void (i32) @print_int(i32 %_104)
	
	%_105 = load i8*, i8** %root
	; Tree.Search : 17
	%_106 = bitcast i8* %_105 to i8***
	%_107 = load i8**, i8*** %_106
	%_108 = getelementptr i8*, i8** %_107, i32 17
	%_109 = load i8*, i8** %_108
	%_110 = bitcast i8* %_109 to i32 (i8*,i32)*
	%_111 = call i32 %_110(i8* %_105, i32 50)
	call void (i32) @print_int(i32 %_111)
	
	%_112 = load i8*, i8** %root
	; Tree.Search : 17
	%_113 = bitcast i8* %_112 to i8***
	%_114 = load i8**, i8*** %_113
	%_115 = getelementptr i8*, i8** %_114, i32 17
	%_116 = load i8*, i8** %_115
	%_117 = bitcast i8* %_116 to i32 (i8*,i32)*
	%_118 = call i32 %_117(i8* %_112, i32 12)
	call void (i32) @print_int(i32 %_118)
	
	%_119 = load i8*, i8** %root
	; Tree.Delete : 13
	%_120 = bitcast i8* %_119 to i8***
	%_121 = load i8**, i8*** %_120
	%_122 = getelementptr i8*, i8** %_121, i32 13
	%_123 = load i8*, i8** %_122
	%_124 = bitcast i8* %_123 to i1 (i8*,i32)*
	%_125 = call i1 %_124(i8* %_119, i32 12)
	store i1 %_125, i1* %ntb
	
	%_126 = load i8*, i8** %root
	; Tree.Print : 18
	%_127 = bitcast i8* %_126 to i8***
	%_128 = load i8**, i8*** %_127
	%_129 = getelementptr i8*, i8** %_128, i32 18
	%_130 = load i8*, i8** %_129
	%_131 = bitcast i8* %_130 to i1 (i8*)*
	%_132 = call i1 %_131(i8* %_126)
	store i1 %_132, i1* %ntb
	
	%_133 = load i8*, i8** %root
	; Tree.Search : 17
	%_134 = bitcast i8* %_133 to i8***
	%_135 = load i8**, i8*** %_134
	%_136 = getelementptr i8*, i8** %_135, i32 17
	%_137 = load i8*, i8** %_136
	%_138 = bitcast i8* %_137 to i32 (i8*,i32)*
	%_139 = call i32 %_138(i8* %_133, i32 12)
	call void (i32) @print_int(i32 %_139)
	
	ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_0 = load i32, i32* %v_key
	%_1 = getelementptr i8, i8* %this, i32 24
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2
	
	%_3 = getelementptr i8, i8* %this, i32 28
	%_4 = bitcast i8* %_3 to i1*
	store i1 0, i1* %_4
	
	%_5 = getelementptr i8, i8* %this, i32 29
	%_6 = bitcast i8* %_5 to i1*
	store i1 0, i1* %_6
	
	ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn
	%_0 = load i8*, i8** %rn
	%_1 = getelementptr i8, i8* %this, i32 16
	%_2 = bitcast i8* %_1 to i8**
	store i8* %_0, i8** %_2
	
	ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln
	%_0 = load i8*, i8** %ln
	%_1 = getelementptr i8, i8* %this, i32 8
	%_2 = bitcast i8* %_1 to i8**
	store i8* %_0, i8** %_2
	
	ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i8* @Tree.GetLeft(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i32 @Tree.GetKey(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%_0 = load i32, i32* %v_key
	%_1 = getelementptr i8, i8* %this, i32 24
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2
	
	ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.GetHas_Left(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_0 = load i1, i1* %val
	%_1 = getelementptr i8, i8* %this, i32 28
	%_2 = bitcast i8* %_1 to i1*
	store i1 %_0, i1* %_2
	
	ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val
	%_0 = load i1, i1* %val
	%_1 = getelementptr i8, i8* %this, i32 29
	%_2 = bitcast i8* %_1 to i1*
	store i1 %_0, i1* %_2
	
	ret i1 1
}

define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1
	
	%nti = alloca i32
	
	store i1 0, i1* %ntb
	
	%_0 = load i32, i32* %num2
	%_1 = add i32 %_0, 1
	store i32 %_1, i32* %nti
	
	%_5 = load i32, i32* %num1
	%_6 = load i32, i32* %num2
	%_7 = icmp slt i32 %_5, %_6
	br i1 %_7, label %if2, label %if3

if2:
		store i1 0, i1* %ntb
		
		br label %if4

if3:

		%_12 = load i32, i32* %num1
		%_13 = load i32, i32* %nti
		%_14 = icmp slt i32 %_12, %_13
		%_11 = xor i1 1, %_14
		br i1 %_11, label %if8, label %if9

if8:
			store i1 0, i1* %ntb
			
			br label %if10

if9:

			store i1 1, i1* %ntb
			
			br label %if10

if10:
		
		br label %if4

if4:
	
	%_15 = load i1, i1* %ntb
	ret i1 %_15
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*
	
	%ntb = alloca i1
	
	%current_node = alloca i8*
	
	%cont = alloca i1
	
	%key_aux = alloca i32
	
	%_0 = call i8* @calloc(i32 1, i32 38)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %new_node
	
	%_3 = load i8*, i8** %new_node
	; Tree.Init : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*,i32)*
	%_10 = load i32, i32* %v_key
	%_9 = call i1 %_8(i8* %_3, i32 %_10)
	store i1 %_9, i1* %ntb
	
	store i8* %this, i8** %current_node
	
	store i1 1, i1* %cont
	
	br label %loop11

loop11:
	%_14 = load i1, i1* %cont
	br i1 %_14, label %loop12, label %loop13

loop12:
		%_15 = load i8*, i8** %current_node
		; Tree.GetKey : 5
		%_16 = bitcast i8* %_15 to i8***
		%_17 = load i8**, i8*** %_16
		%_18 = getelementptr i8*, i8** %_17, i32 5
		%_19 = load i8*, i8** %_18
		%_20 = bitcast i8* %_19 to i32 (i8*)*
		%_21 = call i32 %_20(i8* %_15)
		store i32 %_21, i32* %key_aux
		
		%_25 = load i32, i32* %v_key
		%_26 = load i32, i32* %key_aux
		%_27 = icmp slt i32 %_25, %_26
		br i1 %_27, label %if22, label %if23

if22:
			%_31 = load i8*, i8** %current_node
			; Tree.GetHas_Left : 8
			%_32 = bitcast i8* %_31 to i8***
			%_33 = load i8**, i8*** %_32
			%_34 = getelementptr i8*, i8** %_33, i32 8
			%_35 = load i8*, i8** %_34
			%_36 = bitcast i8* %_35 to i1 (i8*)*
			%_37 = call i1 %_36(i8* %_31)
			br i1 %_37, label %if28, label %if29

if28:
				%_38 = load i8*, i8** %current_node
				; Tree.GetLeft : 4
				%_39 = bitcast i8* %_38 to i8***
				%_40 = load i8**, i8*** %_39
				%_41 = getelementptr i8*, i8** %_40, i32 4
				%_42 = load i8*, i8** %_41
				%_43 = bitcast i8* %_42 to i8* (i8*)*
				%_44 = call i8* %_43(i8* %_38)
				store i8* %_44, i8** %current_node
				
				br label %if30

if29:

				store i1 0, i1* %cont
				
				%_45 = load i8*, i8** %current_node
				; Tree.SetHas_Left : 9
				%_46 = bitcast i8* %_45 to i8***
				%_47 = load i8**, i8*** %_46
				%_48 = getelementptr i8*, i8** %_47, i32 9
				%_49 = load i8*, i8** %_48
				%_50 = bitcast i8* %_49 to i1 (i8*,i1)*
				%_51 = call i1 %_50(i8* %_45, i1 1)
				store i1 %_51, i1* %ntb
				
				%_52 = load i8*, i8** %current_node
				; Tree.SetLeft : 2
				%_53 = bitcast i8* %_52 to i8***
				%_54 = load i8**, i8*** %_53
				%_55 = getelementptr i8*, i8** %_54, i32 2
				%_56 = load i8*, i8** %_55
				%_57 = bitcast i8* %_56 to i1 (i8*,i8*)*
				%_59 = load i8*, i8** %new_node
				%_58 = call i1 %_57(i8* %_52, i8* %_59)
				store i1 %_58, i1* %ntb
				
				
				br label %if30

if30:
			
			
			br label %if24

if23:

			%_63 = load i8*, i8** %current_node
			; Tree.GetHas_Right : 7
			%_64 = bitcast i8* %_63 to i8***
			%_65 = load i8**, i8*** %_64
			%_66 = getelementptr i8*, i8** %_65, i32 7
			%_67 = load i8*, i8** %_66
			%_68 = bitcast i8* %_67 to i1 (i8*)*
			%_69 = call i1 %_68(i8* %_63)
			br i1 %_69, label %if60, label %if61

if60:
				%_70 = load i8*, i8** %current_node
				; Tree.GetRight : 3
				%_71 = bitcast i8* %_70 to i8***
				%_72 = load i8**, i8*** %_71
				%_73 = getelementptr i8*, i8** %_72, i32 3
				%_74 = load i8*, i8** %_73
				%_75 = bitcast i8* %_74 to i8* (i8*)*
				%_76 = call i8* %_75(i8* %_70)
				store i8* %_76, i8** %current_node
				
				br label %if62

if61:

				store i1 0, i1* %cont
				
				%_77 = load i8*, i8** %current_node
				; Tree.SetHas_Right : 10
				%_78 = bitcast i8* %_77 to i8***
				%_79 = load i8**, i8*** %_78
				%_80 = getelementptr i8*, i8** %_79, i32 10
				%_81 = load i8*, i8** %_80
				%_82 = bitcast i8* %_81 to i1 (i8*,i1)*
				%_83 = call i1 %_82(i8* %_77, i1 1)
				store i1 %_83, i1* %ntb
				
				%_84 = load i8*, i8** %current_node
				; Tree.SetRight : 1
				%_85 = bitcast i8* %_84 to i8***
				%_86 = load i8**, i8*** %_85
				%_87 = getelementptr i8*, i8** %_86, i32 1
				%_88 = load i8*, i8** %_87
				%_89 = bitcast i8* %_88 to i1 (i8*,i8*)*
				%_91 = load i8*, i8** %new_node
				%_90 = call i1 %_89(i8* %_84, i8* %_91)
				store i1 %_90, i1* %ntb
				
				
				br label %if62

if62:
			
			
			br label %if24

if24:
		
		
		br label %loop11

loop13:
	
	ret i1 1
}

define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	
	%parent_node = alloca i8*
	
	%cont = alloca i1
	
	%found = alloca i1
	
	%ntb = alloca i1
	
	%is_root = alloca i1
	
	%key_aux = alloca i32
	
	store i8* %this, i8** %current_node
	
	store i8* %this, i8** %parent_node
	
	store i1 1, i1* %cont
	
	store i1 0, i1* %found
	
	store i1 1, i1* %is_root
	
	br label %loop0

loop0:
	%_3 = load i1, i1* %cont
	br i1 %_3, label %loop1, label %loop2

loop1:
		%_4 = load i8*, i8** %current_node
		; Tree.GetKey : 5
		%_5 = bitcast i8* %_4 to i8***
		%_6 = load i8**, i8*** %_5
		%_7 = getelementptr i8*, i8** %_6, i32 5
		%_8 = load i8*, i8** %_7
		%_9 = bitcast i8* %_8 to i32 (i8*)*
		%_10 = call i32 %_9(i8* %_4)
		store i32 %_10, i32* %key_aux
		
		%_14 = load i32, i32* %v_key
		%_15 = load i32, i32* %key_aux
		%_16 = icmp slt i32 %_14, %_15
		br i1 %_16, label %if11, label %if12

if11:
			%_20 = load i8*, i8** %current_node
			; Tree.GetHas_Left : 8
			%_21 = bitcast i8* %_20 to i8***
			%_22 = load i8**, i8*** %_21
			%_23 = getelementptr i8*, i8** %_22, i32 8
			%_24 = load i8*, i8** %_23
			%_25 = bitcast i8* %_24 to i1 (i8*)*
			%_26 = call i1 %_25(i8* %_20)
			br i1 %_26, label %if17, label %if18

if17:
				%_27 = load i8*, i8** %current_node
				store i8* %_27, i8** %parent_node
				
				%_28 = load i8*, i8** %current_node
				; Tree.GetLeft : 4
				%_29 = bitcast i8* %_28 to i8***
				%_30 = load i8**, i8*** %_29
				%_31 = getelementptr i8*, i8** %_30, i32 4
				%_32 = load i8*, i8** %_31
				%_33 = bitcast i8* %_32 to i8* (i8*)*
				%_34 = call i8* %_33(i8* %_28)
				store i8* %_34, i8** %current_node
				
				
				br label %if19

if18:

				store i1 0, i1* %cont
				
				br label %if19

if19:
			
			br label %if13

if12:

			%_38 = load i32, i32* %key_aux
			%_39 = load i32, i32* %v_key
			%_40 = icmp slt i32 %_38, %_39
			br i1 %_40, label %if35, label %if36

if35:
				%_44 = load i8*, i8** %current_node
				; Tree.GetHas_Right : 7
				%_45 = bitcast i8* %_44 to i8***
				%_46 = load i8**, i8*** %_45
				%_47 = getelementptr i8*, i8** %_46, i32 7
				%_48 = load i8*, i8** %_47
				%_49 = bitcast i8* %_48 to i1 (i8*)*
				%_50 = call i1 %_49(i8* %_44)
				br i1 %_50, label %if41, label %if42

if41:
					%_51 = load i8*, i8** %current_node
					store i8* %_51, i8** %parent_node
					
					%_52 = load i8*, i8** %current_node
					; Tree.GetRight : 3
					%_53 = bitcast i8* %_52 to i8***
					%_54 = load i8**, i8*** %_53
					%_55 = getelementptr i8*, i8** %_54, i32 3
					%_56 = load i8*, i8** %_55
					%_57 = bitcast i8* %_56 to i8* (i8*)*
					%_58 = call i8* %_57(i8* %_52)
					store i8* %_58, i8** %current_node
					
					
					br label %if43

if42:

					store i1 0, i1* %cont
					
					br label %if43

if43:
				
				br label %if37

if36:

				%_62 = load i1, i1* %is_root
				br i1 %_62, label %if59, label %if60

if59:
					%_67 = load i8*, i8** %current_node
					; Tree.GetHas_Right : 7
					%_68 = bitcast i8* %_67 to i8***
					%_69 = load i8**, i8*** %_68
					%_70 = getelementptr i8*, i8** %_69, i32 7
					%_71 = load i8*, i8** %_70
					%_72 = bitcast i8* %_71 to i1 (i8*)*
					%_73 = call i1 %_72(i8* %_67)
					%_66 = xor i1 1, %_73
					br label %andclause75

andclause75:
					br i1 %_66, label %andclause76, label %andclause78

andclause76:
					%_80 = load i8*, i8** %current_node
					; Tree.GetHas_Left : 8
					%_81 = bitcast i8* %_80 to i8***
					%_82 = load i8**, i8*** %_81
					%_83 = getelementptr i8*, i8** %_82, i32 8
					%_84 = load i8*, i8** %_83
					%_85 = bitcast i8* %_84 to i1 (i8*)*
					%_86 = call i1 %_85(i8* %_80)
					%_79 = xor i1 1, %_86
					br label %andclause77

andclause77:
					br label %andclause78

andclause78:
					%_74 = phi i1 [ 0, %andclause75 ], [ %_79, %andclause77 ]
					br i1 %_74, label %if63, label %if64

if63:
						store i1 1, i1* %ntb
						
						br label %if65

if64:

						; Tree.Remove : 14
						%_87 = bitcast i8* %this to i8***
						%_88 = load i8**, i8*** %_87
						%_89 = getelementptr i8*, i8** %_88, i32 14
						%_90 = load i8*, i8** %_89
						%_91 = bitcast i8* %_90 to i1 (i8*,i8*, i8*)*
						%_93 = load i8*, i8** %parent_node
						%_94 = load i8*, i8** %current_node
						%_92 = call i1 %_91(i8* %this, i8* %_93, i8* %_94)
						store i1 %_92, i1* %ntb
						
						br label %if65

if65:
					
					br label %if61

if60:

					; Tree.Remove : 14
					%_95 = bitcast i8* %this to i8***
					%_96 = load i8**, i8*** %_95
					%_97 = getelementptr i8*, i8** %_96, i32 14
					%_98 = load i8*, i8** %_97
					%_99 = bitcast i8* %_98 to i1 (i8*,i8*, i8*)*
					%_101 = load i8*, i8** %parent_node
					%_102 = load i8*, i8** %current_node
					%_100 = call i1 %_99(i8* %this, i8* %_101, i8* %_102)
					store i1 %_100, i1* %ntb
					
					br label %if61

if61:
				
				store i1 1, i1* %found
				
				store i1 0, i1* %cont
				
				
				br label %if37

if37:
			
			br label %if13

if13:
		
		store i1 0, i1* %is_root
		
		
		br label %loop0

loop2:
	
	%_103 = load i1, i1* %found
	ret i1 %_103
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	
	%auxkey1 = alloca i32
	
	%auxkey2 = alloca i32
	
	%_3 = load i8*, i8** %c_node
	; Tree.GetHas_Left : 8
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %if0, label %if1

if0:
		; Tree.RemoveLeft : 16
		%_10 = bitcast i8* %this to i8***
		%_11 = load i8**, i8*** %_10
		%_12 = getelementptr i8*, i8** %_11, i32 16
		%_13 = load i8*, i8** %_12
		%_14 = bitcast i8* %_13 to i1 (i8*,i8*, i8*)*
		%_16 = load i8*, i8** %p_node
		%_17 = load i8*, i8** %c_node
		%_15 = call i1 %_14(i8* %this, i8* %_16, i8* %_17)
		store i1 %_15, i1* %ntb
		
		br label %if2

if1:

		%_21 = load i8*, i8** %c_node
		; Tree.GetHas_Right : 7
		%_22 = bitcast i8* %_21 to i8***
		%_23 = load i8**, i8*** %_22
		%_24 = getelementptr i8*, i8** %_23, i32 7
		%_25 = load i8*, i8** %_24
		%_26 = bitcast i8* %_25 to i1 (i8*)*
		%_27 = call i1 %_26(i8* %_21)
		br i1 %_27, label %if18, label %if19

if18:
			; Tree.RemoveRight : 15
			%_28 = bitcast i8* %this to i8***
			%_29 = load i8**, i8*** %_28
			%_30 = getelementptr i8*, i8** %_29, i32 15
			%_31 = load i8*, i8** %_30
			%_32 = bitcast i8* %_31 to i1 (i8*,i8*, i8*)*
			%_34 = load i8*, i8** %p_node
			%_35 = load i8*, i8** %c_node
			%_33 = call i1 %_32(i8* %this, i8* %_34, i8* %_35)
			store i1 %_33, i1* %ntb
			
			br label %if20

if19:

			%_36 = load i8*, i8** %c_node
			; Tree.GetKey : 5
			%_37 = bitcast i8* %_36 to i8***
			%_38 = load i8**, i8*** %_37
			%_39 = getelementptr i8*, i8** %_38, i32 5
			%_40 = load i8*, i8** %_39
			%_41 = bitcast i8* %_40 to i32 (i8*)*
			%_42 = call i32 %_41(i8* %_36)
			store i32 %_42, i32* %auxkey1
			
			%_43 = load i8*, i8** %p_node
			; Tree.GetLeft : 4
			%_44 = bitcast i8* %_43 to i8***
			%_45 = load i8**, i8*** %_44
			%_46 = getelementptr i8*, i8** %_45, i32 4
			%_47 = load i8*, i8** %_46
			%_48 = bitcast i8* %_47 to i8* (i8*)*
			%_49 = call i8* %_48(i8* %_43)
			; Tree.GetKey : 5
			%_50 = bitcast i8* %_49 to i8***
			%_51 = load i8**, i8*** %_50
			%_52 = getelementptr i8*, i8** %_51, i32 5
			%_53 = load i8*, i8** %_52
			%_54 = bitcast i8* %_53 to i32 (i8*)*
			%_55 = call i32 %_54(i8* %_49)
			store i32 %_55, i32* %auxkey2
			
			; Tree.Compare : 11
			%_59 = bitcast i8* %this to i8***
			%_60 = load i8**, i8*** %_59
			%_61 = getelementptr i8*, i8** %_60, i32 11
			%_62 = load i8*, i8** %_61
			%_63 = bitcast i8* %_62 to i1 (i8*,i32, i32)*
			%_65 = load i32, i32* %auxkey1
			%_66 = load i32, i32* %auxkey2
			%_64 = call i1 %_63(i8* %this, i32 %_65, i32 %_66)
			br i1 %_64, label %if56, label %if57

if56:
				%_67 = load i8*, i8** %p_node
				; Tree.SetLeft : 2
				%_68 = bitcast i8* %_67 to i8***
				%_69 = load i8**, i8*** %_68
				%_70 = getelementptr i8*, i8** %_69, i32 2
				%_71 = load i8*, i8** %_70
				%_72 = bitcast i8* %_71 to i1 (i8*,i8*)*
				%_74 = getelementptr i8, i8* %this, i32 30
				%_75 = bitcast i8* %_74 to i8**
				%_76 = load i8*, i8** %_75
				%_73 = call i1 %_72(i8* %_67, i8* %_76)
				store i1 %_73, i1* %ntb
				
				%_77 = load i8*, i8** %p_node
				; Tree.SetHas_Left : 9
				%_78 = bitcast i8* %_77 to i8***
				%_79 = load i8**, i8*** %_78
				%_80 = getelementptr i8*, i8** %_79, i32 9
				%_81 = load i8*, i8** %_80
				%_82 = bitcast i8* %_81 to i1 (i8*,i1)*
				%_83 = call i1 %_82(i8* %_77, i1 0)
				store i1 %_83, i1* %ntb
				
				
				br label %if58

if57:

				%_84 = load i8*, i8** %p_node
				; Tree.SetRight : 1
				%_85 = bitcast i8* %_84 to i8***
				%_86 = load i8**, i8*** %_85
				%_87 = getelementptr i8*, i8** %_86, i32 1
				%_88 = load i8*, i8** %_87
				%_89 = bitcast i8* %_88 to i1 (i8*,i8*)*
				%_91 = getelementptr i8, i8* %this, i32 30
				%_92 = bitcast i8* %_91 to i8**
				%_93 = load i8*, i8** %_92
				%_90 = call i1 %_89(i8* %_84, i8* %_93)
				store i1 %_90, i1* %ntb
				
				%_94 = load i8*, i8** %p_node
				; Tree.SetHas_Right : 10
				%_95 = bitcast i8* %_94 to i8***
				%_96 = load i8**, i8*** %_95
				%_97 = getelementptr i8*, i8** %_96, i32 10
				%_98 = load i8*, i8** %_97
				%_99 = bitcast i8* %_98 to i1 (i8*,i1)*
				%_100 = call i1 %_99(i8* %_94, i1 0)
				store i1 %_100, i1* %ntb
				
				
				br label %if58

if58:
			
			
			br label %if20

if20:
		
		br label %if2

if2:
	
	ret i1 1
}

define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	
	br label %loop0

loop0:
	%_3 = load i8*, i8** %c_node
	; Tree.GetHas_Right : 7
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 7
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %loop1, label %loop2

loop1:
		%_10 = load i8*, i8** %c_node
		; Tree.SetKey : 6
		%_11 = bitcast i8* %_10 to i8***
		%_12 = load i8**, i8*** %_11
		%_13 = getelementptr i8*, i8** %_12, i32 6
		%_14 = load i8*, i8** %_13
		%_15 = bitcast i8* %_14 to i1 (i8*,i32)*
		%_17 = load i8*, i8** %c_node
		; Tree.GetRight : 3
		%_18 = bitcast i8* %_17 to i8***
		%_19 = load i8**, i8*** %_18
		%_20 = getelementptr i8*, i8** %_19, i32 3
		%_21 = load i8*, i8** %_20
		%_22 = bitcast i8* %_21 to i8* (i8*)*
		%_23 = call i8* %_22(i8* %_17)
		; Tree.GetKey : 5
		%_24 = bitcast i8* %_23 to i8***
		%_25 = load i8**, i8*** %_24
		%_26 = getelementptr i8*, i8** %_25, i32 5
		%_27 = load i8*, i8** %_26
		%_28 = bitcast i8* %_27 to i32 (i8*)*
		%_29 = call i32 %_28(i8* %_23)
		%_16 = call i1 %_15(i8* %_10, i32 %_29)
		store i1 %_16, i1* %ntb
		
		%_30 = load i8*, i8** %c_node
		store i8* %_30, i8** %p_node
		
		%_31 = load i8*, i8** %c_node
		; Tree.GetRight : 3
		%_32 = bitcast i8* %_31 to i8***
		%_33 = load i8**, i8*** %_32
		%_34 = getelementptr i8*, i8** %_33, i32 3
		%_35 = load i8*, i8** %_34
		%_36 = bitcast i8* %_35 to i8* (i8*)*
		%_37 = call i8* %_36(i8* %_31)
		store i8* %_37, i8** %c_node
		
		
		br label %loop0

loop2:
	
	%_38 = load i8*, i8** %p_node
	; Tree.SetRight : 1
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 1
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*,i8*)*
	%_45 = getelementptr i8, i8* %this, i32 30
	%_46 = bitcast i8* %_45 to i8**
	%_47 = load i8*, i8** %_46
	%_44 = call i1 %_43(i8* %_38, i8* %_47)
	store i1 %_44, i1* %ntb
	
	%_48 = load i8*, i8** %p_node
	; Tree.SetHas_Right : 10
	%_49 = bitcast i8* %_48 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 10
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1 (i8*,i1)*
	%_54 = call i1 %_53(i8* %_48, i1 0)
	store i1 %_54, i1* %ntb
	
	ret i1 1
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1
	
	br label %loop0

loop0:
	%_3 = load i8*, i8** %c_node
	; Tree.GetHas_Left : 8
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %loop1, label %loop2

loop1:
		%_10 = load i8*, i8** %c_node
		; Tree.SetKey : 6
		%_11 = bitcast i8* %_10 to i8***
		%_12 = load i8**, i8*** %_11
		%_13 = getelementptr i8*, i8** %_12, i32 6
		%_14 = load i8*, i8** %_13
		%_15 = bitcast i8* %_14 to i1 (i8*,i32)*
		%_17 = load i8*, i8** %c_node
		; Tree.GetLeft : 4
		%_18 = bitcast i8* %_17 to i8***
		%_19 = load i8**, i8*** %_18
		%_20 = getelementptr i8*, i8** %_19, i32 4
		%_21 = load i8*, i8** %_20
		%_22 = bitcast i8* %_21 to i8* (i8*)*
		%_23 = call i8* %_22(i8* %_17)
		; Tree.GetKey : 5
		%_24 = bitcast i8* %_23 to i8***
		%_25 = load i8**, i8*** %_24
		%_26 = getelementptr i8*, i8** %_25, i32 5
		%_27 = load i8*, i8** %_26
		%_28 = bitcast i8* %_27 to i32 (i8*)*
		%_29 = call i32 %_28(i8* %_23)
		%_16 = call i1 %_15(i8* %_10, i32 %_29)
		store i1 %_16, i1* %ntb
		
		%_30 = load i8*, i8** %c_node
		store i8* %_30, i8** %p_node
		
		%_31 = load i8*, i8** %c_node
		; Tree.GetLeft : 4
		%_32 = bitcast i8* %_31 to i8***
		%_33 = load i8**, i8*** %_32
		%_34 = getelementptr i8*, i8** %_33, i32 4
		%_35 = load i8*, i8** %_34
		%_36 = bitcast i8* %_35 to i8* (i8*)*
		%_37 = call i8* %_36(i8* %_31)
		store i8* %_37, i8** %c_node
		
		
		br label %loop0

loop2:
	
	%_38 = load i8*, i8** %p_node
	; Tree.SetLeft : 2
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 2
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*,i8*)*
	%_45 = getelementptr i8, i8* %this, i32 30
	%_46 = bitcast i8* %_45 to i8**
	%_47 = load i8*, i8** %_46
	%_44 = call i1 %_43(i8* %_38, i8* %_47)
	store i1 %_44, i1* %ntb
	
	%_48 = load i8*, i8** %p_node
	; Tree.SetHas_Left : 9
	%_49 = bitcast i8* %_48 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 9
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1 (i8*,i1)*
	%_54 = call i1 %_53(i8* %_48, i1 0)
	store i1 %_54, i1* %ntb
	
	ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*
	
	%ifound = alloca i32
	
	%cont = alloca i1
	
	%key_aux = alloca i32
	
	store i8* %this, i8** %current_node
	
	store i1 1, i1* %cont
	
	store i32 0, i32* %ifound
	
	br label %loop0

loop0:
	%_3 = load i1, i1* %cont
	br i1 %_3, label %loop1, label %loop2

loop1:
		%_4 = load i8*, i8** %current_node
		; Tree.GetKey : 5
		%_5 = bitcast i8* %_4 to i8***
		%_6 = load i8**, i8*** %_5
		%_7 = getelementptr i8*, i8** %_6, i32 5
		%_8 = load i8*, i8** %_7
		%_9 = bitcast i8* %_8 to i32 (i8*)*
		%_10 = call i32 %_9(i8* %_4)
		store i32 %_10, i32* %key_aux
		
		%_14 = load i32, i32* %v_key
		%_15 = load i32, i32* %key_aux
		%_16 = icmp slt i32 %_14, %_15
		br i1 %_16, label %if11, label %if12

if11:
			%_20 = load i8*, i8** %current_node
			; Tree.GetHas_Left : 8
			%_21 = bitcast i8* %_20 to i8***
			%_22 = load i8**, i8*** %_21
			%_23 = getelementptr i8*, i8** %_22, i32 8
			%_24 = load i8*, i8** %_23
			%_25 = bitcast i8* %_24 to i1 (i8*)*
			%_26 = call i1 %_25(i8* %_20)
			br i1 %_26, label %if17, label %if18

if17:
				%_27 = load i8*, i8** %current_node
				; Tree.GetLeft : 4
				%_28 = bitcast i8* %_27 to i8***
				%_29 = load i8**, i8*** %_28
				%_30 = getelementptr i8*, i8** %_29, i32 4
				%_31 = load i8*, i8** %_30
				%_32 = bitcast i8* %_31 to i8* (i8*)*
				%_33 = call i8* %_32(i8* %_27)
				store i8* %_33, i8** %current_node
				
				br label %if19

if18:

				store i1 0, i1* %cont
				
				br label %if19

if19:
			
			br label %if13

if12:

			%_37 = load i32, i32* %key_aux
			%_38 = load i32, i32* %v_key
			%_39 = icmp slt i32 %_37, %_38
			br i1 %_39, label %if34, label %if35

if34:
				%_43 = load i8*, i8** %current_node
				; Tree.GetHas_Right : 7
				%_44 = bitcast i8* %_43 to i8***
				%_45 = load i8**, i8*** %_44
				%_46 = getelementptr i8*, i8** %_45, i32 7
				%_47 = load i8*, i8** %_46
				%_48 = bitcast i8* %_47 to i1 (i8*)*
				%_49 = call i1 %_48(i8* %_43)
				br i1 %_49, label %if40, label %if41

if40:
					%_50 = load i8*, i8** %current_node
					; Tree.GetRight : 3
					%_51 = bitcast i8* %_50 to i8***
					%_52 = load i8**, i8*** %_51
					%_53 = getelementptr i8*, i8** %_52, i32 3
					%_54 = load i8*, i8** %_53
					%_55 = bitcast i8* %_54 to i8* (i8*)*
					%_56 = call i8* %_55(i8* %_50)
					store i8* %_56, i8** %current_node
					
					br label %if42

if41:

					store i1 0, i1* %cont
					
					br label %if42

if42:
				
				br label %if36

if35:

				store i32 1, i32* %ifound
				
				store i1 0, i1* %cont
				
				
				br label %if36

if36:
			
			br label %if13

if13:
		
		
		br label %loop0

loop2:
	
	%_57 = load i32, i32* %ifound
	ret i32 %_57
}

define i1 @Tree.Print(i8* %this) {
	%ntb = alloca i1
	
	%current_node = alloca i8*
	
	store i8* %this, i8** %current_node
	
	; Tree.RecPrint : 19
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 19
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i1 (i8*,i8*)*
	%_6 = load i8*, i8** %current_node
	%_5 = call i1 %_4(i8* %this, i8* %_6)
	store i1 %_5, i1* %ntb
	
	ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1
	
	%_3 = load i8*, i8** %node
	; Tree.GetHas_Left : 8
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %if0, label %if1

if0:
		; Tree.RecPrint : 19
		%_10 = bitcast i8* %this to i8***
		%_11 = load i8**, i8*** %_10
		%_12 = getelementptr i8*, i8** %_11, i32 19
		%_13 = load i8*, i8** %_12
		%_14 = bitcast i8* %_13 to i1 (i8*,i8*)*
		%_16 = load i8*, i8** %node
		; Tree.GetLeft : 4
		%_17 = bitcast i8* %_16 to i8***
		%_18 = load i8**, i8*** %_17
		%_19 = getelementptr i8*, i8** %_18, i32 4
		%_20 = load i8*, i8** %_19
		%_21 = bitcast i8* %_20 to i8* (i8*)*
		%_22 = call i8* %_21(i8* %_16)
		%_15 = call i1 %_14(i8* %this, i8* %_22)
		store i1 %_15, i1* %ntb
		
		
		br label %if2

if1:

		store i1 1, i1* %ntb
		
		br label %if2

if2:
	
	%_23 = load i8*, i8** %node
	; Tree.GetKey : 5
	%_24 = bitcast i8* %_23 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 5
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %_23)
	call void (i32) @print_int(i32 %_29)
	
	%_33 = load i8*, i8** %node
	; Tree.GetHas_Right : 7
	%_34 = bitcast i8* %_33 to i8***
	%_35 = load i8**, i8*** %_34
	%_36 = getelementptr i8*, i8** %_35, i32 7
	%_37 = load i8*, i8** %_36
	%_38 = bitcast i8* %_37 to i1 (i8*)*
	%_39 = call i1 %_38(i8* %_33)
	br i1 %_39, label %if30, label %if31

if30:
		; Tree.RecPrint : 19
		%_40 = bitcast i8* %this to i8***
		%_41 = load i8**, i8*** %_40
		%_42 = getelementptr i8*, i8** %_41, i32 19
		%_43 = load i8*, i8** %_42
		%_44 = bitcast i8* %_43 to i1 (i8*,i8*)*
		%_46 = load i8*, i8** %node
		; Tree.GetRight : 3
		%_47 = bitcast i8* %_46 to i8***
		%_48 = load i8**, i8*** %_47
		%_49 = getelementptr i8*, i8** %_48, i32 3
		%_50 = load i8*, i8** %_49
		%_51 = bitcast i8* %_50 to i8* (i8*)*
		%_52 = call i8* %_51(i8* %_46)
		%_45 = call i1 %_44(i8* %this, i8* %_52)
		store i1 %_45, i1* %ntb
		
		
		br label %if32

if31:

		store i1 1, i1* %ntb
		
		br label %if32

if32:
	
	ret i1 1
}

define i32 @Tree.accept(i8* %this, i8* %.v) {
	%v = alloca i8*
	store i8* %.v, i8** %v
	%nti = alloca i32
	
	call void (i32) @print_int(i32 333)
	
	%_0 = load i8*, i8** %v
	; Visitor.visit : 0
	%_1 = bitcast i8* %_0 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 0
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*,i8*)*
	%_6 = call i32 %_5(i8* %_0, i8* %this)
	store i32 %_6, i32* %nti
	
	ret i32 0
}

define i32 @Visitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32
	
	%_3 = load i8*, i8** %n
	; Tree.GetHas_Right : 7
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 7
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %if0, label %if1

if0:
		%_10 = load i8*, i8** %n
		; Tree.GetRight : 3
		%_11 = bitcast i8* %_10 to i8***
		%_12 = load i8**, i8*** %_11
		%_13 = getelementptr i8*, i8** %_12, i32 3
		%_14 = load i8*, i8** %_13
		%_15 = bitcast i8* %_14 to i8* (i8*)*
		%_16 = call i8* %_15(i8* %_10)
		%_17 = getelementptr i8, i8* %this, i32 16
		%_18 = bitcast i8* %_17 to i8**
		store i8* %_16, i8** %_18
		
		%_19 = getelementptr i8, i8* %this, i32 16
		%_20 = bitcast i8* %_19 to i8**
		%_21 = load i8*, i8** %_20
		; Tree.accept : 20
		%_22 = bitcast i8* %_21 to i8***
		%_23 = load i8**, i8*** %_22
		%_24 = getelementptr i8*, i8** %_23, i32 20
		%_25 = load i8*, i8** %_24
		%_26 = bitcast i8* %_25 to i32 (i8*,i8*)*
		%_27 = call i32 %_26(i8* %_21, i8* %this)
		store i32 %_27, i32* %nti
		
		
		br label %if2

if1:

		store i32 0, i32* %nti
		
		br label %if2

if2:
	
	%_31 = load i8*, i8** %n
	; Tree.GetHas_Left : 8
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 8
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*)*
	%_37 = call i1 %_36(i8* %_31)
	br i1 %_37, label %if28, label %if29

if28:
		%_38 = load i8*, i8** %n
		; Tree.GetLeft : 4
		%_39 = bitcast i8* %_38 to i8***
		%_40 = load i8**, i8*** %_39
		%_41 = getelementptr i8*, i8** %_40, i32 4
		%_42 = load i8*, i8** %_41
		%_43 = bitcast i8* %_42 to i8* (i8*)*
		%_44 = call i8* %_43(i8* %_38)
		%_45 = getelementptr i8, i8* %this, i32 8
		%_46 = bitcast i8* %_45 to i8**
		store i8* %_44, i8** %_46
		
		%_47 = getelementptr i8, i8* %this, i32 8
		%_48 = bitcast i8* %_47 to i8**
		%_49 = load i8*, i8** %_48
		; Tree.accept : 20
		%_50 = bitcast i8* %_49 to i8***
		%_51 = load i8**, i8*** %_50
		%_52 = getelementptr i8*, i8** %_51, i32 20
		%_53 = load i8*, i8** %_52
		%_54 = bitcast i8* %_53 to i32 (i8*,i8*)*
		%_55 = call i32 %_54(i8* %_49, i8* %this)
		store i32 %_55, i32* %nti
		
		
		br label %if30

if29:

		store i32 0, i32* %nti
		
		br label %if30

if30:
	
	ret i32 0
}

define i32 @MyVisitor.visit(i8* %this, i8* %.n) {
	%n = alloca i8*
	store i8* %.n, i8** %n
	%nti = alloca i32
	
	%_3 = load i8*, i8** %n
	; Tree.GetHas_Right : 7
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 7
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %if0, label %if1

if0:
		%_10 = load i8*, i8** %n
		; Tree.GetRight : 3
		%_11 = bitcast i8* %_10 to i8***
		%_12 = load i8**, i8*** %_11
		%_13 = getelementptr i8*, i8** %_12, i32 3
		%_14 = load i8*, i8** %_13
		%_15 = bitcast i8* %_14 to i8* (i8*)*
		%_16 = call i8* %_15(i8* %_10)
		%_17 = getelementptr i8, i8* %this, i32 16
		%_18 = bitcast i8* %_17 to i8**
		store i8* %_16, i8** %_18
		
		%_19 = getelementptr i8, i8* %this, i32 16
		%_20 = bitcast i8* %_19 to i8**
		%_21 = load i8*, i8** %_20
		; Tree.accept : 20
		%_22 = bitcast i8* %_21 to i8***
		%_23 = load i8**, i8*** %_22
		%_24 = getelementptr i8*, i8** %_23, i32 20
		%_25 = load i8*, i8** %_24
		%_26 = bitcast i8* %_25 to i32 (i8*,i8*)*
		%_27 = call i32 %_26(i8* %_21, i8* %this)
		store i32 %_27, i32* %nti
		
		
		br label %if2

if1:

		store i32 0, i32* %nti
		
		br label %if2

if2:
	
	%_28 = load i8*, i8** %n
	; Tree.GetKey : 5
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 5
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i32 (i8*)*
	%_34 = call i32 %_33(i8* %_28)
	call void (i32) @print_int(i32 %_34)
	
	%_38 = load i8*, i8** %n
	; Tree.GetHas_Left : 8
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 8
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*)*
	%_44 = call i1 %_43(i8* %_38)
	br i1 %_44, label %if35, label %if36

if35:
		%_45 = load i8*, i8** %n
		; Tree.GetLeft : 4
		%_46 = bitcast i8* %_45 to i8***
		%_47 = load i8**, i8*** %_46
		%_48 = getelementptr i8*, i8** %_47, i32 4
		%_49 = load i8*, i8** %_48
		%_50 = bitcast i8* %_49 to i8* (i8*)*
		%_51 = call i8* %_50(i8* %_45)
		%_52 = getelementptr i8, i8* %this, i32 8
		%_53 = bitcast i8* %_52 to i8**
		store i8* %_51, i8** %_53
		
		%_54 = getelementptr i8, i8* %this, i32 8
		%_55 = bitcast i8* %_54 to i8**
		%_56 = load i8*, i8** %_55
		; Tree.accept : 20
		%_57 = bitcast i8* %_56 to i8***
		%_58 = load i8**, i8*** %_57
		%_59 = getelementptr i8*, i8** %_58, i32 20
		%_60 = load i8*, i8** %_59
		%_61 = bitcast i8* %_60 to i32 (i8*,i8*)*
		%_62 = call i32 %_61(i8* %_56, i8* %this)
		store i32 %_62, i32* %nti
		
		
		br label %if37

if36:

		store i32 0, i32* %nti
		
		br label %if37

if37:
	
	ret i32 0
}
