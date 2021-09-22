@.QuickSort_vtable = global [0 x i8*] []
@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*,i32)* @QS.Start to i8*), i8* bitcast (i32 (i8*,i32, i32)* @QS.Sort to i8*), i8* bitcast (i32 (i8*)* @QS.Print to i8*), i8* bitcast (i32 (i8*,i32)* @QS.Init to i8*)]


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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; QS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*,i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)
	
	ret i32 0
}

define i32 @QS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32
	
	; QS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*,i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)
	store i32 %_5, i32* %aux01
	
	; QS.Print : 2
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)
	store i32 %_12, i32* %aux01
	
	call void (i32) @print_int(i32 9999)
	
	%_13 = getelementptr i8, i8* %this, i32 16
	%_14 = bitcast i8* %_13 to i32*
	%_15 = load i32, i32* %_14
	%_16 = sub i32 %_15, 1
	store i32 %_16, i32* %aux01
	
	; QS.Sort : 1
	%_17 = bitcast i8* %this to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 1
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i32 (i8*,i32, i32)*
	%_23 = load i32, i32* %aux01
	%_22 = call i32 %_21(i8* %this, i32 0, i32 %_23)
	store i32 %_22, i32* %aux01
	
	; QS.Print : 2
	%_24 = bitcast i8* %this to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 2
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %this)
	store i32 %_29, i32* %aux01
	
	ret i32 0
}

define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
	%left = alloca i32
	store i32 %.left, i32* %left
	%right = alloca i32
	store i32 %.right, i32* %right
	%v = alloca i32
	
	%i = alloca i32
	
	%j = alloca i32
	
	%nt = alloca i32
	
	%t = alloca i32
	
	%cont01 = alloca i1
	
	%cont02 = alloca i1
	
	%aux03 = alloca i32
	
	store i32 0, i32* %t
	
	%_3 = load i32, i32* %left
	%_4 = load i32, i32* %right
	%_5 = icmp slt i32 %_3, %_4
	br i1 %_5, label %if0, label %if1

if0:
		%_15 = getelementptr i8, i8* %this, i32 8
		%_16 = bitcast i8* %_15 to i32**
		%_17 = load i32*, i32** %_16
		%_18 = load i32, i32* %right
		%_6 = load i32, i32 *%_17
		%_7 = icmp ult i32 %_18, %_6
		br i1 %_7, label %oob12, label %oob13

oob12:
		%_8 = add i32 %_18, 1
		%_9 = getelementptr i32, i32* %_17, i32 %_8
		%_10 = load i32, i32* %_9
		br label %oob14

oob13:
		call void @throw_oob()
		br label %oob14

oob14:
		store i32 %_10, i32* %v
		
		%_19 = load i32, i32* %left
		%_20 = sub i32 %_19, 1
		store i32 %_20, i32* %i
		
		%_21 = load i32, i32* %right
		store i32 %_21, i32* %j
		
		store i1 1, i1* %cont01
		
		br label %loop22

loop22:
		%_25 = load i1, i1* %cont01
		br i1 %_25, label %loop23, label %loop24

loop23:
			store i1 1, i1* %cont02
			
			br label %loop26

loop26:
			%_29 = load i1, i1* %cont02
			br i1 %_29, label %loop27, label %loop28

loop27:
				%_30 = load i32, i32* %i
				%_31 = add i32 %_30, 1
				store i32 %_31, i32* %i
				
				%_41 = getelementptr i8, i8* %this, i32 8
				%_42 = bitcast i8* %_41 to i32**
				%_43 = load i32*, i32** %_42
				%_44 = load i32, i32* %i
				%_32 = load i32, i32 *%_43
				%_33 = icmp ult i32 %_44, %_32
				br i1 %_33, label %oob38, label %oob39

oob38:
				%_34 = add i32 %_44, 1
				%_35 = getelementptr i32, i32* %_43, i32 %_34
				%_36 = load i32, i32* %_35
				br label %oob40

oob39:
				call void @throw_oob()
				br label %oob40

oob40:
				store i32 %_36, i32* %aux03
				
				%_49 = load i32, i32* %aux03
				%_50 = load i32, i32* %v
				%_51 = icmp slt i32 %_49, %_50
				%_48 = xor i1 1, %_51
				br i1 %_48, label %if45, label %if46

if45:
					store i1 0, i1* %cont02
					
					br label %if47

if46:

					store i1 1, i1* %cont02
					
					br label %if47

if47:
				
				
				br label %loop26

