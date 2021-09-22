@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @BBS.Start to i8*), i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), i8* bitcast (i32 (i8*)* @BBS.Print to i8*), i8* bitcast (i32 (i8*,i32)* @BBS.Init to i8*)]


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
	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; BBS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)
	
	ret i32 0
}

define i32 @BBS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	
	; BBS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*,i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)
	store i32 %_5, i32* %aux01
	
	; BBS.Print : 2
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)
	store i32 %_12, i32* %aux01
	
	call void (i32) @print_int(i32 99999)
	
	; BBS.Sort : 1
	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 1
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i32 (i8*)*
	%_18 = call i32 %_17(i8* %this)
	store i32 %_18, i32* %aux01
	
	; BBS.Print : 2
	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 2
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %this)
	store i32 %_24, i32* %aux01
	
	ret i32 0
}

define i32 @BBS.Sort(i8* %this) {
	%nt = alloca i32
	
	%i = alloca i32
	
	%aux02 = alloca i32
	
	%aux04 = alloca i32
	
	%aux05 = alloca i32
	
	%aux06 = alloca i32
	
	%aux07 = alloca i32
	
	%j = alloca i32
	
	%t = alloca i32
	
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = sub i32 %_2, 1
	store i32 %_3, i32* %i
	
	%_4 = sub i32 0, 1
	store i32 %_4, i32* %aux02
	
	br label %loop5

loop5:
	%_8 = load i32, i32* %aux02
	%_9 = load i32, i32* %i
	%_10 = icmp slt i32 %_8, %_9
	br i1 %_10, label %loop6, label %loop7

loop6:
		store i32 1, i32* %j
		
		br label %loop11

loop11:
		%_14 = load i32, i32* %j
		%_15 = load i32, i32* %i
		%_16 = add i32 %_15, 1
		%_17 = icmp slt i32 %_14, %_16
		br i1 %_17, label %loop12, label %loop13

loop12:
			%_18 = load i32, i32* %j
			%_19 = sub i32 %_18, 1
			store i32 %_19, i32* %aux07
			
			%_29 = getelementptr i8, i8* %this, i32 8
			%_30 = bitcast i8* %_29 to i32**
			%_31 = load i32*, i32** %_30
			%_32 = load i32, i32* %aux07
			%_20 = load i32, i32 *%_31
			%_21 = icmp ult i32 %_32, %_20
			br i1 %_21, label %oob26, label %oob27

oob26:
			%_22 = add i32 %_32, 1
			%_23 = getelementptr i32, i32* %_31, i32 %_22
			%_24 = load i32, i32* %_23
			br label %oob28

oob27:
			call void @throw_oob()
			br label %oob28

oob28:
			store i32 %_24, i32* %aux04
			
			%_42 = getelementptr i8, i8* %this, i32 8
			%_43 = bitcast i8* %_42 to i32**
			%_44 = load i32*, i32** %_43
			%_45 = load i32, i32* %j
			%_33 = load i32, i32 *%_44
			%_34 = icmp ult i32 %_45, %_33
			br i1 %_34, label %oob39, label %oob40

oob39:
			%_35 = add i32 %_45, 1
			%_36 = getelementptr i32, i32* %_44, i32 %_35
			%_37 = load i32, i32* %_36
			br label %oob41

oob40:
			call void @throw_oob()
			br label %oob41

oob41:
			store i32 %_37, i32* %aux05
			
			%_49 = load i32, i32* %aux05
			%_50 = load i32, i32* %aux04
			%_51 = icmp slt i32 %_49, %_50
			br i1 %_51, label %if46, label %if47

if46:
				%_52 = load i32, i32* %j
				%_53 = sub i32 %_52, 1
				store i32 %_53, i32* %aux06
				
				%_63 = getelementptr i8, i8* %this, i32 8
				%_64 = bitcast i8* %_63 to i32**
				%_65 = load i32*, i32** %_64
				%_66 = load i32, i32* %aux06
				%_54 = load i32, i32 *%_65
				%_55 = icmp ult i32 %_66, %_54
				br i1 %_55, label %oob60, label %oob61

oob60:
				%_56 = add i32 %_66, 1
				%_57 = getelementptr i32, i32* %_65, i32 %_56
				%_58 = load i32, i32* %_57
				br label %oob62

oob61:
				call void @throw_oob()
				br label %oob62

oob62:
				store i32 %_58, i32* %t
				
				%_75 = getelementptr i8, i8* %this, i32 8
				%_76 = bitcast i8* %_75 to i32**
				%_77 = load i32*, i32** %_76
				%_78 = load i32, i32* %aux06
				%_67 = load i32, i32 *%_77
				%_68 = icmp ult i32 %_78, %_67
				br i1 %_68, label %oob72, label %oob73

oob72:
				%_69 = add i32 %_78, 1
				%_70 = getelementptr i32, i32* %_77, i32 %_69
				%_88 = getelementptr i8, i8* %this, i32 8
				%_89 = bitcast i8* %_88 to i32**
				%_90 = load i32*, i32** %_89
				%_91 = load i32, i32* %j
				%_79 = load i32, i32 *%_90
				%_80 = icmp ult i32 %_91, %_79
				br i1 %_80, label %oob85, label %oob86

oob85:
				%_81 = add i32 %_91, 1
				%_82 = getelementptr i32, i32* %_90, i32 %_81
				%_83 = load i32, i32* %_82
				br label %oob87

oob86:
				call void @throw_oob()
				br label %oob87

oob87:
				store i32 %_83, i32* %_70
				br label %oob74

oob73:
				call void @throw_oob()
				br label %oob74

oob74:
				
				%_100 = getelementptr i8, i8* %this, i32 8
				%_101 = bitcast i8* %_100 to i32**
				%_102 = load i32*, i32** %_101
				%_103 = load i32, i32* %j
				%_92 = load i32, i32 *%_102
				%_93 = icmp ult i32 %_103, %_92
				br i1 %_93, label %oob97, label %oob98

oob97:
				%_94 = add i32 %_103, 1
				%_95 = getelementptr i32, i32* %_102, i32 %_94
				%_104 = load i32, i32* %t
				store i32 %_104, i32* %_95
				br label %oob99

oob98:
				call void @throw_oob()
				br label %oob99

oob99:
				
				
				br label %if48

if47:

				store i32 0, i32* %nt
				
				br label %if48

if48:
			
			%_105 = load i32, i32* %j
			%_106 = add i32 %_105, 1
			store i32 %_106, i32* %j
			
			
			br label %loop11

loop13:
		
		%_107 = load i32, i32* %i
		%_108 = sub i32 %_107, 1
		store i32 %_108, i32* %i
		
		
		br label %loop5

loop7:
	
	ret i32 0
}