loop28:
			
			store i1 1, i1* %cont02
			
			br label %loop52

loop52:
			%_55 = load i1, i1* %cont02
			br i1 %_55, label %loop53, label %loop54

loop53:
				%_56 = load i32, i32* %j
				%_57 = sub i32 %_56, 1
				store i32 %_57, i32* %j
				
				%_67 = getelementptr i8, i8* %this, i32 8
				%_68 = bitcast i8* %_67 to i32**
				%_69 = load i32*, i32** %_68
				%_70 = load i32, i32* %j
				%_58 = load i32, i32 *%_69
				%_59 = icmp ult i32 %_70, %_58
				br i1 %_59, label %oob64, label %oob65

oob64:
				%_60 = add i32 %_70, 1
				%_61 = getelementptr i32, i32* %_69, i32 %_60
				%_62 = load i32, i32* %_61
				br label %oob66

oob65:
				call void @throw_oob()
				br label %oob66

oob66:
				store i32 %_62, i32* %aux03
				
				%_75 = load i32, i32* %v
				%_76 = load i32, i32* %aux03
				%_77 = icmp slt i32 %_75, %_76
				%_74 = xor i1 1, %_77
				br i1 %_74, label %if71, label %if72

if71:
					store i1 0, i1* %cont02
					
					br label %if73

if72:

					store i1 1, i1* %cont02
					
					br label %if73

if73:
				
				
				br label %loop52

loop54:
			
			%_87 = getelementptr i8, i8* %this, i32 8
			%_88 = bitcast i8* %_87 to i32**
			%_89 = load i32*, i32** %_88
			%_90 = load i32, i32* %i
			%_78 = load i32, i32 *%_89
			%_79 = icmp ult i32 %_90, %_78
			br i1 %_79, label %oob84, label %oob85

oob84:
			%_80 = add i32 %_90, 1
			%_81 = getelementptr i32, i32* %_89, i32 %_80
			%_82 = load i32, i32* %_81
			br label %oob86

oob85:
			call void @throw_oob()
			br label %oob86

oob86:
			store i32 %_82, i32* %t
			
			%_99 = getelementptr i8, i8* %this, i32 8
			%_100 = bitcast i8* %_99 to i32**
			%_101 = load i32*, i32** %_100
			%_102 = load i32, i32* %i
			%_91 = load i32, i32 *%_101
			%_92 = icmp ult i32 %_102, %_91
			br i1 %_92, label %oob96, label %oob97

oob96:
			%_93 = add i32 %_102, 1
			%_94 = getelementptr i32, i32* %_101, i32 %_93
			%_112 = getelementptr i8, i8* %this, i32 8
			%_113 = bitcast i8* %_112 to i32**
			%_114 = load i32*, i32** %_113
			%_115 = load i32, i32* %j
			%_103 = load i32, i32 *%_114
			%_104 = icmp ult i32 %_115, %_103
			br i1 %_104, label %oob109, label %oob110

oob109:
			%_105 = add i32 %_115, 1
			%_106 = getelementptr i32, i32* %_114, i32 %_105
			%_107 = load i32, i32* %_106
			br label %oob111

oob110:
			call void @throw_oob()
			br label %oob111

oob111:
			store i32 %_107, i32* %_94
			br label %oob98

oob97:
			call void @throw_oob()
			br label %oob98

oob98:
			
			%_124 = getelementptr i8, i8* %this, i32 8
			%_125 = bitcast i8* %_124 to i32**
			%_126 = load i32*, i32** %_125
			%_127 = load i32, i32* %j
			%_116 = load i32, i32 *%_126
			%_117 = icmp ult i32 %_127, %_116
			br i1 %_117, label %oob121, label %oob122

oob121:
			%_118 = add i32 %_127, 1
			%_119 = getelementptr i32, i32* %_126, i32 %_118
			%_128 = load i32, i32* %t
			store i32 %_128, i32* %_119
			br label %oob123

oob122:
			call void @throw_oob()
			br label %oob123

oob123:
			
			%_132 = load i32, i32* %j
			%_133 = load i32, i32* %i
			%_134 = add i32 %_133, 1
			%_135 = icmp slt i32 %_132, %_134
			br i1 %_135, label %if129, label %if130

if129:
				store i1 0, i1* %cont01
				
				br label %if131

if130:

				store i1 1, i1* %cont01
				
				br label %if131

if131:
			
			
			br label %loop22

loop24:
		
		%_144 = getelementptr i8, i8* %this, i32 8
		%_145 = bitcast i8* %_144 to i32**
		%_146 = load i32*, i32** %_145
		%_147 = load i32, i32* %j
		%_136 = load i32, i32 *%_146
		%_137 = icmp ult i32 %_147, %_136
		br i1 %_137, label %oob141, label %oob142

oob141:
		%_138 = add i32 %_147, 1
		%_139 = getelementptr i32, i32* %_146, i32 %_138
		%_157 = getelementptr i8, i8* %this, i32 8
		%_158 = bitcast i8* %_157 to i32**
		%_159 = load i32*, i32** %_158
		%_160 = load i32, i32* %i
		%_148 = load i32, i32 *%_159
		%_149 = icmp ult i32 %_160, %_148
		br i1 %_149, label %oob154, label %oob155

oob154:
		%_150 = add i32 %_160, 1
		%_151 = getelementptr i32, i32* %_159, i32 %_150
		%_152 = load i32, i32* %_151
		br label %oob156

oob155:
		call void @throw_oob()
		br label %oob156

oob156:
		store i32 %_152, i32* %_139
		br label %oob143

oob142:
		call void @throw_oob()
		br label %oob143

oob143:
		
		%_169 = getelementptr i8, i8* %this, i32 8
		%_170 = bitcast i8* %_169 to i32**
		%_171 = load i32*, i32** %_170
		%_172 = load i32, i32* %i
		%_161 = load i32, i32 *%_171
		%_162 = icmp ult i32 %_172, %_161
		br i1 %_162, label %oob166, label %oob167

oob166:
		%_163 = add i32 %_172, 1
		%_164 = getelementptr i32, i32* %_171, i32 %_163
		%_182 = getelementptr i8, i8* %this, i32 8
		%_183 = bitcast i8* %_182 to i32**
		%_184 = load i32*, i32** %_183
		%_185 = load i32, i32* %right
		%_173 = load i32, i32 *%_184
		%_174 = icmp ult i32 %_185, %_173
		br i1 %_174, label %oob179, label %oob180

oob179:
		%_175 = add i32 %_185, 1
		%_176 = getelementptr i32, i32* %_184, i32 %_175
		%_177 = load i32, i32* %_176
		br label %oob181

oob180:
		call void @throw_oob()
		br label %oob181

oob181:
		store i32 %_177, i32* %_164
		br label %oob168

oob167:
		call void @throw_oob()
		br label %oob168

oob168:
		
		%_194 = getelementptr i8, i8* %this, i32 8
		%_195 = bitcast i8* %_194 to i32**
		%_196 = load i32*, i32** %_195
		%_197 = load i32, i32* %right
		%_186 = load i32, i32 *%_196
		%_187 = icmp ult i32 %_197, %_186
		br i1 %_187, label %oob191, label %oob192

oob191:
		%_188 = add i32 %_197, 1
		%_189 = getelementptr i32, i32* %_196, i32 %_188
		%_198 = load i32, i32* %t
		store i32 %_198, i32* %_189
		br label %oob193

oob192:
		call void @throw_oob()
		br label %oob193

oob193:
		
		; QS.Sort : 1
		%_199 = bitcast i8* %this to i8***
		%_200 = load i8**, i8*** %_199
		%_201 = getelementptr i8*, i8** %_200, i32 1
		%_202 = load i8*, i8** %_201
		%_203 = bitcast i8* %_202 to i32 (i8*,i32, i32)*
		%_205 = load i32, i32* %left
		%_206 = load i32, i32* %i
		%_207 = sub i32 %_206, 1
		%_204 = call i32 %_203(i8* %this, i32 %_205, i32 %_207)
		store i32 %_204, i32* %nt
		
		; QS.Sort : 1
		%_208 = bitcast i8* %this to i8***
		%_209 = load i8**, i8*** %_208
		%_210 = getelementptr i8*, i8** %_209, i32 1
		%_211 = load i8*, i8** %_210
		%_212 = bitcast i8* %_211 to i32 (i8*,i32, i32)*
		%_214 = load i32, i32* %i
		%_215 = add i32 %_214, 1
		%_216 = load i32, i32* %right
		%_213 = call i32 %_212(i8* %this, i32 %_215, i32 %_216)
		store i32 %_213, i32* %nt
		
		
		br label %if2

if1:

		store i32 0, i32* %nt
		
		br label %if2

if2:
	
	ret i32 0
}

define i32 @QS.Print(i8* %this) {
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

define i32 @QS.Init(i8* %this, i32 %.sz) {
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