define i32 @BBS.Print(i8* %this) {
	%j = alloca i32
	
	store i32 0, i32* %j
	
	br label %loop0

loop0:
	%_3 = load i32, i32* %j
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = icmp slt i32 %_3, %_6
	br i1 %_7, label %loop1, label %loop2

loop1:
		%_17 = getelementptr i8, i8* %this, i32 8
		%_18 = bitcast i8* %_17 to i32**
		%_19 = load i32*, i32** %_18
		%_20 = load i32, i32* %j
		%_8 = load i32, i32 *%_19
		%_9 = icmp ult i32 %_20, %_8
		br i1 %_9, label %oob14, label %oob15

oob14:
		%_10 = add i32 %_20, 1
		%_11 = getelementptr i32, i32* %_19, i32 %_10
		%_12 = load i32, i32* %_11
		br label %oob16

oob15:
		call void @throw_oob()
		br label %oob16

oob16:
		call void (i32) @print_int(i32 %_12)
		
		%_21 = load i32, i32* %j
		%_22 = add i32 %_21, 1
		store i32 %_22, i32* %j
		
		
		br label %loop0

loop2:
	
	ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_0 = load i32, i32* %sz
	%_1 = getelementptr i8, i8* %this, i32 16
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2
	
	%_9 = load i32, i32* %sz
	%_6 = icmp slt i32 %_9, 0
	br i1 %_6, label %arr_alloc7, label %arr_alloc8

arr_alloc7:
	call void @throw_oob()
	br label %arr_alloc8

arr_alloc8:
	%_3 = add i32 %_9, 1
	%_4 = call i8* @calloc(i32 4, i32 %_3)
	%_5 = bitcast i8* %_4 to i32*
	store i32 %_9, i32* %_5
	%_10 = getelementptr i8, i8* %this, i32 8
	%_11 = bitcast i8* %_10 to i32**
	store i32* %_5, i32** %_11
	
	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i32**
	%_22 = load i32*, i32** %_21
	%_12 = load i32, i32 *%_22
	%_13 = icmp ult i32 0, %_12
	br i1 %_13, label %oob17, label %oob18

oob17:
	%_14 = add i32 0, 1
	%_15 = getelementptr i32, i32* %_22, i32 %_14
	store i32 20, i32* %_15
	br label %oob19

oob18:
	call void @throw_oob()
	br label %oob19

oob19:
	
	%_31 = getelementptr i8, i8* %this, i32 8
	%_32 = bitcast i8* %_31 to i32**
	%_33 = load i32*, i32** %_32
	%_23 = load i32, i32 *%_33
	%_24 = icmp ult i32 1, %_23
	br i1 %_24, label %oob28, label %oob29

oob28:
	%_25 = add i32 1, 1
	%_26 = getelementptr i32, i32* %_33, i32 %_25
	store i32 7, i32* %_26
	br label %oob30

oob29:
	call void @throw_oob()
	br label %oob30

oob30:
	
	%_42 = getelementptr i8, i8* %this, i32 8
	%_43 = bitcast i8* %_42 to i32**
	%_44 = load i32*, i32** %_43
	%_34 = load i32, i32 *%_44
	%_35 = icmp ult i32 2, %_34
	br i1 %_35, label %oob39, label %oob40

oob39:
	%_36 = add i32 2, 1
	%_37 = getelementptr i32, i32* %_44, i32 %_36
	store i32 12, i32* %_37
	br label %oob41

oob40:
	call void @throw_oob()
	br label %oob41

oob41:
	
	%_53 = getelementptr i8, i8* %this, i32 8
	%_54 = bitcast i8* %_53 to i32**
	%_55 = load i32*, i32** %_54
	%_45 = load i32, i32 *%_55
	%_46 = icmp ult i32 3, %_45
	br i1 %_46, label %oob50, label %oob51

oob50:
	%_47 = add i32 3, 1
	%_48 = getelementptr i32, i32* %_55, i32 %_47
	store i32 18, i32* %_48
	br label %oob52

oob51:
	call void @throw_oob()
	br label %oob52

oob52:
	
	%_64 = getelementptr i8, i8* %this, i32 8
	%_65 = bitcast i8* %_64 to i32**
	%_66 = load i32*, i32** %_65
	%_56 = load i32, i32 *%_66
	%_57 = icmp ult i32 4, %_56
	br i1 %_57, label %oob61, label %oob62

oob61:
	%_58 = add i32 4, 1
	%_59 = getelementptr i32, i32* %_66, i32 %_58
	store i32 2, i32* %_59
	br label %oob63

oob62:
	call void @throw_oob()
	br label %oob63

oob63:
	
	%_75 = getelementptr i8, i8* %this, i32 8
	%_76 = bitcast i8* %_75 to i32**
	%_77 = load i32*, i32** %_76
	%_67 = load i32, i32 *%_77
	%_68 = icmp ult i32 5, %_67
	br i1 %_68, label %oob72, label %oob73

oob72:
	%_69 = add i32 5, 1
	%_70 = getelementptr i32, i32* %_77, i32 %_69
	store i32 11, i32* %_70
	br label %oob74

oob73:
	call void @throw_oob()
	br label %oob74

oob74:
	
	%_86 = getelementptr i8, i8* %this, i32 8
	%_87 = bitcast i8* %_86 to i32**
	%_88 = load i32*, i32** %_87
	%_78 = load i32, i32 *%_88
	%_79 = icmp ult i32 6, %_78
	br i1 %_79, label %oob83, label %oob84

oob83:
	%_80 = add i32 6, 1
	%_81 = getelementptr i32, i32* %_88, i32 %_80
	store i32 6, i32* %_81
	br label %oob85

oob84:
	call void @throw_oob()
	br label %oob85

oob85:
	
	%_97 = getelementptr i8, i8* %this, i32 8
	%_98 = bitcast i8* %_97 to i32**
	%_99 = load i32*, i32** %_98
	%_89 = load i32, i32 *%_99
	%_90 = icmp ult i32 7, %_89
	br i1 %_90, label %oob94, label %oob95

oob94:
	%_91 = add i32 7, 1
	%_92 = getelementptr i32, i32* %_99, i32 %_91
	store i32 9, i32* %_92
	br label %oob96

oob95:
	call void @throw_oob()
	br label %oob96

oob96:
	
	%_108 = getelementptr i8, i8* %this, i32 8
	%_109 = bitcast i8* %_108 to i32**
	%_110 = load i32*, i32** %_109
	%_100 = load i32, i32 *%_110
	%_101 = icmp ult i32 8, %_100
	br i1 %_101, label %oob105, label %oob106

oob105:
	%_102 = add i32 8, 1
	%_103 = getelementptr i32, i32* %_110, i32 %_102
	store i32 19, i32* %_103
	br label %oob107

oob106:
	call void @throw_oob()
	br label %oob107

oob107:
	
	%_119 = getelementptr i8, i8* %this, i32 8
	%_120 = bitcast i8* %_119 to i32**
	%_121 = load i32*, i32** %_120
	%_111 = load i32, i32 *%_121
	%_112 = icmp ult i32 9, %_111
	br i1 %_112, label %oob116, label %oob117

oob116:
	%_113 = add i32 9, 1
	%_114 = getelementptr i32, i32* %_121, i32 %_113
	store i32 5, i32* %_114
	br label %oob118

oob117:
	call void @throw_oob()
	br label %oob118

oob118:
	
	ret i32 0
}
