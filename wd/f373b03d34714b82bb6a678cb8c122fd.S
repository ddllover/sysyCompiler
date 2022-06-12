decl @getint(): i32
decl @getch(): i32
decl @getarray(*i32): i32
decl @putint(i32)
decl @putch(i32)
decl @putarray(i32, *i32)
decl @starttime()
decl @stoptime()

global @SHIFT_TABLE = alloc [i32,16] , {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768 }
fun @long_func():i32 {
%entry:
  @ans_1= alloc i32

  @i_1= alloc i32

  @x_1= alloc i32

  @y_1= alloc i32

  @cur_1= alloc i32

  @pl_2= alloc i32
  store 2, @pl_2

  @pr_2= alloc i32
  store 0, @pr_2

  @pres_2= alloc i32
  store 1, @pres_2

  jump %while_entry_1

%while_entry_1:
  %0 = load @pr_2
  %1 = gt %0, 0
  br %1, %while_body_1, %while_end_1

%while_body_1:
  store 0, @ans_1

  store 0, @i_1

  %2 = load @pr_2
  store %2, @x_1

  store 1, @y_1

  jump %while_entry_2

%while_entry_2:
  %3 = load @i_1
  %4 = lt %3, 16
  br %4, %while_body_2, %while_end_2

%while_body_2:
  @result_2 = alloc i32
  store 0,@result_2
  %5 = load @x_1
  %6 = mod %5, 2
  %7 = ne 0, %6
  br %7, %then_2, %if_end_2

%then_2:
  %8 = load @y_1
  %9 = mod %8, 2
  %10 = ne 0, %9
 store %10,@result_2
  jump %if_end_2

%if_end_2:
  %11= load @result_2
  br %11, %then_1, %if_end_1

%then_1:
  %12 = load @ans_1
  %13 = load @i_1
  %14 = getelemptr @SHIFT_TABLE, %13
  %15 = load %14

  %16 = mul 1, %15
  %17 = add %12, %16
  store %17, @ans_1

  jump %if_end_1

%if_end_1:
  %18 = load @x_1
  %19 = div %18, 2
  store %19, @x_1

  %20 = load @y_1
  %21 = div %20, 2
  store %21, @y_1

  %22 = load @i_1
  %23 = add %22, 1
  store %23, @i_1

  jump %while_entry_2

%while_end_2:
  %24 = load @ans_1
  br %24, %then_3, %if_end_3

%then_3:
  @ml_7= alloc i32
  %25 = load @pres_2
  store %25, @ml_7

  @mr_7= alloc i32
  %26 = load @pl_2
  store %26, @mr_7

  @mres_7= alloc i32
  store 0, @mres_7

  jump %while_entry_3

%while_entry_3:
  %27 = load @mr_7
  br %27, %while_body_3, %while_end_3

%while_body_3:
  store 0, @ans_1

  store 0, @i_1

  %28 = load @mr_7
  store %28, @x_1

  store 1, @y_1

  jump %while_entry_4

%while_entry_4:
  %29 = load @i_1
  %30 = lt %29, 16
  br %30, %while_body_4, %while_end_4

%while_body_4:
  @result_5 = alloc i32
  store 0,@result_5
  %31 = load @x_1
  %32 = mod %31, 2
  %33 = ne 0, %32
  br %33, %then_5, %if_end_5

%then_5:
  %34 = load @y_1
  %35 = mod %34, 2
  %36 = ne 0, %35
 store %36,@result_5
  jump %if_end_5

%if_end_5:
  %37= load @result_5
  br %37, %then_4, %if_end_4

%then_4:
  %38 = load @ans_1
  %39 = load @i_1
  %40 = getelemptr @SHIFT_TABLE, %39
  %41 = load %40

  %42 = mul 1, %41
  %43 = add %38, %42
  store %43, @ans_1

  jump %if_end_4

%if_end_4:
  %44 = load @x_1
  %45 = div %44, 2
  store %45, @x_1

  %46 = load @y_1
  %47 = div %46, 2
  store %47, @y_1

  %48 = load @i_1
  %49 = add %48, 1
  store %49, @i_1

  jump %while_entry_4

%while_end_4:
  %50 = load @ans_1
  br %50, %then_6, %if_end_6

%then_6:
  @al_12= alloc i32
  %51 = load @mres_7
  store %51, @al_12

  @c_12= alloc i32
  %52 = load @ml_7
  store %52, @c_12

  @sum_12= alloc i32

  jump %while_entry_5

%while_entry_5:
  %53 = load @c_12
  br %53, %while_body_5, %while_end_5

%while_body_5:
  store 0, @ans_1

  store 0, @i_1

  %54 = load @al_12
  store %54, @x_1

  %55 = load @c_12
  store %55, @y_1

  jump %while_entry_6

%while_entry_6:
  %56 = load @i_1
  %57 = lt %56, 16
  br %57, %while_body_6, %while_end_6

%while_body_6:
  %58 = load @x_1
  %59 = mod %58, 2
  br %59, %then_7, %else_7

%then_7:
  %60 = load @y_1
  %61 = mod %60, 2
  %62 = eq %61, 0
  br %62, %then_8, %if_end_8

%then_8:
  %63 = load @ans_1
  %64 = load @i_1
  %65 = getelemptr @SHIFT_TABLE, %64
  %66 = load %65

  %67 = mul 1, %66
  %68 = add %63, %67
  store %68, @ans_1

  jump %if_end_8

%if_end_8:
  jump %if_end_7

%else_7:
  %69 = load @y_1
  %70 = mod %69, 2
  br %70, %then_9, %if_end_9

%then_9:
  %71 = load @ans_1
  %72 = load @i_1
  %73 = getelemptr @SHIFT_TABLE, %72
  %74 = load %73

  %75 = mul 1, %74
  %76 = add %71, %75
  store %76, @ans_1

  jump %if_end_9

%if_end_9:
  jump %if_end_7

%if_end_7:
  %77 = load @x_1
  %78 = div %77, 2
  store %78, @x_1

  %79 = load @y_1
  %80 = div %79, 2
  store %80, @y_1

  %81 = load @i_1
  %82 = add %81, 1
  store %82, @i_1

  jump %while_entry_6

%while_end_6:
  %83 = load @ans_1
  store %83, @sum_12

  store 0, @ans_1

  store 0, @i_1

  %84 = load @al_12
  store %84, @x_1

  %85 = load @c_12
  store %85, @y_1

  jump %while_entry_7

%while_entry_7:
  %86 = load @i_1
  %87 = lt %86, 16
  br %87, %while_body_7, %while_end_7

%while_body_7:
  @result_11 = alloc i32
  store 0,@result_11
  %88 = load @x_1
  %89 = mod %88, 2
  %90 = ne 0, %89
  br %90, %then_11, %if_end_11

%then_11:
  %91 = load @y_1
  %92 = mod %91, 2
  %93 = ne 0, %92
 store %93,@result_11
  jump %if_end_11

%if_end_11:
  %94= load @result_11
  br %94, %then_10, %if_end_10

%then_10:
  %95 = load @ans_1
  %96 = load @i_1
  %97 = getelemptr @SHIFT_TABLE, %96
  %98 = load %97

  %99 = mul 1, %98
  %100 = add %95, %99
  store %100, @ans_1

  jump %if_end_10

%if_end_10:
  %101 = load @x_1
  %102 = div %101, 2
  store %102, @x_1

  %103 = load @y_1
  %104 = div %103, 2
  store %104, @y_1

  %105 = load @i_1
  %106 = add %105, 1
  store %106, @i_1

  jump %while_entry_7

%while_end_7:
  %107 = load @ans_1
  store %107, @c_12

  %108 = gt 1, 15
  br %108, %then_12, %else_12

%then_12:
  store 0, @ans_1

  jump %if_end_12

%else_12:
  store 0, @ans_1

  store 0, @i_1

  %109 = load @c_12
  %110 = getelemptr @SHIFT_TABLE, 1
  %111 = load %110

  %112 = mul %109, %111
  store %112, @x_1

  store 65535, @y_1

  jump %while_entry_8

%while_entry_8:
  %113 = load @i_1
  %114 = lt %113, 16
  br %114, %while_body_8, %while_end_8

%while_body_8:
  @result_14 = alloc i32
  store 0,@result_14
  %115 = load @x_1
  %116 = mod %115, 2
  %117 = ne 0, %116
  br %117, %then_14, %if_end_14

%then_14:
  %118 = load @y_1
  %119 = mod %118, 2
  %120 = ne 0, %119
 store %120,@result_14
  jump %if_end_14

%if_end_14:
  %121= load @result_14
  br %121, %then_13, %if_end_13

%then_13:
  %122 = load @ans_1
  %123 = load @i_1
  %124 = getelemptr @SHIFT_TABLE, %123
  %125 = load %124

  %126 = mul 1, %125
  %127 = add %122, %126
  store %127, @ans_1

  jump %if_end_13

%if_end_13:
  %128 = load @x_1
  %129 = div %128, 2
  store %129, @x_1

  %130 = load @y_1
  %131 = div %130, 2
  store %131, @y_1

  %132 = load @i_1
  %133 = add %132, 1
  store %133, @i_1

  jump %while_entry_8

%while_end_8:
  jump %if_end_12

%if_end_12:
  %134 = load @ans_1
  store %134, @c_12

  %135 = load @sum_12
  store %135, @al_12

  jump %while_entry_5

%while_end_5:
  %136 = load @al_12
  store %136, @ans_1

  %137 = load @ans_1
  store %137, @mres_7

  jump %if_end_6

%if_end_6:
  @al_24= alloc i32
  %138 = load @ml_7
  store %138, @al_24

  @c_24= alloc i32
  %139 = load @ml_7
  store %139, @c_24

  @sum_24= alloc i32

  jump %while_entry_9

%while_entry_9:
  %140 = load @c_24
  br %140, %while_body_9, %while_end_9

%while_body_9:
  store 0, @ans_1

  store 0, @i_1

  %141 = load @al_24
  store %141, @x_1

  %142 = load @c_24
  store %142, @y_1

  jump %while_entry_10

%while_entry_10:
  %143 = load @i_1
  %144 = lt %143, 16
  br %144, %while_body_10, %while_end_10

%while_body_10:
  %145 = load @x_1
  %146 = mod %145, 2
  br %146, %then_15, %else_15

%then_15:
  %147 = load @y_1
  %148 = mod %147, 2
  %149 = eq %148, 0
  br %149, %then_16, %if_end_16

%then_16:
  %150 = load @ans_1
  %151 = load @i_1
  %152 = getelemptr @SHIFT_TABLE, %151
  %153 = load %152

  %154 = mul 1, %153
  %155 = add %150, %154
  store %155, @ans_1

  jump %if_end_16

%if_end_16:
  jump %if_end_15

%else_15:
  %156 = load @y_1
  %157 = mod %156, 2
  br %157, %then_17, %if_end_17

%then_17:
  %158 = load @ans_1
  %159 = load @i_1
  %160 = getelemptr @SHIFT_TABLE, %159
  %161 = load %160

  %162 = mul 1, %161
  %163 = add %158, %162
  store %163, @ans_1

  jump %if_end_17

%if_end_17:
  jump %if_end_15

%if_end_15:
  %164 = load @x_1
  %165 = div %164, 2
  store %165, @x_1

  %166 = load @y_1
  %167 = div %166, 2
  store %167, @y_1

  %168 = load @i_1
  %169 = add %168, 1
  store %169, @i_1

  jump %while_entry_10

%while_end_10:
  %170 = load @ans_1
  store %170, @sum_24

  store 0, @ans_1

  store 0, @i_1

  %171 = load @al_24
  store %171, @x_1

  %172 = load @c_24
  store %172, @y_1

  jump %while_entry_11

%while_entry_11:
  %173 = load @i_1
  %174 = lt %173, 16
  br %174, %while_body_11, %while_end_11

%while_body_11:
  @result_19 = alloc i32
  store 0,@result_19
  %175 = load @x_1
  %176 = mod %175, 2
  %177 = ne 0, %176
  br %177, %then_19, %if_end_19

%then_19:
  %178 = load @y_1
  %179 = mod %178, 2
  %180 = ne 0, %179
 store %180,@result_19
  jump %if_end_19

%if_end_19:
  %181= load @result_19
  br %181, %then_18, %if_end_18

%then_18:
  %182 = load @ans_1
  %183 = load @i_1
  %184 = getelemptr @SHIFT_TABLE, %183
  %185 = load %184

  %186 = mul 1, %185
  %187 = add %182, %186
  store %187, @ans_1

  jump %if_end_18

%if_end_18:
  %188 = load @x_1
  %189 = div %188, 2
  store %189, @x_1

  %190 = load @y_1
  %191 = div %190, 2
  store %191, @y_1

  %192 = load @i_1
  %193 = add %192, 1
  store %193, @i_1

  jump %while_entry_11

%while_end_11:
  %194 = load @ans_1
  store %194, @c_24

  %195 = gt 1, 15
  br %195, %then_20, %else_20

%then_20:
  store 0, @ans_1

  jump %if_end_20

%else_20:
  store 0, @ans_1

  store 0, @i_1

  %196 = load @c_24
  %197 = getelemptr @SHIFT_TABLE, 1
  %198 = load %197

  %199 = mul %196, %198
  store %199, @x_1

  store 65535, @y_1

  jump %while_entry_12

%while_entry_12:
  %200 = load @i_1
  %201 = lt %200, 16
  br %201, %while_body_12, %while_end_12

%while_body_12:
  @result_22 = alloc i32
  store 0,@result_22
  %202 = load @x_1
  %203 = mod %202, 2
  %204 = ne 0, %203
  br %204, %then_22, %if_end_22

%then_22:
  %205 = load @y_1
  %206 = mod %205, 2
  %207 = ne 0, %206
 store %207,@result_22
  jump %if_end_22

%if_end_22:
  %208= load @result_22
  br %208, %then_21, %if_end_21

%then_21:
  %209 = load @ans_1
  %210 = load @i_1
  %211 = getelemptr @SHIFT_TABLE, %210
  %212 = load %211

  %213 = mul 1, %212
  %214 = add %209, %213
  store %214, @ans_1

  jump %if_end_21

%if_end_21:
  %215 = load @x_1
  %216 = div %215, 2
  store %216, @x_1

  %217 = load @y_1
  %218 = div %217, 2
  store %218, @y_1

  %219 = load @i_1
  %220 = add %219, 1
  store %220, @i_1

  jump %while_entry_12

%while_end_12:
  jump %if_end_20

%if_end_20:
  %221 = load @ans_1
  store %221, @c_24

  %222 = load @sum_24
  store %222, @al_24

  jump %while_entry_9

%while_end_9:
  %223 = load @al_24
  store %223, @ans_1

  %224 = load @ans_1
  store %224, @ml_7

  %225 = load @mr_7
  store %225, @x_1

  store 1, @y_1

  %226 = load @y_1
  %227 = ge %226, 15
  br %227, %then_23, %else_23

%then_23:
  %228 = load @x_1
  %229 = lt %228, 0
  br %229, %then_24, %else_24

%then_24:
  store 65535, @ans_1

  jump %if_end_24

%else_24:
  store 0, @ans_1

  jump %if_end_24

%if_end_24:
  jump %if_end_23

%else_23:
  %230 = load @y_1
  %231 = gt %230, 0
  br %231, %then_25, %else_25

%then_25:
  %232 = load @x_1
  %233 = gt %232, 32767
  br %233, %then_26, %else_26

%then_26:
  %234 = load @x_1
  %235 = load @y_1
  %236 = getelemptr @SHIFT_TABLE, %235
  %237 = load %236

  %238 = div %234, %237
  store %238, @x_1

  %239 = load @x_1
  %240 = add %239, 65536
  %241 = load @y_1
  %242 = sub 15, %241
  %243 = add %242, 1
  %244 = getelemptr @SHIFT_TABLE, %243
  %245 = load %244

  %246 = sub %240, %245
  store %246, @ans_1

  jump %if_end_26

%else_26:
  %247 = load @x_1
  %248 = load @y_1
  %249 = getelemptr @SHIFT_TABLE, %248
  %250 = load %249

  %251 = div %247, %250
  store %251, @ans_1

  jump %if_end_26

%if_end_26:
  jump %if_end_25

%else_25:
  %252 = load @x_1
  store %252, @ans_1

  jump %if_end_25

%if_end_25:
  jump %if_end_23

%if_end_23:
  %253 = load @ans_1
  store %253, @mr_7

  jump %while_entry_3

%while_end_3:
  %254 = load @mres_7
  store %254, @ans_1

  %255 = load @ans_1
  store %255, @pres_2

  jump %if_end_3

%if_end_3:
  @ml_43= alloc i32
  %256 = load @pl_2
  store %256, @ml_43

  @mr_43= alloc i32
  %257 = load @pl_2
  store %257, @mr_43

  @mres_43= alloc i32
  store 0, @mres_43

  jump %while_entry_13

%while_entry_13:
  %258 = load @mr_43
  br %258, %while_body_13, %while_end_13

%while_body_13:
  store 0, @ans_1

  store 0, @i_1

  %259 = load @mr_43
  store %259, @x_1

  store 1, @y_1

  jump %while_entry_14

%while_entry_14:
  %260 = load @i_1
  %261 = lt %260, 16
  br %261, %while_body_14, %while_end_14

%while_body_14:
  @result_28 = alloc i32
  store 0,@result_28
  %262 = load @x_1
  %263 = mod %262, 2
  %264 = ne 0, %263
  br %264, %then_28, %if_end_28

%then_28:
  %265 = load @y_1
  %266 = mod %265, 2
  %267 = ne 0, %266
 store %267,@result_28
  jump %if_end_28

%if_end_28:
  %268= load @result_28
  br %268, %then_27, %if_end_27

%then_27:
  %269 = load @ans_1
  %270 = load @i_1
  %271 = getelemptr @SHIFT_TABLE, %270
  %272 = load %271

  %273 = mul 1, %272
  %274 = add %269, %273
  store %274, @ans_1

  jump %if_end_27

%if_end_27:
  %275 = load @x_1
  %276 = div %275, 2
  store %276, @x_1

  %277 = load @y_1
  %278 = div %277, 2
  store %278, @y_1

  %279 = load @i_1
  %280 = add %279, 1
  store %280, @i_1

  jump %while_entry_14

%while_end_14:
  %281 = load @ans_1
  br %281, %then_29, %if_end_29

%then_29:
  @al_48= alloc i32
  %282 = load @mres_43
  store %282, @al_48

  @c_48= alloc i32
  %283 = load @ml_43
  store %283, @c_48

  @sum_48= alloc i32

  jump %while_entry_15

%while_entry_15:
  %284 = load @c_48
  br %284, %while_body_15, %while_end_15

%while_body_15:
  store 0, @ans_1

  store 0, @i_1

  %285 = load @al_48
  store %285, @x_1

  %286 = load @c_48
  store %286, @y_1

  jump %while_entry_16

%while_entry_16:
  %287 = load @i_1
  %288 = lt %287, 16
  br %288, %while_body_16, %while_end_16

%while_body_16:
  %289 = load @x_1
  %290 = mod %289, 2
  br %290, %then_30, %else_30

%then_30:
  %291 = load @y_1
  %292 = mod %291, 2
  %293 = eq %292, 0
  br %293, %then_31, %if_end_31

%then_31:
  %294 = load @ans_1
  %295 = load @i_1
  %296 = getelemptr @SHIFT_TABLE, %295
  %297 = load %296

  %298 = mul 1, %297
  %299 = add %294, %298
  store %299, @ans_1

  jump %if_end_31

%if_end_31:
  jump %if_end_30

%else_30:
  %300 = load @y_1
  %301 = mod %300, 2
  br %301, %then_32, %if_end_32

%then_32:
  %302 = load @ans_1
  %303 = load @i_1
  %304 = getelemptr @SHIFT_TABLE, %303
  %305 = load %304

  %306 = mul 1, %305
  %307 = add %302, %306
  store %307, @ans_1

  jump %if_end_32

%if_end_32:
  jump %if_end_30

%if_end_30:
  %308 = load @x_1
  %309 = div %308, 2
  store %309, @x_1

  %310 = load @y_1
  %311 = div %310, 2
  store %311, @y_1

  %312 = load @i_1
  %313 = add %312, 1
  store %313, @i_1

  jump %while_entry_16

%while_end_16:
  %314 = load @ans_1
  store %314, @sum_48

  store 0, @ans_1

  store 0, @i_1

  %315 = load @al_48
  store %315, @x_1

  %316 = load @c_48
  store %316, @y_1

  jump %while_entry_17

%while_entry_17:
  %317 = load @i_1
  %318 = lt %317, 16
  br %318, %while_body_17, %while_end_17

%while_body_17:
  @result_34 = alloc i32
  store 0,@result_34
  %319 = load @x_1
  %320 = mod %319, 2
  %321 = ne 0, %320
  br %321, %then_34, %if_end_34

%then_34:
  %322 = load @y_1
  %323 = mod %322, 2
  %324 = ne 0, %323
 store %324,@result_34
  jump %if_end_34

%if_end_34:
  %325= load @result_34
  br %325, %then_33, %if_end_33

%then_33:
  %326 = load @ans_1
  %327 = load @i_1
  %328 = getelemptr @SHIFT_TABLE, %327
  %329 = load %328

  %330 = mul 1, %329
  %331 = add %326, %330
  store %331, @ans_1

  jump %if_end_33

%if_end_33:
  %332 = load @x_1
  %333 = div %332, 2
  store %333, @x_1

  %334 = load @y_1
  %335 = div %334, 2
  store %335, @y_1

  %336 = load @i_1
  %337 = add %336, 1
  store %337, @i_1

  jump %while_entry_17

%while_end_17:
  %338 = load @ans_1
  store %338, @c_48

  %339 = gt 1, 15
  br %339, %then_35, %else_35

%then_35:
  store 0, @ans_1

  jump %if_end_35

%else_35:
  store 0, @ans_1

  store 0, @i_1

  %340 = load @c_48
  %341 = getelemptr @SHIFT_TABLE, 1
  %342 = load %341

  %343 = mul %340, %342
  store %343, @x_1

  store 65535, @y_1

  jump %while_entry_18

%while_entry_18:
  %344 = load @i_1
  %345 = lt %344, 16
  br %345, %while_body_18, %while_end_18

%while_body_18:
  @result_37 = alloc i32
  store 0,@result_37
  %346 = load @x_1
  %347 = mod %346, 2
  %348 = ne 0, %347
  br %348, %then_37, %if_end_37

%then_37:
  %349 = load @y_1
  %350 = mod %349, 2
  %351 = ne 0, %350
 store %351,@result_37
  jump %if_end_37

%if_end_37:
  %352= load @result_37
  br %352, %then_36, %if_end_36

%then_36:
  %353 = load @ans_1
  %354 = load @i_1
  %355 = getelemptr @SHIFT_TABLE, %354
  %356 = load %355

  %357 = mul 1, %356
  %358 = add %353, %357
  store %358, @ans_1

  jump %if_end_36

%if_end_36:
  %359 = load @x_1
  %360 = div %359, 2
  store %360, @x_1

  %361 = load @y_1
  %362 = div %361, 2
  store %362, @y_1

  %363 = load @i_1
  %364 = add %363, 1
  store %364, @i_1

  jump %while_entry_18

%while_end_18:
  jump %if_end_35

%if_end_35:
  %365 = load @ans_1
  store %365, @c_48

  %366 = load @sum_48
  store %366, @al_48

  jump %while_entry_15

%while_end_15:
  %367 = load @al_48
  store %367, @ans_1

  %368 = load @ans_1
  store %368, @mres_43

  jump %if_end_29

%if_end_29:
  @al_60= alloc i32
  %369 = load @ml_43
  store %369, @al_60

  @c_60= alloc i32
  %370 = load @ml_43
  store %370, @c_60

  @sum_60= alloc i32

  jump %while_entry_19

%while_entry_19:
  %371 = load @c_60
  br %371, %while_body_19, %while_end_19

%while_body_19:
  store 0, @ans_1

  store 0, @i_1

  %372 = load @al_60
  store %372, @x_1

  %373 = load @c_60
  store %373, @y_1

  jump %while_entry_20

%while_entry_20:
  %374 = load @i_1
  %375 = lt %374, 16
  br %375, %while_body_20, %while_end_20

%while_body_20:
  %376 = load @x_1
  %377 = mod %376, 2
  br %377, %then_38, %else_38

%then_38:
  %378 = load @y_1
  %379 = mod %378, 2
  %380 = eq %379, 0
  br %380, %then_39, %if_end_39

%then_39:
  %381 = load @ans_1
  %382 = load @i_1
  %383 = getelemptr @SHIFT_TABLE, %382
  %384 = load %383

  %385 = mul 1, %384
  %386 = add %381, %385
  store %386, @ans_1

  jump %if_end_39

%if_end_39:
  jump %if_end_38

%else_38:
  %387 = load @y_1
  %388 = mod %387, 2
  br %388, %then_40, %if_end_40

%then_40:
  %389 = load @ans_1
  %390 = load @i_1
  %391 = getelemptr @SHIFT_TABLE, %390
  %392 = load %391

  %393 = mul 1, %392
  %394 = add %389, %393
  store %394, @ans_1

  jump %if_end_40

%if_end_40:
  jump %if_end_38

%if_end_38:
  %395 = load @x_1
  %396 = div %395, 2
  store %396, @x_1

  %397 = load @y_1
  %398 = div %397, 2
  store %398, @y_1

  %399 = load @i_1
  %400 = add %399, 1
  store %400, @i_1

  jump %while_entry_20

%while_end_20:
  %401 = load @ans_1
  store %401, @sum_60

  store 0, @ans_1

  store 0, @i_1

  %402 = load @al_60
  store %402, @x_1

  %403 = load @c_60
  store %403, @y_1

  jump %while_entry_21

%while_entry_21:
  %404 = load @i_1
  %405 = lt %404, 16
  br %405, %while_body_21, %while_end_21

%while_body_21:
  @result_42 = alloc i32
  store 0,@result_42
  %406 = load @x_1
  %407 = mod %406, 2
  %408 = ne 0, %407
  br %408, %then_42, %if_end_42

%then_42:
  %409 = load @y_1
  %410 = mod %409, 2
  %411 = ne 0, %410
 store %411,@result_42
  jump %if_end_42

%if_end_42:
  %412= load @result_42
  br %412, %then_41, %if_end_41

%then_41:
  %413 = load @ans_1
  %414 = load @i_1
  %415 = getelemptr @SHIFT_TABLE, %414
  %416 = load %415

  %417 = mul 1, %416
  %418 = add %413, %417
  store %418, @ans_1

  jump %if_end_41

%if_end_41:
  %419 = load @x_1
  %420 = div %419, 2
  store %420, @x_1

  %421 = load @y_1
  %422 = div %421, 2
  store %422, @y_1

  %423 = load @i_1
  %424 = add %423, 1
  store %424, @i_1

  jump %while_entry_21

%while_end_21:
  %425 = load @ans_1
  store %425, @c_60

  %426 = gt 1, 15
  br %426, %then_43, %else_43

%then_43:
  store 0, @ans_1

  jump %if_end_43

%else_43:
  store 0, @ans_1

  store 0, @i_1

  %427 = load @c_60
  %428 = getelemptr @SHIFT_TABLE, 1
  %429 = load %428

  %430 = mul %427, %429
  store %430, @x_1

  store 65535, @y_1

  jump %while_entry_22

%while_entry_22:
  %431 = load @i_1
  %432 = lt %431, 16
  br %432, %while_body_22, %while_end_22

%while_body_22:
  @result_45 = alloc i32
  store 0,@result_45
  %433 = load @x_1
  %434 = mod %433, 2
  %435 = ne 0, %434
  br %435, %then_45, %if_end_45

%then_45:
  %436 = load @y_1
  %437 = mod %436, 2
  %438 = ne 0, %437
 store %438,@result_45
  jump %if_end_45

%if_end_45:
  %439= load @result_45
  br %439, %then_44, %if_end_44

%then_44:
  %440 = load @ans_1
  %441 = load @i_1
  %442 = getelemptr @SHIFT_TABLE, %441
  %443 = load %442

  %444 = mul 1, %443
  %445 = add %440, %444
  store %445, @ans_1

  jump %if_end_44

%if_end_44:
  %446 = load @x_1
  %447 = div %446, 2
  store %447, @x_1

  %448 = load @y_1
  %449 = div %448, 2
  store %449, @y_1

  %450 = load @i_1
  %451 = add %450, 1
  store %451, @i_1

  jump %while_entry_22

%while_end_22:
  jump %if_end_43

%if_end_43:
  %452 = load @ans_1
  store %452, @c_60

  %453 = load @sum_60
  store %453, @al_60

  jump %while_entry_19

%while_end_19:
  %454 = load @al_60
  store %454, @ans_1

  %455 = load @ans_1
  store %455, @ml_43

  %456 = load @mr_43
  store %456, @x_1

  store 1, @y_1

  %457 = load @y_1
  %458 = ge %457, 15
  br %458, %then_46, %else_46

%then_46:
  %459 = load @x_1
  %460 = lt %459, 0
  br %460, %then_47, %else_47

%then_47:
  store 65535, @ans_1

  jump %if_end_47

%else_47:
  store 0, @ans_1

  jump %if_end_47

%if_end_47:
  jump %if_end_46

%else_46:
  %461 = load @y_1
  %462 = gt %461, 0
  br %462, %then_48, %else_48

%then_48:
  %463 = load @x_1
  %464 = gt %463, 32767
  br %464, %then_49, %else_49

%then_49:
  %465 = load @x_1
  %466 = load @y_1
  %467 = getelemptr @SHIFT_TABLE, %466
  %468 = load %467

  %469 = div %465, %468
  store %469, @x_1

  %470 = load @x_1
  %471 = add %470, 65536
  %472 = load @y_1
  %473 = sub 15, %472
  %474 = add %473, 1
  %475 = getelemptr @SHIFT_TABLE, %474
  %476 = load %475

  %477 = sub %471, %476
  store %477, @ans_1

  jump %if_end_49

%else_49:
  %478 = load @x_1
  %479 = load @y_1
  %480 = getelemptr @SHIFT_TABLE, %479
  %481 = load %480

  %482 = div %478, %481
  store %482, @ans_1

  jump %if_end_49

%if_end_49:
  jump %if_end_48

%else_48:
  %483 = load @x_1
  store %483, @ans_1

  jump %if_end_48

%if_end_48:
  jump %if_end_46

%if_end_46:
  %484 = load @ans_1
  store %484, @mr_43

  jump %while_entry_13

%while_end_13:
  %485 = load @mres_43
  store %485, @ans_1

  %486 = load @ans_1
  store %486, @pl_2

  %487 = load @pr_2
  store %487, @x_1

  store 1, @y_1

  %488 = load @y_1
  %489 = ge %488, 15
  br %489, %then_50, %else_50

%then_50:
  %490 = load @x_1
  %491 = lt %490, 0
  br %491, %then_51, %else_51

%then_51:
  store 65535, @ans_1

  jump %if_end_51

%else_51:
  store 0, @ans_1

  jump %if_end_51

%if_end_51:
  jump %if_end_50

%else_50:
  %492 = load @y_1
  %493 = gt %492, 0
  br %493, %then_52, %else_52

%then_52:
  %494 = load @x_1
  %495 = gt %494, 32767
  br %495, %then_53, %else_53

%then_53:
  %496 = load @x_1
  %497 = load @y_1
  %498 = getelemptr @SHIFT_TABLE, %497
  %499 = load %498

  %500 = div %496, %499
  store %500, @x_1

  %501 = load @x_1
  %502 = add %501, 65536
  %503 = load @y_1
  %504 = sub 15, %503
  %505 = add %504, 1
  %506 = getelemptr @SHIFT_TABLE, %505
  %507 = load %506

  %508 = sub %502, %507
  store %508, @ans_1

  jump %if_end_53

%else_53:
  %509 = load @x_1
  %510 = load @y_1
  %511 = getelemptr @SHIFT_TABLE, %510
  %512 = load %511

  %513 = div %509, %512
  store %513, @ans_1

  jump %if_end_53

%if_end_53:
  jump %if_end_52

%else_52:
  %514 = load @x_1
  store %514, @ans_1

  jump %if_end_52

%if_end_52:
  jump %if_end_50

%if_end_50:
  %515 = load @ans_1
  store %515, @pr_2

  jump %while_entry_1

%while_end_1:
  %516 = load @pres_2
  store %516, @ans_1

  %517 = load @ans_1
  call @putint(%517)
  call @putch(10)
  @pl_86= alloc i32
  store 2, @pl_86

  @pr_86= alloc i32
  store 1, @pr_86

  @pres_86= alloc i32
  store 1, @pres_86

  jump %while_entry_23

%while_entry_23:
  %518 = load @pr_86
  %519 = gt %518, 0
  br %519, %while_body_23, %while_end_23

%while_body_23:
  store 0, @ans_1

  store 0, @i_1

  %520 = load @pr_86
  store %520, @x_1

  store 1, @y_1

  jump %while_entry_24

%while_entry_24:
  %521 = load @i_1
  %522 = lt %521, 16
  br %522, %while_body_24, %while_end_24

%while_body_24:
  @result_55 = alloc i32
  store 0,@result_55
  %523 = load @x_1
  %524 = mod %523, 2
  %525 = ne 0, %524
  br %525, %then_55, %if_end_55

%then_55:
  %526 = load @y_1
  %527 = mod %526, 2
  %528 = ne 0, %527
 store %528,@result_55
  jump %if_end_55

%if_end_55:
  %529= load @result_55
  br %529, %then_54, %if_end_54

%then_54:
  %530 = load @ans_1
  %531 = load @i_1
  %532 = getelemptr @SHIFT_TABLE, %531
  %533 = load %532

  %534 = mul 1, %533
  %535 = add %530, %534
  store %535, @ans_1

  jump %if_end_54

%if_end_54:
  %536 = load @x_1
  %537 = div %536, 2
  store %537, @x_1

  %538 = load @y_1
  %539 = div %538, 2
  store %539, @y_1

  %540 = load @i_1
  %541 = add %540, 1
  store %541, @i_1

  jump %while_entry_24

%while_end_24:
  %542 = load @ans_1
  br %542, %then_56, %if_end_56

%then_56:
  @ml_91= alloc i32
  %543 = load @pres_86
  store %543, @ml_91

  @mr_91= alloc i32
  %544 = load @pl_86
  store %544, @mr_91

  @mres_91= alloc i32
  store 0, @mres_91

  jump %while_entry_25

%while_entry_25:
  %545 = load @mr_91
  br %545, %while_body_25, %while_end_25

%while_body_25:
  store 0, @ans_1

  store 0, @i_1

  %546 = load @mr_91
  store %546, @x_1

  store 1, @y_1

  jump %while_entry_26

%while_entry_26:
  %547 = load @i_1
  %548 = lt %547, 16
  br %548, %while_body_26, %while_end_26

%while_body_26:
  @result_58 = alloc i32
  store 0,@result_58
  %549 = load @x_1
  %550 = mod %549, 2
  %551 = ne 0, %550
  br %551, %then_58, %if_end_58

%then_58:
  %552 = load @y_1
  %553 = mod %552, 2
  %554 = ne 0, %553
 store %554,@result_58
  jump %if_end_58

%if_end_58:
  %555= load @result_58
  br %555, %then_57, %if_end_57

%then_57:
  %556 = load @ans_1
  %557 = load @i_1
  %558 = getelemptr @SHIFT_TABLE, %557
  %559 = load %558

  %560 = mul 1, %559
  %561 = add %556, %560
  store %561, @ans_1

  jump %if_end_57

%if_end_57:
  %562 = load @x_1
  %563 = div %562, 2
  store %563, @x_1

  %564 = load @y_1
  %565 = div %564, 2
  store %565, @y_1

  %566 = load @i_1
  %567 = add %566, 1
  store %567, @i_1

  jump %while_entry_26

%while_end_26:
  %568 = load @ans_1
  br %568, %then_59, %if_end_59

%then_59:
  @al_96= alloc i32
  %569 = load @mres_91
  store %569, @al_96

  @c_96= alloc i32
  %570 = load @ml_91
  store %570, @c_96

  @sum_96= alloc i32

  jump %while_entry_27

%while_entry_27:
  %571 = load @c_96
  br %571, %while_body_27, %while_end_27

%while_body_27:
  store 0, @ans_1

  store 0, @i_1

  %572 = load @al_96
  store %572, @x_1

  %573 = load @c_96
  store %573, @y_1

  jump %while_entry_28

%while_entry_28:
  %574 = load @i_1
  %575 = lt %574, 16
  br %575, %while_body_28, %while_end_28

%while_body_28:
  %576 = load @x_1
  %577 = mod %576, 2
  br %577, %then_60, %else_60

%then_60:
  %578 = load @y_1
  %579 = mod %578, 2
  %580 = eq %579, 0
  br %580, %then_61, %if_end_61

%then_61:
  %581 = load @ans_1
  %582 = load @i_1
  %583 = getelemptr @SHIFT_TABLE, %582
  %584 = load %583

  %585 = mul 1, %584
  %586 = add %581, %585
  store %586, @ans_1

  jump %if_end_61

%if_end_61:
  jump %if_end_60

%else_60:
  %587 = load @y_1
  %588 = mod %587, 2
  br %588, %then_62, %if_end_62

%then_62:
  %589 = load @ans_1
  %590 = load @i_1
  %591 = getelemptr @SHIFT_TABLE, %590
  %592 = load %591

  %593 = mul 1, %592
  %594 = add %589, %593
  store %594, @ans_1

  jump %if_end_62

%if_end_62:
  jump %if_end_60

%if_end_60:
  %595 = load @x_1
  %596 = div %595, 2
  store %596, @x_1

  %597 = load @y_1
  %598 = div %597, 2
  store %598, @y_1

  %599 = load @i_1
  %600 = add %599, 1
  store %600, @i_1

  jump %while_entry_28

%while_end_28:
  %601 = load @ans_1
  store %601, @sum_96

  store 0, @ans_1

  store 0, @i_1

  %602 = load @al_96
  store %602, @x_1

  %603 = load @c_96
  store %603, @y_1

  jump %while_entry_29

%while_entry_29:
  %604 = load @i_1
  %605 = lt %604, 16
  br %605, %while_body_29, %while_end_29

%while_body_29:
  @result_64 = alloc i32
  store 0,@result_64
  %606 = load @x_1
  %607 = mod %606, 2
  %608 = ne 0, %607
  br %608, %then_64, %if_end_64

%then_64:
  %609 = load @y_1
  %610 = mod %609, 2
  %611 = ne 0, %610
 store %611,@result_64
  jump %if_end_64

%if_end_64:
  %612= load @result_64
  br %612, %then_63, %if_end_63

%then_63:
  %613 = load @ans_1
  %614 = load @i_1
  %615 = getelemptr @SHIFT_TABLE, %614
  %616 = load %615

  %617 = mul 1, %616
  %618 = add %613, %617
  store %618, @ans_1

  jump %if_end_63

%if_end_63:
  %619 = load @x_1
  %620 = div %619, 2
  store %620, @x_1

  %621 = load @y_1
  %622 = div %621, 2
  store %622, @y_1

  %623 = load @i_1
  %624 = add %623, 1
  store %624, @i_1

  jump %while_entry_29

%while_end_29:
  %625 = load @ans_1
  store %625, @c_96

  %626 = gt 1, 15
  br %626, %then_65, %else_65

%then_65:
  store 0, @ans_1

  jump %if_end_65

%else_65:
  store 0, @ans_1

  store 0, @i_1

  %627 = load @c_96
  %628 = getelemptr @SHIFT_TABLE, 1
  %629 = load %628

  %630 = mul %627, %629
  store %630, @x_1

  store 65535, @y_1

  jump %while_entry_30

%while_entry_30:
  %631 = load @i_1
  %632 = lt %631, 16
  br %632, %while_body_30, %while_end_30

%while_body_30:
  @result_67 = alloc i32
  store 0,@result_67
  %633 = load @x_1
  %634 = mod %633, 2
  %635 = ne 0, %634
  br %635, %then_67, %if_end_67

%then_67:
  %636 = load @y_1
  %637 = mod %636, 2
  %638 = ne 0, %637
 store %638,@result_67
  jump %if_end_67

%if_end_67:
  %639= load @result_67
  br %639, %then_66, %if_end_66

%then_66:
  %640 = load @ans_1
  %641 = load @i_1
  %642 = getelemptr @SHIFT_TABLE, %641
  %643 = load %642

  %644 = mul 1, %643
  %645 = add %640, %644
  store %645, @ans_1

  jump %if_end_66

%if_end_66:
  %646 = load @x_1
  %647 = div %646, 2
  store %647, @x_1

  %648 = load @y_1
  %649 = div %648, 2
  store %649, @y_1

  %650 = load @i_1
  %651 = add %650, 1
  store %651, @i_1

  jump %while_entry_30

%while_end_30:
  jump %if_end_65

%if_end_65:
  %652 = load @ans_1
  store %652, @c_96

  %653 = load @sum_96
  store %653, @al_96

  jump %while_entry_27

%while_end_27:
  %654 = load @al_96
  store %654, @ans_1

  %655 = load @ans_1
  store %655, @mres_91

  jump %if_end_59

%if_end_59:
  @al_108= alloc i32
  %656 = load @ml_91
  store %656, @al_108

  @c_108= alloc i32
  %657 = load @ml_91
  store %657, @c_108

  @sum_108= alloc i32

  jump %while_entry_31

%while_entry_31:
  %658 = load @c_108
  br %658, %while_body_31, %while_end_31

%while_body_31:
  store 0, @ans_1

  store 0, @i_1

  %659 = load @al_108
  store %659, @x_1

  %660 = load @c_108
  store %660, @y_1

  jump %while_entry_32

%while_entry_32:
  %661 = load @i_1
  %662 = lt %661, 16
  br %662, %while_body_32, %while_end_32

%while_body_32:
  %663 = load @x_1
  %664 = mod %663, 2
  br %664, %then_68, %else_68

%then_68:
  %665 = load @y_1
  %666 = mod %665, 2
  %667 = eq %666, 0
  br %667, %then_69, %if_end_69

%then_69:
  %668 = load @ans_1
  %669 = load @i_1
  %670 = getelemptr @SHIFT_TABLE, %669
  %671 = load %670

  %672 = mul 1, %671
  %673 = add %668, %672
  store %673, @ans_1

  jump %if_end_69

%if_end_69:
  jump %if_end_68

%else_68:
  %674 = load @y_1
  %675 = mod %674, 2
  br %675, %then_70, %if_end_70

%then_70:
  %676 = load @ans_1
  %677 = load @i_1
  %678 = getelemptr @SHIFT_TABLE, %677
  %679 = load %678

  %680 = mul 1, %679
  %681 = add %676, %680
  store %681, @ans_1

  jump %if_end_70

%if_end_70:
  jump %if_end_68

%if_end_68:
  %682 = load @x_1
  %683 = div %682, 2
  store %683, @x_1

  %684 = load @y_1
  %685 = div %684, 2
  store %685, @y_1

  %686 = load @i_1
  %687 = add %686, 1
  store %687, @i_1

  jump %while_entry_32

%while_end_32:
  %688 = load @ans_1
  store %688, @sum_108

  store 0, @ans_1

  store 0, @i_1

  %689 = load @al_108
  store %689, @x_1

  %690 = load @c_108
  store %690, @y_1

  jump %while_entry_33

%while_entry_33:
  %691 = load @i_1
  %692 = lt %691, 16
  br %692, %while_body_33, %while_end_33

%while_body_33:
  @result_72 = alloc i32
  store 0,@result_72
  %693 = load @x_1
  %694 = mod %693, 2
  %695 = ne 0, %694
  br %695, %then_72, %if_end_72

%then_72:
  %696 = load @y_1
  %697 = mod %696, 2
  %698 = ne 0, %697
 store %698,@result_72
  jump %if_end_72

%if_end_72:
  %699= load @result_72
  br %699, %then_71, %if_end_71

%then_71:
  %700 = load @ans_1
  %701 = load @i_1
  %702 = getelemptr @SHIFT_TABLE, %701
  %703 = load %702

  %704 = mul 1, %703
  %705 = add %700, %704
  store %705, @ans_1

  jump %if_end_71

%if_end_71:
  %706 = load @x_1
  %707 = div %706, 2
  store %707, @x_1

  %708 = load @y_1
  %709 = div %708, 2
  store %709, @y_1

  %710 = load @i_1
  %711 = add %710, 1
  store %711, @i_1

  jump %while_entry_33

%while_end_33:
  %712 = load @ans_1
  store %712, @c_108

  %713 = gt 1, 15
  br %713, %then_73, %else_73

%then_73:
  store 0, @ans_1

  jump %if_end_73

%else_73:
  store 0, @ans_1

  store 0, @i_1

  %714 = load @c_108
  %715 = getelemptr @SHIFT_TABLE, 1
  %716 = load %715

  %717 = mul %714, %716
  store %717, @x_1

  store 65535, @y_1

  jump %while_entry_34

%while_entry_34:
  %718 = load @i_1
  %719 = lt %718, 16
  br %719, %while_body_34, %while_end_34

%while_body_34:
  @result_75 = alloc i32
  store 0,@result_75
  %720 = load @x_1
  %721 = mod %720, 2
  %722 = ne 0, %721
  br %722, %then_75, %if_end_75

%then_75:
  %723 = load @y_1
  %724 = mod %723, 2
  %725 = ne 0, %724
 store %725,@result_75
  jump %if_end_75

%if_end_75:
  %726= load @result_75
  br %726, %then_74, %if_end_74

%then_74:
  %727 = load @ans_1
  %728 = load @i_1
  %729 = getelemptr @SHIFT_TABLE, %728
  %730 = load %729

  %731 = mul 1, %730
  %732 = add %727, %731
  store %732, @ans_1

  jump %if_end_74

%if_end_74:
  %733 = load @x_1
  %734 = div %733, 2
  store %734, @x_1

  %735 = load @y_1
  %736 = div %735, 2
  store %736, @y_1

  %737 = load @i_1
  %738 = add %737, 1
  store %738, @i_1

  jump %while_entry_34

%while_end_34:
  jump %if_end_73

%if_end_73:
  %739 = load @ans_1
  store %739, @c_108

  %740 = load @sum_108
  store %740, @al_108

  jump %while_entry_31

%while_end_31:
  %741 = load @al_108
  store %741, @ans_1

  %742 = load @ans_1
  store %742, @ml_91

  %743 = load @mr_91
  store %743, @x_1

  store 1, @y_1

  %744 = load @y_1
  %745 = ge %744, 15
  br %745, %then_76, %else_76

%then_76:
  %746 = load @x_1
  %747 = lt %746, 0
  br %747, %then_77, %else_77

%then_77:
  store 65535, @ans_1

  jump %if_end_77

%else_77:
  store 0, @ans_1

  jump %if_end_77

%if_end_77:
  jump %if_end_76

%else_76:
  %748 = load @y_1
  %749 = gt %748, 0
  br %749, %then_78, %else_78

%then_78:
  %750 = load @x_1
  %751 = gt %750, 32767
  br %751, %then_79, %else_79

%then_79:
  %752 = load @x_1
  %753 = load @y_1
  %754 = getelemptr @SHIFT_TABLE, %753
  %755 = load %754

  %756 = div %752, %755
  store %756, @x_1

  %757 = load @x_1
  %758 = add %757, 65536
  %759 = load @y_1
  %760 = sub 15, %759
  %761 = add %760, 1
  %762 = getelemptr @SHIFT_TABLE, %761
  %763 = load %762

  %764 = sub %758, %763
  store %764, @ans_1

  jump %if_end_79

%else_79:
  %765 = load @x_1
  %766 = load @y_1
  %767 = getelemptr @SHIFT_TABLE, %766
  %768 = load %767

  %769 = div %765, %768
  store %769, @ans_1

  jump %if_end_79

%if_end_79:
  jump %if_end_78

%else_78:
  %770 = load @x_1
  store %770, @ans_1

  jump %if_end_78

%if_end_78:
  jump %if_end_76

%if_end_76:
  %771 = load @ans_1
  store %771, @mr_91

  jump %while_entry_25

%while_end_25:
  %772 = load @mres_91
  store %772, @ans_1

  %773 = load @ans_1
  store %773, @pres_86

  jump %if_end_56

%if_end_56:
  @ml_127= alloc i32
  %774 = load @pl_86
  store %774, @ml_127

  @mr_127= alloc i32
  %775 = load @pl_86
  store %775, @mr_127

  @mres_127= alloc i32
  store 0, @mres_127

  jump %while_entry_35

%while_entry_35:
  %776 = load @mr_127
  br %776, %while_body_35, %while_end_35

%while_body_35:
  store 0, @ans_1

  store 0, @i_1

  %777 = load @mr_127
  store %777, @x_1

  store 1, @y_1

  jump %while_entry_36

%while_entry_36:
  %778 = load @i_1
  %779 = lt %778, 16
  br %779, %while_body_36, %while_end_36

%while_body_36:
  @result_81 = alloc i32
  store 0,@result_81
  %780 = load @x_1
  %781 = mod %780, 2
  %782 = ne 0, %781
  br %782, %then_81, %if_end_81

%then_81:
  %783 = load @y_1
  %784 = mod %783, 2
  %785 = ne 0, %784
 store %785,@result_81
  jump %if_end_81

%if_end_81:
  %786= load @result_81
  br %786, %then_80, %if_end_80

%then_80:
  %787 = load @ans_1
  %788 = load @i_1
  %789 = getelemptr @SHIFT_TABLE, %788
  %790 = load %789

  %791 = mul 1, %790
  %792 = add %787, %791
  store %792, @ans_1

  jump %if_end_80

%if_end_80:
  %793 = load @x_1
  %794 = div %793, 2
  store %794, @x_1

  %795 = load @y_1
  %796 = div %795, 2
  store %796, @y_1

  %797 = load @i_1
  %798 = add %797, 1
  store %798, @i_1

  jump %while_entry_36

%while_end_36:
  %799 = load @ans_1
  br %799, %then_82, %if_end_82

%then_82:
  @al_132= alloc i32
  %800 = load @mres_127
  store %800, @al_132

  @c_132= alloc i32
  %801 = load @ml_127
  store %801, @c_132

  @sum_132= alloc i32

  jump %while_entry_37

%while_entry_37:
  %802 = load @c_132
  br %802, %while_body_37, %while_end_37

%while_body_37:
  store 0, @ans_1

  store 0, @i_1

  %803 = load @al_132
  store %803, @x_1

  %804 = load @c_132
  store %804, @y_1

  jump %while_entry_38

%while_entry_38:
  %805 = load @i_1
  %806 = lt %805, 16
  br %806, %while_body_38, %while_end_38

%while_body_38:
  %807 = load @x_1
  %808 = mod %807, 2
  br %808, %then_83, %else_83

%then_83:
  %809 = load @y_1
  %810 = mod %809, 2
  %811 = eq %810, 0
  br %811, %then_84, %if_end_84

%then_84:
  %812 = load @ans_1
  %813 = load @i_1
  %814 = getelemptr @SHIFT_TABLE, %813
  %815 = load %814

  %816 = mul 1, %815
  %817 = add %812, %816
  store %817, @ans_1

  jump %if_end_84

%if_end_84:
  jump %if_end_83

%else_83:
  %818 = load @y_1
  %819 = mod %818, 2
  br %819, %then_85, %if_end_85

%then_85:
  %820 = load @ans_1
  %821 = load @i_1
  %822 = getelemptr @SHIFT_TABLE, %821
  %823 = load %822

  %824 = mul 1, %823
  %825 = add %820, %824
  store %825, @ans_1

  jump %if_end_85

%if_end_85:
  jump %if_end_83

%if_end_83:
  %826 = load @x_1
  %827 = div %826, 2
  store %827, @x_1

  %828 = load @y_1
  %829 = div %828, 2
  store %829, @y_1

  %830 = load @i_1
  %831 = add %830, 1
  store %831, @i_1

  jump %while_entry_38

%while_end_38:
  %832 = load @ans_1
  store %832, @sum_132

  store 0, @ans_1

  store 0, @i_1

  %833 = load @al_132
  store %833, @x_1

  %834 = load @c_132
  store %834, @y_1

  jump %while_entry_39

%while_entry_39:
  %835 = load @i_1
  %836 = lt %835, 16
  br %836, %while_body_39, %while_end_39

%while_body_39:
  @result_87 = alloc i32
  store 0,@result_87
  %837 = load @x_1
  %838 = mod %837, 2
  %839 = ne 0, %838
  br %839, %then_87, %if_end_87

%then_87:
  %840 = load @y_1
  %841 = mod %840, 2
  %842 = ne 0, %841
 store %842,@result_87
  jump %if_end_87

%if_end_87:
  %843= load @result_87
  br %843, %then_86, %if_end_86

%then_86:
  %844 = load @ans_1
  %845 = load @i_1
  %846 = getelemptr @SHIFT_TABLE, %845
  %847 = load %846

  %848 = mul 1, %847
  %849 = add %844, %848
  store %849, @ans_1

  jump %if_end_86

%if_end_86:
  %850 = load @x_1
  %851 = div %850, 2
  store %851, @x_1

  %852 = load @y_1
  %853 = div %852, 2
  store %853, @y_1

  %854 = load @i_1
  %855 = add %854, 1
  store %855, @i_1

  jump %while_entry_39

%while_end_39:
  %856 = load @ans_1
  store %856, @c_132

  %857 = gt 1, 15
  br %857, %then_88, %else_88

%then_88:
  store 0, @ans_1

  jump %if_end_88

%else_88:
  store 0, @ans_1

  store 0, @i_1

  %858 = load @c_132
  %859 = getelemptr @SHIFT_TABLE, 1
  %860 = load %859

  %861 = mul %858, %860
  store %861, @x_1

  store 65535, @y_1

  jump %while_entry_40

%while_entry_40:
  %862 = load @i_1
  %863 = lt %862, 16
  br %863, %while_body_40, %while_end_40

%while_body_40:
  @result_90 = alloc i32
  store 0,@result_90
  %864 = load @x_1
  %865 = mod %864, 2
  %866 = ne 0, %865
  br %866, %then_90, %if_end_90

%then_90:
  %867 = load @y_1
  %868 = mod %867, 2
  %869 = ne 0, %868
 store %869,@result_90
  jump %if_end_90

%if_end_90:
  %870= load @result_90
  br %870, %then_89, %if_end_89

%then_89:
  %871 = load @ans_1
  %872 = load @i_1
  %873 = getelemptr @SHIFT_TABLE, %872
  %874 = load %873

  %875 = mul 1, %874
  %876 = add %871, %875
  store %876, @ans_1

  jump %if_end_89

%if_end_89:
  %877 = load @x_1
  %878 = div %877, 2
  store %878, @x_1

  %879 = load @y_1
  %880 = div %879, 2
  store %880, @y_1

  %881 = load @i_1
  %882 = add %881, 1
  store %882, @i_1

  jump %while_entry_40

%while_end_40:
  jump %if_end_88

%if_end_88:
  %883 = load @ans_1
  store %883, @c_132

  %884 = load @sum_132
  store %884, @al_132

  jump %while_entry_37

%while_end_37:
  %885 = load @al_132
  store %885, @ans_1

  %886 = load @ans_1
  store %886, @mres_127

  jump %if_end_82

%if_end_82:
  @al_144= alloc i32
  %887 = load @ml_127
  store %887, @al_144

  @c_144= alloc i32
  %888 = load @ml_127
  store %888, @c_144

  @sum_144= alloc i32

  jump %while_entry_41

%while_entry_41:
  %889 = load @c_144
  br %889, %while_body_41, %while_end_41

%while_body_41:
  store 0, @ans_1

  store 0, @i_1

  %890 = load @al_144
  store %890, @x_1

  %891 = load @c_144
  store %891, @y_1

  jump %while_entry_42

%while_entry_42:
  %892 = load @i_1
  %893 = lt %892, 16
  br %893, %while_body_42, %while_end_42

%while_body_42:
  %894 = load @x_1
  %895 = mod %894, 2
  br %895, %then_91, %else_91

%then_91:
  %896 = load @y_1
  %897 = mod %896, 2
  %898 = eq %897, 0
  br %898, %then_92, %if_end_92

%then_92:
  %899 = load @ans_1
  %900 = load @i_1
  %901 = getelemptr @SHIFT_TABLE, %900
  %902 = load %901

  %903 = mul 1, %902
  %904 = add %899, %903
  store %904, @ans_1

  jump %if_end_92

%if_end_92:
  jump %if_end_91

%else_91:
  %905 = load @y_1
  %906 = mod %905, 2
  br %906, %then_93, %if_end_93

%then_93:
  %907 = load @ans_1
  %908 = load @i_1
  %909 = getelemptr @SHIFT_TABLE, %908
  %910 = load %909

  %911 = mul 1, %910
  %912 = add %907, %911
  store %912, @ans_1

  jump %if_end_93

%if_end_93:
  jump %if_end_91

%if_end_91:
  %913 = load @x_1
  %914 = div %913, 2
  store %914, @x_1

  %915 = load @y_1
  %916 = div %915, 2
  store %916, @y_1

  %917 = load @i_1
  %918 = add %917, 1
  store %918, @i_1

  jump %while_entry_42

%while_end_42:
  %919 = load @ans_1
  store %919, @sum_144

  store 0, @ans_1

  store 0, @i_1

  %920 = load @al_144
  store %920, @x_1

  %921 = load @c_144
  store %921, @y_1

  jump %while_entry_43

%while_entry_43:
  %922 = load @i_1
  %923 = lt %922, 16
  br %923, %while_body_43, %while_end_43

%while_body_43:
  @result_95 = alloc i32
  store 0,@result_95
  %924 = load @x_1
  %925 = mod %924, 2
  %926 = ne 0, %925
  br %926, %then_95, %if_end_95

%then_95:
  %927 = load @y_1
  %928 = mod %927, 2
  %929 = ne 0, %928
 store %929,@result_95
  jump %if_end_95

%if_end_95:
  %930= load @result_95
  br %930, %then_94, %if_end_94

%then_94:
  %931 = load @ans_1
  %932 = load @i_1
  %933 = getelemptr @SHIFT_TABLE, %932
  %934 = load %933

  %935 = mul 1, %934
  %936 = add %931, %935
  store %936, @ans_1

  jump %if_end_94

%if_end_94:
  %937 = load @x_1
  %938 = div %937, 2
  store %938, @x_1

  %939 = load @y_1
  %940 = div %939, 2
  store %940, @y_1

  %941 = load @i_1
  %942 = add %941, 1
  store %942, @i_1

  jump %while_entry_43

%while_end_43:
  %943 = load @ans_1
  store %943, @c_144

  %944 = gt 1, 15
  br %944, %then_96, %else_96

%then_96:
  store 0, @ans_1

  jump %if_end_96

%else_96:
  store 0, @ans_1

  store 0, @i_1

  %945 = load @c_144
  %946 = getelemptr @SHIFT_TABLE, 1
  %947 = load %946

  %948 = mul %945, %947
  store %948, @x_1

  store 65535, @y_1

  jump %while_entry_44

%while_entry_44:
  %949 = load @i_1
  %950 = lt %949, 16
  br %950, %while_body_44, %while_end_44

%while_body_44:
  @result_98 = alloc i32
  store 0,@result_98
  %951 = load @x_1
  %952 = mod %951, 2
  %953 = ne 0, %952
  br %953, %then_98, %if_end_98

%then_98:
  %954 = load @y_1
  %955 = mod %954, 2
  %956 = ne 0, %955
 store %956,@result_98
  jump %if_end_98

%if_end_98:
  %957= load @result_98
  br %957, %then_97, %if_end_97

%then_97:
  %958 = load @ans_1
  %959 = load @i_1
  %960 = getelemptr @SHIFT_TABLE, %959
  %961 = load %960

  %962 = mul 1, %961
  %963 = add %958, %962
  store %963, @ans_1

  jump %if_end_97

%if_end_97:
  %964 = load @x_1
  %965 = div %964, 2
  store %965, @x_1

  %966 = load @y_1
  %967 = div %966, 2
  store %967, @y_1

  %968 = load @i_1
  %969 = add %968, 1
  store %969, @i_1

  jump %while_entry_44

%while_end_44:
  jump %if_end_96

%if_end_96:
  %970 = load @ans_1
  store %970, @c_144

  %971 = load @sum_144
  store %971, @al_144

  jump %while_entry_41

%while_end_41:
  %972 = load @al_144
  store %972, @ans_1

  %973 = load @ans_1
  store %973, @ml_127

  %974 = load @mr_127
  store %974, @x_1

  store 1, @y_1

  %975 = load @y_1
  %976 = ge %975, 15
  br %976, %then_99, %else_99

%then_99:
  %977 = load @x_1
  %978 = lt %977, 0
  br %978, %then_100, %else_100

%then_100:
  store 65535, @ans_1

  jump %if_end_100

%else_100:
  store 0, @ans_1

  jump %if_end_100

%if_end_100:
  jump %if_end_99

%else_99:
  %979 = load @y_1
  %980 = gt %979, 0
  br %980, %then_101, %else_101

%then_101:
  %981 = load @x_1
  %982 = gt %981, 32767
  br %982, %then_102, %else_102

%then_102:
  %983 = load @x_1
  %984 = load @y_1
  %985 = getelemptr @SHIFT_TABLE, %984
  %986 = load %985

  %987 = div %983, %986
  store %987, @x_1

  %988 = load @x_1
  %989 = add %988, 65536
  %990 = load @y_1
  %991 = sub 15, %990
  %992 = add %991, 1
  %993 = getelemptr @SHIFT_TABLE, %992
  %994 = load %993

  %995 = sub %989, %994
  store %995, @ans_1

  jump %if_end_102

%else_102:
  %996 = load @x_1
  %997 = load @y_1
  %998 = getelemptr @SHIFT_TABLE, %997
  %999 = load %998

  %1000 = div %996, %999
  store %1000, @ans_1

  jump %if_end_102

%if_end_102:
  jump %if_end_101

%else_101:
  %1001 = load @x_1
  store %1001, @ans_1

  jump %if_end_101

%if_end_101:
  jump %if_end_99

%if_end_99:
  %1002 = load @ans_1
  store %1002, @mr_127

  jump %while_entry_35

%while_end_35:
  %1003 = load @mres_127
  store %1003, @ans_1

  %1004 = load @ans_1
  store %1004, @pl_86

  %1005 = load @pr_86
  store %1005, @x_1

  store 1, @y_1

  %1006 = load @y_1
  %1007 = ge %1006, 15
  br %1007, %then_103, %else_103

%then_103:
  %1008 = load @x_1
  %1009 = lt %1008, 0
  br %1009, %then_104, %else_104

%then_104:
  store 65535, @ans_1

  jump %if_end_104

%else_104:
  store 0, @ans_1

  jump %if_end_104

%if_end_104:
  jump %if_end_103

%else_103:
  %1010 = load @y_1
  %1011 = gt %1010, 0
  br %1011, %then_105, %else_105

%then_105:
  %1012 = load @x_1
  %1013 = gt %1012, 32767
  br %1013, %then_106, %else_106

%then_106:
  %1014 = load @x_1
  %1015 = load @y_1
  %1016 = getelemptr @SHIFT_TABLE, %1015
  %1017 = load %1016

  %1018 = div %1014, %1017
  store %1018, @x_1

  %1019 = load @x_1
  %1020 = add %1019, 65536
  %1021 = load @y_1
  %1022 = sub 15, %1021
  %1023 = add %1022, 1
  %1024 = getelemptr @SHIFT_TABLE, %1023
  %1025 = load %1024

  %1026 = sub %1020, %1025
  store %1026, @ans_1

  jump %if_end_106

%else_106:
  %1027 = load @x_1
  %1028 = load @y_1
  %1029 = getelemptr @SHIFT_TABLE, %1028
  %1030 = load %1029

  %1031 = div %1027, %1030
  store %1031, @ans_1

  jump %if_end_106

%if_end_106:
  jump %if_end_105

%else_105:
  %1032 = load @x_1
  store %1032, @ans_1

  jump %if_end_105

%if_end_105:
  jump %if_end_103

%if_end_103:
  %1033 = load @ans_1
  store %1033, @pr_86

  jump %while_entry_23

%while_end_23:
  %1034 = load @pres_86
  store %1034, @ans_1

  %1035 = load @ans_1
  call @putint(%1035)
  call @putch(10)
  store 2, @cur_1

  jump %while_entry_45

%while_entry_45:
  %1036 = load @cur_1
  %1037 = lt %1036, 16
  br %1037, %while_body_45, %while_end_45

%while_body_45:
  @pl_171= alloc i32
  store 2, @pl_171

  @pr_171= alloc i32
  %1038 = load @cur_1
  store %1038, @pr_171

  @pres_171= alloc i32
  store 1, @pres_171

  jump %while_entry_46

%while_entry_46:
  %1039 = load @pr_171
  %1040 = gt %1039, 0
  br %1040, %while_body_46, %while_end_46

%while_body_46:
  store 0, @ans_1

  store 0, @i_1

  %1041 = load @pr_171
  store %1041, @x_1

  store 1, @y_1

  jump %while_entry_47

%while_entry_47:
  %1042 = load @i_1
  %1043 = lt %1042, 16
  br %1043, %while_body_47, %while_end_47

%while_body_47:
  @result_108 = alloc i32
  store 0,@result_108
  %1044 = load @x_1
  %1045 = mod %1044, 2
  %1046 = ne 0, %1045
  br %1046, %then_108, %if_end_108

%then_108:
  %1047 = load @y_1
  %1048 = mod %1047, 2
  %1049 = ne 0, %1048
 store %1049,@result_108
  jump %if_end_108

%if_end_108:
  %1050= load @result_108
  br %1050, %then_107, %if_end_107

%then_107:
  %1051 = load @ans_1
  %1052 = load @i_1
  %1053 = getelemptr @SHIFT_TABLE, %1052
  %1054 = load %1053

  %1055 = mul 1, %1054
  %1056 = add %1051, %1055
  store %1056, @ans_1

  jump %if_end_107

%if_end_107:
  %1057 = load @x_1
  %1058 = div %1057, 2
  store %1058, @x_1

  %1059 = load @y_1
  %1060 = div %1059, 2
  store %1060, @y_1

  %1061 = load @i_1
  %1062 = add %1061, 1
  store %1062, @i_1

  jump %while_entry_47

%while_end_47:
  %1063 = load @ans_1
  br %1063, %then_109, %if_end_109

%then_109:
  @ml_176= alloc i32
  %1064 = load @pres_171
  store %1064, @ml_176

  @mr_176= alloc i32
  %1065 = load @pl_171
  store %1065, @mr_176

  @mres_176= alloc i32
  store 0, @mres_176

  jump %while_entry_48

%while_entry_48:
  %1066 = load @mr_176
  br %1066, %while_body_48, %while_end_48

%while_body_48:
  store 0, @ans_1

  store 0, @i_1

  %1067 = load @mr_176
  store %1067, @x_1

  store 1, @y_1

  jump %while_entry_49

%while_entry_49:
  %1068 = load @i_1
  %1069 = lt %1068, 16
  br %1069, %while_body_49, %while_end_49

%while_body_49:
  @result_111 = alloc i32
  store 0,@result_111
  %1070 = load @x_1
  %1071 = mod %1070, 2
  %1072 = ne 0, %1071
  br %1072, %then_111, %if_end_111

%then_111:
  %1073 = load @y_1
  %1074 = mod %1073, 2
  %1075 = ne 0, %1074
 store %1075,@result_111
  jump %if_end_111

%if_end_111:
  %1076= load @result_111
  br %1076, %then_110, %if_end_110

%then_110:
  %1077 = load @ans_1
  %1078 = load @i_1
  %1079 = getelemptr @SHIFT_TABLE, %1078
  %1080 = load %1079

  %1081 = mul 1, %1080
  %1082 = add %1077, %1081
  store %1082, @ans_1

  jump %if_end_110

%if_end_110:
  %1083 = load @x_1
  %1084 = div %1083, 2
  store %1084, @x_1

  %1085 = load @y_1
  %1086 = div %1085, 2
  store %1086, @y_1

  %1087 = load @i_1
  %1088 = add %1087, 1
  store %1088, @i_1

  jump %while_entry_49

%while_end_49:
  %1089 = load @ans_1
  br %1089, %then_112, %if_end_112

%then_112:
  @al_181= alloc i32
  %1090 = load @mres_176
  store %1090, @al_181

  @c_181= alloc i32
  %1091 = load @ml_176
  store %1091, @c_181

  @sum_181= alloc i32

  jump %while_entry_50

%while_entry_50:
  %1092 = load @c_181
  br %1092, %while_body_50, %while_end_50

%while_body_50:
  store 0, @ans_1

  store 0, @i_1

  %1093 = load @al_181
  store %1093, @x_1

  %1094 = load @c_181
  store %1094, @y_1

  jump %while_entry_51

%while_entry_51:
  %1095 = load @i_1
  %1096 = lt %1095, 16
  br %1096, %while_body_51, %while_end_51

%while_body_51:
  %1097 = load @x_1
  %1098 = mod %1097, 2
  br %1098, %then_113, %else_113

%then_113:
  %1099 = load @y_1
  %1100 = mod %1099, 2
  %1101 = eq %1100, 0
  br %1101, %then_114, %if_end_114

%then_114:
  %1102 = load @ans_1
  %1103 = load @i_1
  %1104 = getelemptr @SHIFT_TABLE, %1103
  %1105 = load %1104

  %1106 = mul 1, %1105
  %1107 = add %1102, %1106
  store %1107, @ans_1

  jump %if_end_114

%if_end_114:
  jump %if_end_113

%else_113:
  %1108 = load @y_1
  %1109 = mod %1108, 2
  br %1109, %then_115, %if_end_115

%then_115:
  %1110 = load @ans_1
  %1111 = load @i_1
  %1112 = getelemptr @SHIFT_TABLE, %1111
  %1113 = load %1112

  %1114 = mul 1, %1113
  %1115 = add %1110, %1114
  store %1115, @ans_1

  jump %if_end_115

%if_end_115:
  jump %if_end_113

%if_end_113:
  %1116 = load @x_1
  %1117 = div %1116, 2
  store %1117, @x_1

  %1118 = load @y_1
  %1119 = div %1118, 2
  store %1119, @y_1

  %1120 = load @i_1
  %1121 = add %1120, 1
  store %1121, @i_1

  jump %while_entry_51

%while_end_51:
  %1122 = load @ans_1
  store %1122, @sum_181

  store 0, @ans_1

  store 0, @i_1

  %1123 = load @al_181
  store %1123, @x_1

  %1124 = load @c_181
  store %1124, @y_1

  jump %while_entry_52

%while_entry_52:
  %1125 = load @i_1
  %1126 = lt %1125, 16
  br %1126, %while_body_52, %while_end_52

%while_body_52:
  @result_117 = alloc i32
  store 0,@result_117
  %1127 = load @x_1
  %1128 = mod %1127, 2
  %1129 = ne 0, %1128
  br %1129, %then_117, %if_end_117

%then_117:
  %1130 = load @y_1
  %1131 = mod %1130, 2
  %1132 = ne 0, %1131
 store %1132,@result_117
  jump %if_end_117

%if_end_117:
  %1133= load @result_117
  br %1133, %then_116, %if_end_116

%then_116:
  %1134 = load @ans_1
  %1135 = load @i_1
  %1136 = getelemptr @SHIFT_TABLE, %1135
  %1137 = load %1136

  %1138 = mul 1, %1137
  %1139 = add %1134, %1138
  store %1139, @ans_1

  jump %if_end_116

%if_end_116:
  %1140 = load @x_1
  %1141 = div %1140, 2
  store %1141, @x_1

  %1142 = load @y_1
  %1143 = div %1142, 2
  store %1143, @y_1

  %1144 = load @i_1
  %1145 = add %1144, 1
  store %1145, @i_1

  jump %while_entry_52

%while_end_52:
  %1146 = load @ans_1
  store %1146, @c_181

  %1147 = gt 1, 15
  br %1147, %then_118, %else_118

%then_118:
  store 0, @ans_1

  jump %if_end_118

%else_118:
  store 0, @ans_1

  store 0, @i_1

  %1148 = load @c_181
  %1149 = getelemptr @SHIFT_TABLE, 1
  %1150 = load %1149

  %1151 = mul %1148, %1150
  store %1151, @x_1

  store 65535, @y_1

  jump %while_entry_53

%while_entry_53:
  %1152 = load @i_1
  %1153 = lt %1152, 16
  br %1153, %while_body_53, %while_end_53

%while_body_53:
  @result_120 = alloc i32
  store 0,@result_120
  %1154 = load @x_1
  %1155 = mod %1154, 2
  %1156 = ne 0, %1155
  br %1156, %then_120, %if_end_120

%then_120:
  %1157 = load @y_1
  %1158 = mod %1157, 2
  %1159 = ne 0, %1158
 store %1159,@result_120
  jump %if_end_120

%if_end_120:
  %1160= load @result_120
  br %1160, %then_119, %if_end_119

%then_119:
  %1161 = load @ans_1
  %1162 = load @i_1
  %1163 = getelemptr @SHIFT_TABLE, %1162
  %1164 = load %1163

  %1165 = mul 1, %1164
  %1166 = add %1161, %1165
  store %1166, @ans_1

  jump %if_end_119

%if_end_119:
  %1167 = load @x_1
  %1168 = div %1167, 2
  store %1168, @x_1

  %1169 = load @y_1
  %1170 = div %1169, 2
  store %1170, @y_1

  %1171 = load @i_1
  %1172 = add %1171, 1
  store %1172, @i_1

  jump %while_entry_53

%while_end_53:
  jump %if_end_118

%if_end_118:
  %1173 = load @ans_1
  store %1173, @c_181

  %1174 = load @sum_181
  store %1174, @al_181

  jump %while_entry_50

%while_end_50:
  %1175 = load @al_181
  store %1175, @ans_1

  %1176 = load @ans_1
  store %1176, @mres_176

  jump %if_end_112

%if_end_112:
  @al_193= alloc i32
  %1177 = load @ml_176
  store %1177, @al_193

  @c_193= alloc i32
  %1178 = load @ml_176
  store %1178, @c_193

  @sum_193= alloc i32

  jump %while_entry_54

%while_entry_54:
  %1179 = load @c_193
  br %1179, %while_body_54, %while_end_54

%while_body_54:
  store 0, @ans_1

  store 0, @i_1

  %1180 = load @al_193
  store %1180, @x_1

  %1181 = load @c_193
  store %1181, @y_1

  jump %while_entry_55

%while_entry_55:
  %1182 = load @i_1
  %1183 = lt %1182, 16
  br %1183, %while_body_55, %while_end_55

%while_body_55:
  %1184 = load @x_1
  %1185 = mod %1184, 2
  br %1185, %then_121, %else_121

%then_121:
  %1186 = load @y_1
  %1187 = mod %1186, 2
  %1188 = eq %1187, 0
  br %1188, %then_122, %if_end_122

%then_122:
  %1189 = load @ans_1
  %1190 = load @i_1
  %1191 = getelemptr @SHIFT_TABLE, %1190
  %1192 = load %1191

  %1193 = mul 1, %1192
  %1194 = add %1189, %1193
  store %1194, @ans_1

  jump %if_end_122

%if_end_122:
  jump %if_end_121

%else_121:
  %1195 = load @y_1
  %1196 = mod %1195, 2
  br %1196, %then_123, %if_end_123

%then_123:
  %1197 = load @ans_1
  %1198 = load @i_1
  %1199 = getelemptr @SHIFT_TABLE, %1198
  %1200 = load %1199

  %1201 = mul 1, %1200
  %1202 = add %1197, %1201
  store %1202, @ans_1

  jump %if_end_123

%if_end_123:
  jump %if_end_121

%if_end_121:
  %1203 = load @x_1
  %1204 = div %1203, 2
  store %1204, @x_1

  %1205 = load @y_1
  %1206 = div %1205, 2
  store %1206, @y_1

  %1207 = load @i_1
  %1208 = add %1207, 1
  store %1208, @i_1

  jump %while_entry_55

%while_end_55:
  %1209 = load @ans_1
  store %1209, @sum_193

  store 0, @ans_1

  store 0, @i_1

  %1210 = load @al_193
  store %1210, @x_1

  %1211 = load @c_193
  store %1211, @y_1

  jump %while_entry_56

%while_entry_56:
  %1212 = load @i_1
  %1213 = lt %1212, 16
  br %1213, %while_body_56, %while_end_56

%while_body_56:
  @result_125 = alloc i32
  store 0,@result_125
  %1214 = load @x_1
  %1215 = mod %1214, 2
  %1216 = ne 0, %1215
  br %1216, %then_125, %if_end_125

%then_125:
  %1217 = load @y_1
  %1218 = mod %1217, 2
  %1219 = ne 0, %1218
 store %1219,@result_125
  jump %if_end_125

%if_end_125:
  %1220= load @result_125
  br %1220, %then_124, %if_end_124

%then_124:
  %1221 = load @ans_1
  %1222 = load @i_1
  %1223 = getelemptr @SHIFT_TABLE, %1222
  %1224 = load %1223

  %1225 = mul 1, %1224
  %1226 = add %1221, %1225
  store %1226, @ans_1

  jump %if_end_124

%if_end_124:
  %1227 = load @x_1
  %1228 = div %1227, 2
  store %1228, @x_1

  %1229 = load @y_1
  %1230 = div %1229, 2
  store %1230, @y_1

  %1231 = load @i_1
  %1232 = add %1231, 1
  store %1232, @i_1

  jump %while_entry_56

%while_end_56:
  %1233 = load @ans_1
  store %1233, @c_193

  %1234 = gt 1, 15
  br %1234, %then_126, %else_126

%then_126:
  store 0, @ans_1

  jump %if_end_126

%else_126:
  store 0, @ans_1

  store 0, @i_1

  %1235 = load @c_193
  %1236 = getelemptr @SHIFT_TABLE, 1
  %1237 = load %1236

  %1238 = mul %1235, %1237
  store %1238, @x_1

  store 65535, @y_1

  jump %while_entry_57

%while_entry_57:
  %1239 = load @i_1
  %1240 = lt %1239, 16
  br %1240, %while_body_57, %while_end_57

%while_body_57:
  @result_128 = alloc i32
  store 0,@result_128
  %1241 = load @x_1
  %1242 = mod %1241, 2
  %1243 = ne 0, %1242
  br %1243, %then_128, %if_end_128

%then_128:
  %1244 = load @y_1
  %1245 = mod %1244, 2
  %1246 = ne 0, %1245
 store %1246,@result_128
  jump %if_end_128

%if_end_128:
  %1247= load @result_128
  br %1247, %then_127, %if_end_127

%then_127:
  %1248 = load @ans_1
  %1249 = load @i_1
  %1250 = getelemptr @SHIFT_TABLE, %1249
  %1251 = load %1250

  %1252 = mul 1, %1251
  %1253 = add %1248, %1252
  store %1253, @ans_1

  jump %if_end_127

%if_end_127:
  %1254 = load @x_1
  %1255 = div %1254, 2
  store %1255, @x_1

  %1256 = load @y_1
  %1257 = div %1256, 2
  store %1257, @y_1

  %1258 = load @i_1
  %1259 = add %1258, 1
  store %1259, @i_1

  jump %while_entry_57

%while_end_57:
  jump %if_end_126

%if_end_126:
  %1260 = load @ans_1
  store %1260, @c_193

  %1261 = load @sum_193
  store %1261, @al_193

  jump %while_entry_54

%while_end_54:
  %1262 = load @al_193
  store %1262, @ans_1

  %1263 = load @ans_1
  store %1263, @ml_176

  %1264 = load @mr_176
  store %1264, @x_1

  store 1, @y_1

  %1265 = load @y_1
  %1266 = ge %1265, 15
  br %1266, %then_129, %else_129

%then_129:
  %1267 = load @x_1
  %1268 = lt %1267, 0
  br %1268, %then_130, %else_130

%then_130:
  store 65535, @ans_1

  jump %if_end_130

%else_130:
  store 0, @ans_1

  jump %if_end_130

%if_end_130:
  jump %if_end_129

%else_129:
  %1269 = load @y_1
  %1270 = gt %1269, 0
  br %1270, %then_131, %else_131

%then_131:
  %1271 = load @x_1
  %1272 = gt %1271, 32767
  br %1272, %then_132, %else_132

%then_132:
  %1273 = load @x_1
  %1274 = load @y_1
  %1275 = getelemptr @SHIFT_TABLE, %1274
  %1276 = load %1275

  %1277 = div %1273, %1276
  store %1277, @x_1

  %1278 = load @x_1
  %1279 = add %1278, 65536
  %1280 = load @y_1
  %1281 = sub 15, %1280
  %1282 = add %1281, 1
  %1283 = getelemptr @SHIFT_TABLE, %1282
  %1284 = load %1283

  %1285 = sub %1279, %1284
  store %1285, @ans_1

  jump %if_end_132

%else_132:
  %1286 = load @x_1
  %1287 = load @y_1
  %1288 = getelemptr @SHIFT_TABLE, %1287
  %1289 = load %1288

  %1290 = div %1286, %1289
  store %1290, @ans_1

  jump %if_end_132

%if_end_132:
  jump %if_end_131

%else_131:
  %1291 = load @x_1
  store %1291, @ans_1

  jump %if_end_131

%if_end_131:
  jump %if_end_129

%if_end_129:
  %1292 = load @ans_1
  store %1292, @mr_176

  jump %while_entry_48

%while_end_48:
  %1293 = load @mres_176
  store %1293, @ans_1

  %1294 = load @ans_1
  store %1294, @pres_171

  jump %if_end_109

%if_end_109:
  @ml_212= alloc i32
  %1295 = load @pl_171
  store %1295, @ml_212

  @mr_212= alloc i32
  %1296 = load @pl_171
  store %1296, @mr_212

  @mres_212= alloc i32
  store 0, @mres_212

  jump %while_entry_58

%while_entry_58:
  %1297 = load @mr_212
  br %1297, %while_body_58, %while_end_58

%while_body_58:
  store 0, @ans_1

  store 0, @i_1

  %1298 = load @mr_212
  store %1298, @x_1

  store 1, @y_1

  jump %while_entry_59

%while_entry_59:
  %1299 = load @i_1
  %1300 = lt %1299, 16
  br %1300, %while_body_59, %while_end_59

%while_body_59:
  @result_134 = alloc i32
  store 0,@result_134
  %1301 = load @x_1
  %1302 = mod %1301, 2
  %1303 = ne 0, %1302
  br %1303, %then_134, %if_end_134

%then_134:
  %1304 = load @y_1
  %1305 = mod %1304, 2
  %1306 = ne 0, %1305
 store %1306,@result_134
  jump %if_end_134

%if_end_134:
  %1307= load @result_134
  br %1307, %then_133, %if_end_133

%then_133:
  %1308 = load @ans_1
  %1309 = load @i_1
  %1310 = getelemptr @SHIFT_TABLE, %1309
  %1311 = load %1310

  %1312 = mul 1, %1311
  %1313 = add %1308, %1312
  store %1313, @ans_1

  jump %if_end_133

%if_end_133:
  %1314 = load @x_1
  %1315 = div %1314, 2
  store %1315, @x_1

  %1316 = load @y_1
  %1317 = div %1316, 2
  store %1317, @y_1

  %1318 = load @i_1
  %1319 = add %1318, 1
  store %1319, @i_1

  jump %while_entry_59

%while_end_59:
  %1320 = load @ans_1
  br %1320, %then_135, %if_end_135

%then_135:
  @al_217= alloc i32
  %1321 = load @mres_212
  store %1321, @al_217

  @c_217= alloc i32
  %1322 = load @ml_212
  store %1322, @c_217

  @sum_217= alloc i32

  jump %while_entry_60

%while_entry_60:
  %1323 = load @c_217
  br %1323, %while_body_60, %while_end_60

%while_body_60:
  store 0, @ans_1

  store 0, @i_1

  %1324 = load @al_217
  store %1324, @x_1

  %1325 = load @c_217
  store %1325, @y_1

  jump %while_entry_61

%while_entry_61:
  %1326 = load @i_1
  %1327 = lt %1326, 16
  br %1327, %while_body_61, %while_end_61

%while_body_61:
  %1328 = load @x_1
  %1329 = mod %1328, 2
  br %1329, %then_136, %else_136

%then_136:
  %1330 = load @y_1
  %1331 = mod %1330, 2
  %1332 = eq %1331, 0
  br %1332, %then_137, %if_end_137

%then_137:
  %1333 = load @ans_1
  %1334 = load @i_1
  %1335 = getelemptr @SHIFT_TABLE, %1334
  %1336 = load %1335

  %1337 = mul 1, %1336
  %1338 = add %1333, %1337
  store %1338, @ans_1

  jump %if_end_137

%if_end_137:
  jump %if_end_136

%else_136:
  %1339 = load @y_1
  %1340 = mod %1339, 2
  br %1340, %then_138, %if_end_138

%then_138:
  %1341 = load @ans_1
  %1342 = load @i_1
  %1343 = getelemptr @SHIFT_TABLE, %1342
  %1344 = load %1343

  %1345 = mul 1, %1344
  %1346 = add %1341, %1345
  store %1346, @ans_1

  jump %if_end_138

%if_end_138:
  jump %if_end_136

%if_end_136:
  %1347 = load @x_1
  %1348 = div %1347, 2
  store %1348, @x_1

  %1349 = load @y_1
  %1350 = div %1349, 2
  store %1350, @y_1

  %1351 = load @i_1
  %1352 = add %1351, 1
  store %1352, @i_1

  jump %while_entry_61

%while_end_61:
  %1353 = load @ans_1
  store %1353, @sum_217

  store 0, @ans_1

  store 0, @i_1

  %1354 = load @al_217
  store %1354, @x_1

  %1355 = load @c_217
  store %1355, @y_1

  jump %while_entry_62

%while_entry_62:
  %1356 = load @i_1
  %1357 = lt %1356, 16
  br %1357, %while_body_62, %while_end_62

%while_body_62:
  @result_140 = alloc i32
  store 0,@result_140
  %1358 = load @x_1
  %1359 = mod %1358, 2
  %1360 = ne 0, %1359
  br %1360, %then_140, %if_end_140

%then_140:
  %1361 = load @y_1
  %1362 = mod %1361, 2
  %1363 = ne 0, %1362
 store %1363,@result_140
  jump %if_end_140

%if_end_140:
  %1364= load @result_140
  br %1364, %then_139, %if_end_139

%then_139:
  %1365 = load @ans_1
  %1366 = load @i_1
  %1367 = getelemptr @SHIFT_TABLE, %1366
  %1368 = load %1367

  %1369 = mul 1, %1368
  %1370 = add %1365, %1369
  store %1370, @ans_1

  jump %if_end_139

%if_end_139:
  %1371 = load @x_1
  %1372 = div %1371, 2
  store %1372, @x_1

  %1373 = load @y_1
  %1374 = div %1373, 2
  store %1374, @y_1

  %1375 = load @i_1
  %1376 = add %1375, 1
  store %1376, @i_1

  jump %while_entry_62

%while_end_62:
  %1377 = load @ans_1
  store %1377, @c_217

  %1378 = gt 1, 15
  br %1378, %then_141, %else_141

%then_141:
  store 0, @ans_1

  jump %if_end_141

%else_141:
  store 0, @ans_1

  store 0, @i_1

  %1379 = load @c_217
  %1380 = getelemptr @SHIFT_TABLE, 1
  %1381 = load %1380

  %1382 = mul %1379, %1381
  store %1382, @x_1

  store 65535, @y_1

  jump %while_entry_63

%while_entry_63:
  %1383 = load @i_1
  %1384 = lt %1383, 16
  br %1384, %while_body_63, %while_end_63

%while_body_63:
  @result_143 = alloc i32
  store 0,@result_143
  %1385 = load @x_1
  %1386 = mod %1385, 2
  %1387 = ne 0, %1386
  br %1387, %then_143, %if_end_143

%then_143:
  %1388 = load @y_1
  %1389 = mod %1388, 2
  %1390 = ne 0, %1389
 store %1390,@result_143
  jump %if_end_143

%if_end_143:
  %1391= load @result_143
  br %1391, %then_142, %if_end_142

%then_142:
  %1392 = load @ans_1
  %1393 = load @i_1
  %1394 = getelemptr @SHIFT_TABLE, %1393
  %1395 = load %1394

  %1396 = mul 1, %1395
  %1397 = add %1392, %1396
  store %1397, @ans_1

  jump %if_end_142

%if_end_142:
  %1398 = load @x_1
  %1399 = div %1398, 2
  store %1399, @x_1

  %1400 = load @y_1
  %1401 = div %1400, 2
  store %1401, @y_1

  %1402 = load @i_1
  %1403 = add %1402, 1
  store %1403, @i_1

  jump %while_entry_63

%while_end_63:
  jump %if_end_141

%if_end_141:
  %1404 = load @ans_1
  store %1404, @c_217

  %1405 = load @sum_217
  store %1405, @al_217

  jump %while_entry_60

%while_end_60:
  %1406 = load @al_217
  store %1406, @ans_1

  %1407 = load @ans_1
  store %1407, @mres_212

  jump %if_end_135

%if_end_135:
  @al_229= alloc i32
  %1408 = load @ml_212
  store %1408, @al_229

  @c_229= alloc i32
  %1409 = load @ml_212
  store %1409, @c_229

  @sum_229= alloc i32

  jump %while_entry_64

%while_entry_64:
  %1410 = load @c_229
  br %1410, %while_body_64, %while_end_64

%while_body_64:
  store 0, @ans_1

  store 0, @i_1

  %1411 = load @al_229
  store %1411, @x_1

  %1412 = load @c_229
  store %1412, @y_1

  jump %while_entry_65

%while_entry_65:
  %1413 = load @i_1
  %1414 = lt %1413, 16
  br %1414, %while_body_65, %while_end_65

%while_body_65:
  %1415 = load @x_1
  %1416 = mod %1415, 2
  br %1416, %then_144, %else_144

%then_144:
  %1417 = load @y_1
  %1418 = mod %1417, 2
  %1419 = eq %1418, 0
  br %1419, %then_145, %if_end_145

%then_145:
  %1420 = load @ans_1
  %1421 = load @i_1
  %1422 = getelemptr @SHIFT_TABLE, %1421
  %1423 = load %1422

  %1424 = mul 1, %1423
  %1425 = add %1420, %1424
  store %1425, @ans_1

  jump %if_end_145

%if_end_145:
  jump %if_end_144

%else_144:
  %1426 = load @y_1
  %1427 = mod %1426, 2
  br %1427, %then_146, %if_end_146

%then_146:
  %1428 = load @ans_1
  %1429 = load @i_1
  %1430 = getelemptr @SHIFT_TABLE, %1429
  %1431 = load %1430

  %1432 = mul 1, %1431
  %1433 = add %1428, %1432
  store %1433, @ans_1

  jump %if_end_146

%if_end_146:
  jump %if_end_144

%if_end_144:
  %1434 = load @x_1
  %1435 = div %1434, 2
  store %1435, @x_1

  %1436 = load @y_1
  %1437 = div %1436, 2
  store %1437, @y_1

  %1438 = load @i_1
  %1439 = add %1438, 1
  store %1439, @i_1

  jump %while_entry_65

%while_end_65:
  %1440 = load @ans_1
  store %1440, @sum_229

  store 0, @ans_1

  store 0, @i_1

  %1441 = load @al_229
  store %1441, @x_1

  %1442 = load @c_229
  store %1442, @y_1

  jump %while_entry_66

%while_entry_66:
  %1443 = load @i_1
  %1444 = lt %1443, 16
  br %1444, %while_body_66, %while_end_66

%while_body_66:
  @result_148 = alloc i32
  store 0,@result_148
  %1445 = load @x_1
  %1446 = mod %1445, 2
  %1447 = ne 0, %1446
  br %1447, %then_148, %if_end_148

%then_148:
  %1448 = load @y_1
  %1449 = mod %1448, 2
  %1450 = ne 0, %1449
 store %1450,@result_148
  jump %if_end_148

%if_end_148:
  %1451= load @result_148
  br %1451, %then_147, %if_end_147

%then_147:
  %1452 = load @ans_1
  %1453 = load @i_1
  %1454 = getelemptr @SHIFT_TABLE, %1453
  %1455 = load %1454

  %1456 = mul 1, %1455
  %1457 = add %1452, %1456
  store %1457, @ans_1

  jump %if_end_147

%if_end_147:
  %1458 = load @x_1
  %1459 = div %1458, 2
  store %1459, @x_1

  %1460 = load @y_1
  %1461 = div %1460, 2
  store %1461, @y_1

  %1462 = load @i_1
  %1463 = add %1462, 1
  store %1463, @i_1

  jump %while_entry_66

%while_end_66:
  %1464 = load @ans_1
  store %1464, @c_229

  %1465 = gt 1, 15
  br %1465, %then_149, %else_149

%then_149:
  store 0, @ans_1

  jump %if_end_149

%else_149:
  store 0, @ans_1

  store 0, @i_1

  %1466 = load @c_229
  %1467 = getelemptr @SHIFT_TABLE, 1
  %1468 = load %1467

  %1469 = mul %1466, %1468
  store %1469, @x_1

  store 65535, @y_1

  jump %while_entry_67

%while_entry_67:
  %1470 = load @i_1
  %1471 = lt %1470, 16
  br %1471, %while_body_67, %while_end_67

%while_body_67:
  @result_151 = alloc i32
  store 0,@result_151
  %1472 = load @x_1
  %1473 = mod %1472, 2
  %1474 = ne 0, %1473
  br %1474, %then_151, %if_end_151

%then_151:
  %1475 = load @y_1
  %1476 = mod %1475, 2
  %1477 = ne 0, %1476
 store %1477,@result_151
  jump %if_end_151

%if_end_151:
  %1478= load @result_151
  br %1478, %then_150, %if_end_150

%then_150:
  %1479 = load @ans_1
  %1480 = load @i_1
  %1481 = getelemptr @SHIFT_TABLE, %1480
  %1482 = load %1481

  %1483 = mul 1, %1482
  %1484 = add %1479, %1483
  store %1484, @ans_1

  jump %if_end_150

%if_end_150:
  %1485 = load @x_1
  %1486 = div %1485, 2
  store %1486, @x_1

  %1487 = load @y_1
  %1488 = div %1487, 2
  store %1488, @y_1

  %1489 = load @i_1
  %1490 = add %1489, 1
  store %1490, @i_1

  jump %while_entry_67

%while_end_67:
  jump %if_end_149

%if_end_149:
  %1491 = load @ans_1
  store %1491, @c_229

  %1492 = load @sum_229
  store %1492, @al_229

  jump %while_entry_64

%while_end_64:
  %1493 = load @al_229
  store %1493, @ans_1

  %1494 = load @ans_1
  store %1494, @ml_212

  %1495 = load @mr_212
  store %1495, @x_1

  store 1, @y_1

  %1496 = load @y_1
  %1497 = ge %1496, 15
  br %1497, %then_152, %else_152

%then_152:
  %1498 = load @x_1
  %1499 = lt %1498, 0
  br %1499, %then_153, %else_153

%then_153:
  store 65535, @ans_1

  jump %if_end_153

%else_153:
  store 0, @ans_1

  jump %if_end_153

%if_end_153:
  jump %if_end_152

%else_152:
  %1500 = load @y_1
  %1501 = gt %1500, 0
  br %1501, %then_154, %else_154

%then_154:
  %1502 = load @x_1
  %1503 = gt %1502, 32767
  br %1503, %then_155, %else_155

%then_155:
  %1504 = load @x_1
  %1505 = load @y_1
  %1506 = getelemptr @SHIFT_TABLE, %1505
  %1507 = load %1506

  %1508 = div %1504, %1507
  store %1508, @x_1

  %1509 = load @x_1
  %1510 = add %1509, 65536
  %1511 = load @y_1
  %1512 = sub 15, %1511
  %1513 = add %1512, 1
  %1514 = getelemptr @SHIFT_TABLE, %1513
  %1515 = load %1514

  %1516 = sub %1510, %1515
  store %1516, @ans_1

  jump %if_end_155

%else_155:
  %1517 = load @x_1
  %1518 = load @y_1
  %1519 = getelemptr @SHIFT_TABLE, %1518
  %1520 = load %1519

  %1521 = div %1517, %1520
  store %1521, @ans_1

  jump %if_end_155

%if_end_155:
  jump %if_end_154

%else_154:
  %1522 = load @x_1
  store %1522, @ans_1

  jump %if_end_154

%if_end_154:
  jump %if_end_152

%if_end_152:
  %1523 = load @ans_1
  store %1523, @mr_212

  jump %while_entry_58

%while_end_58:
  %1524 = load @mres_212
  store %1524, @ans_1

  %1525 = load @ans_1
  store %1525, @pl_171

  %1526 = load @pr_171
  store %1526, @x_1

  store 1, @y_1

  %1527 = load @y_1
  %1528 = ge %1527, 15
  br %1528, %then_156, %else_156

%then_156:
  %1529 = load @x_1
  %1530 = lt %1529, 0
  br %1530, %then_157, %else_157

%then_157:
  store 65535, @ans_1

  jump %if_end_157

%else_157:
  store 0, @ans_1

  jump %if_end_157

%if_end_157:
  jump %if_end_156

%else_156:
  %1531 = load @y_1
  %1532 = gt %1531, 0
  br %1532, %then_158, %else_158

%then_158:
  %1533 = load @x_1
  %1534 = gt %1533, 32767
  br %1534, %then_159, %else_159

%then_159:
  %1535 = load @x_1
  %1536 = load @y_1
  %1537 = getelemptr @SHIFT_TABLE, %1536
  %1538 = load %1537

  %1539 = div %1535, %1538
  store %1539, @x_1

  %1540 = load @x_1
  %1541 = add %1540, 65536
  %1542 = load @y_1
  %1543 = sub 15, %1542
  %1544 = add %1543, 1
  %1545 = getelemptr @SHIFT_TABLE, %1544
  %1546 = load %1545

  %1547 = sub %1541, %1546
  store %1547, @ans_1

  jump %if_end_159

%else_159:
  %1548 = load @x_1
  %1549 = load @y_1
  %1550 = getelemptr @SHIFT_TABLE, %1549
  %1551 = load %1550

  %1552 = div %1548, %1551
  store %1552, @ans_1

  jump %if_end_159

%if_end_159:
  jump %if_end_158

%else_158:
  %1553 = load @x_1
  store %1553, @ans_1

  jump %if_end_158

%if_end_158:
  jump %if_end_156

%if_end_156:
  %1554 = load @ans_1
  store %1554, @pr_171

  jump %while_entry_46

%while_end_46:
  %1555 = load @pres_171
  store %1555, @ans_1

  %1556 = load @ans_1
  call @putint(%1556)
  call @putch(10)
  %1557 = load @cur_1
  %1558 = add %1557, 1
  store %1558, @cur_1

  jump %while_entry_45

%while_end_45:
  store 0, @cur_1

  jump %while_entry_68

%while_entry_68:
  %1559 = load @cur_1
  %1560 = lt %1559, 16
  br %1560, %while_body_68, %while_end_68

%while_body_68:
  @pl_256= alloc i32
  store 2, @pl_256

  @pr_256= alloc i32
  %1561 = load @cur_1
  store %1561, @pr_256

  @pres_256= alloc i32
  store 1, @pres_256

  jump %while_entry_69

%while_entry_69:
  %1562 = load @pr_256
  %1563 = gt %1562, 0
  br %1563, %while_body_69, %while_end_69

%while_body_69:
  store 0, @ans_1

  store 0, @i_1

  %1564 = load @pr_256
  store %1564, @x_1

  store 1, @y_1

  jump %while_entry_70

%while_entry_70:
  %1565 = load @i_1
  %1566 = lt %1565, 16
  br %1566, %while_body_70, %while_end_70

%while_body_70:
  @result_161 = alloc i32
  store 0,@result_161
  %1567 = load @x_1
  %1568 = mod %1567, 2
  %1569 = ne 0, %1568
  br %1569, %then_161, %if_end_161

%then_161:
  %1570 = load @y_1
  %1571 = mod %1570, 2
  %1572 = ne 0, %1571
 store %1572,@result_161
  jump %if_end_161

%if_end_161:
  %1573= load @result_161
  br %1573, %then_160, %if_end_160

%then_160:
  %1574 = load @ans_1
  %1575 = load @i_1
  %1576 = getelemptr @SHIFT_TABLE, %1575
  %1577 = load %1576

  %1578 = mul 1, %1577
  %1579 = add %1574, %1578
  store %1579, @ans_1

  jump %if_end_160

%if_end_160:
  %1580 = load @x_1
  %1581 = div %1580, 2
  store %1581, @x_1

  %1582 = load @y_1
  %1583 = div %1582, 2
  store %1583, @y_1

  %1584 = load @i_1
  %1585 = add %1584, 1
  store %1585, @i_1

  jump %while_entry_70

%while_end_70:
  %1586 = load @ans_1
  br %1586, %then_162, %if_end_162

%then_162:
  @ml_261= alloc i32
  %1587 = load @pres_256
  store %1587, @ml_261

  @mr_261= alloc i32
  %1588 = load @pl_256
  store %1588, @mr_261

  @mres_261= alloc i32
  store 0, @mres_261

  jump %while_entry_71

%while_entry_71:
  %1589 = load @mr_261
  br %1589, %while_body_71, %while_end_71

%while_body_71:
  store 0, @ans_1

  store 0, @i_1

  %1590 = load @mr_261
  store %1590, @x_1

  store 1, @y_1

  jump %while_entry_72

%while_entry_72:
  %1591 = load @i_1
  %1592 = lt %1591, 16
  br %1592, %while_body_72, %while_end_72

%while_body_72:
  @result_164 = alloc i32
  store 0,@result_164
  %1593 = load @x_1
  %1594 = mod %1593, 2
  %1595 = ne 0, %1594
  br %1595, %then_164, %if_end_164

%then_164:
  %1596 = load @y_1
  %1597 = mod %1596, 2
  %1598 = ne 0, %1597
 store %1598,@result_164
  jump %if_end_164

%if_end_164:
  %1599= load @result_164
  br %1599, %then_163, %if_end_163

%then_163:
  %1600 = load @ans_1
  %1601 = load @i_1
  %1602 = getelemptr @SHIFT_TABLE, %1601
  %1603 = load %1602

  %1604 = mul 1, %1603
  %1605 = add %1600, %1604
  store %1605, @ans_1

  jump %if_end_163

%if_end_163:
  %1606 = load @x_1
  %1607 = div %1606, 2
  store %1607, @x_1

  %1608 = load @y_1
  %1609 = div %1608, 2
  store %1609, @y_1

  %1610 = load @i_1
  %1611 = add %1610, 1
  store %1611, @i_1

  jump %while_entry_72

%while_end_72:
  %1612 = load @ans_1
  br %1612, %then_165, %if_end_165

%then_165:
  @al_266= alloc i32
  %1613 = load @mres_261
  store %1613, @al_266

  @c_266= alloc i32
  %1614 = load @ml_261
  store %1614, @c_266

  @sum_266= alloc i32

  jump %while_entry_73

%while_entry_73:
  %1615 = load @c_266
  br %1615, %while_body_73, %while_end_73

%while_body_73:
  store 0, @ans_1

  store 0, @i_1

  %1616 = load @al_266
  store %1616, @x_1

  %1617 = load @c_266
  store %1617, @y_1

  jump %while_entry_74

%while_entry_74:
  %1618 = load @i_1
  %1619 = lt %1618, 16
  br %1619, %while_body_74, %while_end_74

%while_body_74:
  %1620 = load @x_1
  %1621 = mod %1620, 2
  br %1621, %then_166, %else_166

%then_166:
  %1622 = load @y_1
  %1623 = mod %1622, 2
  %1624 = eq %1623, 0
  br %1624, %then_167, %if_end_167

%then_167:
  %1625 = load @ans_1
  %1626 = load @i_1
  %1627 = getelemptr @SHIFT_TABLE, %1626
  %1628 = load %1627

  %1629 = mul 1, %1628
  %1630 = add %1625, %1629
  store %1630, @ans_1

  jump %if_end_167

%if_end_167:
  jump %if_end_166

%else_166:
  %1631 = load @y_1
  %1632 = mod %1631, 2
  br %1632, %then_168, %if_end_168

%then_168:
  %1633 = load @ans_1
  %1634 = load @i_1
  %1635 = getelemptr @SHIFT_TABLE, %1634
  %1636 = load %1635

  %1637 = mul 1, %1636
  %1638 = add %1633, %1637
  store %1638, @ans_1

  jump %if_end_168

%if_end_168:
  jump %if_end_166

%if_end_166:
  %1639 = load @x_1
  %1640 = div %1639, 2
  store %1640, @x_1

  %1641 = load @y_1
  %1642 = div %1641, 2
  store %1642, @y_1

  %1643 = load @i_1
  %1644 = add %1643, 1
  store %1644, @i_1

  jump %while_entry_74

%while_end_74:
  %1645 = load @ans_1
  store %1645, @sum_266

  store 0, @ans_1

  store 0, @i_1

  %1646 = load @al_266
  store %1646, @x_1

  %1647 = load @c_266
  store %1647, @y_1

  jump %while_entry_75

%while_entry_75:
  %1648 = load @i_1
  %1649 = lt %1648, 16
  br %1649, %while_body_75, %while_end_75

%while_body_75:
  @result_170 = alloc i32
  store 0,@result_170
  %1650 = load @x_1
  %1651 = mod %1650, 2
  %1652 = ne 0, %1651
  br %1652, %then_170, %if_end_170

%then_170:
  %1653 = load @y_1
  %1654 = mod %1653, 2
  %1655 = ne 0, %1654
 store %1655,@result_170
  jump %if_end_170

%if_end_170:
  %1656= load @result_170
  br %1656, %then_169, %if_end_169

%then_169:
  %1657 = load @ans_1
  %1658 = load @i_1
  %1659 = getelemptr @SHIFT_TABLE, %1658
  %1660 = load %1659

  %1661 = mul 1, %1660
  %1662 = add %1657, %1661
  store %1662, @ans_1

  jump %if_end_169

%if_end_169:
  %1663 = load @x_1
  %1664 = div %1663, 2
  store %1664, @x_1

  %1665 = load @y_1
  %1666 = div %1665, 2
  store %1666, @y_1

  %1667 = load @i_1
  %1668 = add %1667, 1
  store %1668, @i_1

  jump %while_entry_75

%while_end_75:
  %1669 = load @ans_1
  store %1669, @c_266

  %1670 = gt 1, 15
  br %1670, %then_171, %else_171

%then_171:
  store 0, @ans_1

  jump %if_end_171

%else_171:
  store 0, @ans_1

  store 0, @i_1

  %1671 = load @c_266
  %1672 = getelemptr @SHIFT_TABLE, 1
  %1673 = load %1672

  %1674 = mul %1671, %1673
  store %1674, @x_1

  store 65535, @y_1

  jump %while_entry_76

%while_entry_76:
  %1675 = load @i_1
  %1676 = lt %1675, 16
  br %1676, %while_body_76, %while_end_76

%while_body_76:
  @result_173 = alloc i32
  store 0,@result_173
  %1677 = load @x_1
  %1678 = mod %1677, 2
  %1679 = ne 0, %1678
  br %1679, %then_173, %if_end_173

%then_173:
  %1680 = load @y_1
  %1681 = mod %1680, 2
  %1682 = ne 0, %1681
 store %1682,@result_173
  jump %if_end_173

%if_end_173:
  %1683= load @result_173
  br %1683, %then_172, %if_end_172

%then_172:
  %1684 = load @ans_1
  %1685 = load @i_1
  %1686 = getelemptr @SHIFT_TABLE, %1685
  %1687 = load %1686

  %1688 = mul 1, %1687
  %1689 = add %1684, %1688
  store %1689, @ans_1

  jump %if_end_172

%if_end_172:
  %1690 = load @x_1
  %1691 = div %1690, 2
  store %1691, @x_1

  %1692 = load @y_1
  %1693 = div %1692, 2
  store %1693, @y_1

  %1694 = load @i_1
  %1695 = add %1694, 1
  store %1695, @i_1

  jump %while_entry_76

%while_end_76:
  jump %if_end_171

%if_end_171:
  %1696 = load @ans_1
  store %1696, @c_266

  %1697 = load @sum_266
  store %1697, @al_266

  jump %while_entry_73

%while_end_73:
  %1698 = load @al_266
  store %1698, @ans_1

  %1699 = load @ans_1
  store %1699, @mres_261

  jump %if_end_165

%if_end_165:
  @al_278= alloc i32
  %1700 = load @ml_261
  store %1700, @al_278

  @c_278= alloc i32
  %1701 = load @ml_261
  store %1701, @c_278

  @sum_278= alloc i32

  jump %while_entry_77

%while_entry_77:
  %1702 = load @c_278
  br %1702, %while_body_77, %while_end_77

%while_body_77:
  store 0, @ans_1

  store 0, @i_1

  %1703 = load @al_278
  store %1703, @x_1

  %1704 = load @c_278
  store %1704, @y_1

  jump %while_entry_78

%while_entry_78:
  %1705 = load @i_1
  %1706 = lt %1705, 16
  br %1706, %while_body_78, %while_end_78

%while_body_78:
  %1707 = load @x_1
  %1708 = mod %1707, 2
  br %1708, %then_174, %else_174

%then_174:
  %1709 = load @y_1
  %1710 = mod %1709, 2
  %1711 = eq %1710, 0
  br %1711, %then_175, %if_end_175

%then_175:
  %1712 = load @ans_1
  %1713 = load @i_1
  %1714 = getelemptr @SHIFT_TABLE, %1713
  %1715 = load %1714

  %1716 = mul 1, %1715
  %1717 = add %1712, %1716
  store %1717, @ans_1

  jump %if_end_175

%if_end_175:
  jump %if_end_174

%else_174:
  %1718 = load @y_1
  %1719 = mod %1718, 2
  br %1719, %then_176, %if_end_176

%then_176:
  %1720 = load @ans_1
  %1721 = load @i_1
  %1722 = getelemptr @SHIFT_TABLE, %1721
  %1723 = load %1722

  %1724 = mul 1, %1723
  %1725 = add %1720, %1724
  store %1725, @ans_1

  jump %if_end_176

%if_end_176:
  jump %if_end_174

%if_end_174:
  %1726 = load @x_1
  %1727 = div %1726, 2
  store %1727, @x_1

  %1728 = load @y_1
  %1729 = div %1728, 2
  store %1729, @y_1

  %1730 = load @i_1
  %1731 = add %1730, 1
  store %1731, @i_1

  jump %while_entry_78

%while_end_78:
  %1732 = load @ans_1
  store %1732, @sum_278

  store 0, @ans_1

  store 0, @i_1

  %1733 = load @al_278
  store %1733, @x_1

  %1734 = load @c_278
  store %1734, @y_1

  jump %while_entry_79

%while_entry_79:
  %1735 = load @i_1
  %1736 = lt %1735, 16
  br %1736, %while_body_79, %while_end_79

%while_body_79:
  @result_178 = alloc i32
  store 0,@result_178
  %1737 = load @x_1
  %1738 = mod %1737, 2
  %1739 = ne 0, %1738
  br %1739, %then_178, %if_end_178

%then_178:
  %1740 = load @y_1
  %1741 = mod %1740, 2
  %1742 = ne 0, %1741
 store %1742,@result_178
  jump %if_end_178

%if_end_178:
  %1743= load @result_178
  br %1743, %then_177, %if_end_177

%then_177:
  %1744 = load @ans_1
  %1745 = load @i_1
  %1746 = getelemptr @SHIFT_TABLE, %1745
  %1747 = load %1746

  %1748 = mul 1, %1747
  %1749 = add %1744, %1748
  store %1749, @ans_1

  jump %if_end_177

%if_end_177:
  %1750 = load @x_1
  %1751 = div %1750, 2
  store %1751, @x_1

  %1752 = load @y_1
  %1753 = div %1752, 2
  store %1753, @y_1

  %1754 = load @i_1
  %1755 = add %1754, 1
  store %1755, @i_1

  jump %while_entry_79

%while_end_79:
  %1756 = load @ans_1
  store %1756, @c_278

  %1757 = gt 1, 15
  br %1757, %then_179, %else_179

%then_179:
  store 0, @ans_1

  jump %if_end_179

%else_179:
  store 0, @ans_1

  store 0, @i_1

  %1758 = load @c_278
  %1759 = getelemptr @SHIFT_TABLE, 1
  %1760 = load %1759

  %1761 = mul %1758, %1760
  store %1761, @x_1

  store 65535, @y_1

  jump %while_entry_80

%while_entry_80:
  %1762 = load @i_1
  %1763 = lt %1762, 16
  br %1763, %while_body_80, %while_end_80

%while_body_80:
  @result_181 = alloc i32
  store 0,@result_181
  %1764 = load @x_1
  %1765 = mod %1764, 2
  %1766 = ne 0, %1765
  br %1766, %then_181, %if_end_181

%then_181:
  %1767 = load @y_1
  %1768 = mod %1767, 2
  %1769 = ne 0, %1768
 store %1769,@result_181
  jump %if_end_181

%if_end_181:
  %1770= load @result_181
  br %1770, %then_180, %if_end_180

%then_180:
  %1771 = load @ans_1
  %1772 = load @i_1
  %1773 = getelemptr @SHIFT_TABLE, %1772
  %1774 = load %1773

  %1775 = mul 1, %1774
  %1776 = add %1771, %1775
  store %1776, @ans_1

  jump %if_end_180

%if_end_180:
  %1777 = load @x_1
  %1778 = div %1777, 2
  store %1778, @x_1

  %1779 = load @y_1
  %1780 = div %1779, 2
  store %1780, @y_1

  %1781 = load @i_1
  %1782 = add %1781, 1
  store %1782, @i_1

  jump %while_entry_80

%while_end_80:
  jump %if_end_179

%if_end_179:
  %1783 = load @ans_1
  store %1783, @c_278

  %1784 = load @sum_278
  store %1784, @al_278

  jump %while_entry_77

%while_end_77:
  %1785 = load @al_278
  store %1785, @ans_1

  %1786 = load @ans_1
  store %1786, @ml_261

  %1787 = load @mr_261
  store %1787, @x_1

  store 1, @y_1

  %1788 = load @y_1
  %1789 = ge %1788, 15
  br %1789, %then_182, %else_182

%then_182:
  %1790 = load @x_1
  %1791 = lt %1790, 0
  br %1791, %then_183, %else_183

%then_183:
  store 65535, @ans_1

  jump %if_end_183

%else_183:
  store 0, @ans_1

  jump %if_end_183

%if_end_183:
  jump %if_end_182

%else_182:
  %1792 = load @y_1
  %1793 = gt %1792, 0
  br %1793, %then_184, %else_184

%then_184:
  %1794 = load @x_1
  %1795 = gt %1794, 32767
  br %1795, %then_185, %else_185

%then_185:
  %1796 = load @x_1
  %1797 = load @y_1
  %1798 = getelemptr @SHIFT_TABLE, %1797
  %1799 = load %1798

  %1800 = div %1796, %1799
  store %1800, @x_1

  %1801 = load @x_1
  %1802 = add %1801, 65536
  %1803 = load @y_1
  %1804 = sub 15, %1803
  %1805 = add %1804, 1
  %1806 = getelemptr @SHIFT_TABLE, %1805
  %1807 = load %1806

  %1808 = sub %1802, %1807
  store %1808, @ans_1

  jump %if_end_185

%else_185:
  %1809 = load @x_1
  %1810 = load @y_1
  %1811 = getelemptr @SHIFT_TABLE, %1810
  %1812 = load %1811

  %1813 = div %1809, %1812
  store %1813, @ans_1

  jump %if_end_185

%if_end_185:
  jump %if_end_184

%else_184:
  %1814 = load @x_1
  store %1814, @ans_1

  jump %if_end_184

%if_end_184:
  jump %if_end_182

%if_end_182:
  %1815 = load @ans_1
  store %1815, @mr_261

  jump %while_entry_71

%while_end_71:
  %1816 = load @mres_261
  store %1816, @ans_1

  %1817 = load @ans_1
  store %1817, @pres_256

  jump %if_end_162

%if_end_162:
  @ml_297= alloc i32
  %1818 = load @pl_256
  store %1818, @ml_297

  @mr_297= alloc i32
  %1819 = load @pl_256
  store %1819, @mr_297

  @mres_297= alloc i32
  store 0, @mres_297

  jump %while_entry_81

%while_entry_81:
  %1820 = load @mr_297
  br %1820, %while_body_81, %while_end_81

%while_body_81:
  store 0, @ans_1

  store 0, @i_1

  %1821 = load @mr_297
  store %1821, @x_1

  store 1, @y_1

  jump %while_entry_82

%while_entry_82:
  %1822 = load @i_1
  %1823 = lt %1822, 16
  br %1823, %while_body_82, %while_end_82

%while_body_82:
  @result_187 = alloc i32
  store 0,@result_187
  %1824 = load @x_1
  %1825 = mod %1824, 2
  %1826 = ne 0, %1825
  br %1826, %then_187, %if_end_187

%then_187:
  %1827 = load @y_1
  %1828 = mod %1827, 2
  %1829 = ne 0, %1828
 store %1829,@result_187
  jump %if_end_187

%if_end_187:
  %1830= load @result_187
  br %1830, %then_186, %if_end_186

%then_186:
  %1831 = load @ans_1
  %1832 = load @i_1
  %1833 = getelemptr @SHIFT_TABLE, %1832
  %1834 = load %1833

  %1835 = mul 1, %1834
  %1836 = add %1831, %1835
  store %1836, @ans_1

  jump %if_end_186

%if_end_186:
  %1837 = load @x_1
  %1838 = div %1837, 2
  store %1838, @x_1

  %1839 = load @y_1
  %1840 = div %1839, 2
  store %1840, @y_1

  %1841 = load @i_1
  %1842 = add %1841, 1
  store %1842, @i_1

  jump %while_entry_82

%while_end_82:
  %1843 = load @ans_1
  br %1843, %then_188, %if_end_188

%then_188:
  @al_302= alloc i32
  %1844 = load @mres_297
  store %1844, @al_302

  @c_302= alloc i32
  %1845 = load @ml_297
  store %1845, @c_302

  @sum_302= alloc i32

  jump %while_entry_83

%while_entry_83:
  %1846 = load @c_302
  br %1846, %while_body_83, %while_end_83

%while_body_83:
  store 0, @ans_1

  store 0, @i_1

  %1847 = load @al_302
  store %1847, @x_1

  %1848 = load @c_302
  store %1848, @y_1

  jump %while_entry_84

%while_entry_84:
  %1849 = load @i_1
  %1850 = lt %1849, 16
  br %1850, %while_body_84, %while_end_84

%while_body_84:
  %1851 = load @x_1
  %1852 = mod %1851, 2
  br %1852, %then_189, %else_189

%then_189:
  %1853 = load @y_1
  %1854 = mod %1853, 2
  %1855 = eq %1854, 0
  br %1855, %then_190, %if_end_190

%then_190:
  %1856 = load @ans_1
  %1857 = load @i_1
  %1858 = getelemptr @SHIFT_TABLE, %1857
  %1859 = load %1858

  %1860 = mul 1, %1859
  %1861 = add %1856, %1860
  store %1861, @ans_1

  jump %if_end_190

%if_end_190:
  jump %if_end_189

%else_189:
  %1862 = load @y_1
  %1863 = mod %1862, 2
  br %1863, %then_191, %if_end_191

%then_191:
  %1864 = load @ans_1
  %1865 = load @i_1
  %1866 = getelemptr @SHIFT_TABLE, %1865
  %1867 = load %1866

  %1868 = mul 1, %1867
  %1869 = add %1864, %1868
  store %1869, @ans_1

  jump %if_end_191

%if_end_191:
  jump %if_end_189

%if_end_189:
  %1870 = load @x_1
  %1871 = div %1870, 2
  store %1871, @x_1

  %1872 = load @y_1
  %1873 = div %1872, 2
  store %1873, @y_1

  %1874 = load @i_1
  %1875 = add %1874, 1
  store %1875, @i_1

  jump %while_entry_84

%while_end_84:
  %1876 = load @ans_1
  store %1876, @sum_302

  store 0, @ans_1

  store 0, @i_1

  %1877 = load @al_302
  store %1877, @x_1

  %1878 = load @c_302
  store %1878, @y_1

  jump %while_entry_85

%while_entry_85:
  %1879 = load @i_1
  %1880 = lt %1879, 16
  br %1880, %while_body_85, %while_end_85

%while_body_85:
  @result_193 = alloc i32
  store 0,@result_193
  %1881 = load @x_1
  %1882 = mod %1881, 2
  %1883 = ne 0, %1882
  br %1883, %then_193, %if_end_193

%then_193:
  %1884 = load @y_1
  %1885 = mod %1884, 2
  %1886 = ne 0, %1885
 store %1886,@result_193
  jump %if_end_193

%if_end_193:
  %1887= load @result_193
  br %1887, %then_192, %if_end_192

%then_192:
  %1888 = load @ans_1
  %1889 = load @i_1
  %1890 = getelemptr @SHIFT_TABLE, %1889
  %1891 = load %1890

  %1892 = mul 1, %1891
  %1893 = add %1888, %1892
  store %1893, @ans_1

  jump %if_end_192

%if_end_192:
  %1894 = load @x_1
  %1895 = div %1894, 2
  store %1895, @x_1

  %1896 = load @y_1
  %1897 = div %1896, 2
  store %1897, @y_1

  %1898 = load @i_1
  %1899 = add %1898, 1
  store %1899, @i_1

  jump %while_entry_85

%while_end_85:
  %1900 = load @ans_1
  store %1900, @c_302

  %1901 = gt 1, 15
  br %1901, %then_194, %else_194

%then_194:
  store 0, @ans_1

  jump %if_end_194

%else_194:
  store 0, @ans_1

  store 0, @i_1

  %1902 = load @c_302
  %1903 = getelemptr @SHIFT_TABLE, 1
  %1904 = load %1903

  %1905 = mul %1902, %1904
  store %1905, @x_1

  store 65535, @y_1

  jump %while_entry_86

%while_entry_86:
  %1906 = load @i_1
  %1907 = lt %1906, 16
  br %1907, %while_body_86, %while_end_86

%while_body_86:
  @result_196 = alloc i32
  store 0,@result_196
  %1908 = load @x_1
  %1909 = mod %1908, 2
  %1910 = ne 0, %1909
  br %1910, %then_196, %if_end_196

%then_196:
  %1911 = load @y_1
  %1912 = mod %1911, 2
  %1913 = ne 0, %1912
 store %1913,@result_196
  jump %if_end_196

%if_end_196:
  %1914= load @result_196
  br %1914, %then_195, %if_end_195

%then_195:
  %1915 = load @ans_1
  %1916 = load @i_1
  %1917 = getelemptr @SHIFT_TABLE, %1916
  %1918 = load %1917

  %1919 = mul 1, %1918
  %1920 = add %1915, %1919
  store %1920, @ans_1

  jump %if_end_195

%if_end_195:
  %1921 = load @x_1
  %1922 = div %1921, 2
  store %1922, @x_1

  %1923 = load @y_1
  %1924 = div %1923, 2
  store %1924, @y_1

  %1925 = load @i_1
  %1926 = add %1925, 1
  store %1926, @i_1

  jump %while_entry_86

%while_end_86:
  jump %if_end_194

%if_end_194:
  %1927 = load @ans_1
  store %1927, @c_302

  %1928 = load @sum_302
  store %1928, @al_302

  jump %while_entry_83

%while_end_83:
  %1929 = load @al_302
  store %1929, @ans_1

  %1930 = load @ans_1
  store %1930, @mres_297

  jump %if_end_188

%if_end_188:
  @al_314= alloc i32
  %1931 = load @ml_297
  store %1931, @al_314

  @c_314= alloc i32
  %1932 = load @ml_297
  store %1932, @c_314

  @sum_314= alloc i32

  jump %while_entry_87

%while_entry_87:
  %1933 = load @c_314
  br %1933, %while_body_87, %while_end_87

%while_body_87:
  store 0, @ans_1

  store 0, @i_1

  %1934 = load @al_314
  store %1934, @x_1

  %1935 = load @c_314
  store %1935, @y_1

  jump %while_entry_88

%while_entry_88:
  %1936 = load @i_1
  %1937 = lt %1936, 16
  br %1937, %while_body_88, %while_end_88

%while_body_88:
  %1938 = load @x_1
  %1939 = mod %1938, 2
  br %1939, %then_197, %else_197

%then_197:
  %1940 = load @y_1
  %1941 = mod %1940, 2
  %1942 = eq %1941, 0
  br %1942, %then_198, %if_end_198

%then_198:
  %1943 = load @ans_1
  %1944 = load @i_1
  %1945 = getelemptr @SHIFT_TABLE, %1944
  %1946 = load %1945

  %1947 = mul 1, %1946
  %1948 = add %1943, %1947
  store %1948, @ans_1

  jump %if_end_198

%if_end_198:
  jump %if_end_197

%else_197:
  %1949 = load @y_1
  %1950 = mod %1949, 2
  br %1950, %then_199, %if_end_199

%then_199:
  %1951 = load @ans_1
  %1952 = load @i_1
  %1953 = getelemptr @SHIFT_TABLE, %1952
  %1954 = load %1953

  %1955 = mul 1, %1954
  %1956 = add %1951, %1955
  store %1956, @ans_1

  jump %if_end_199

%if_end_199:
  jump %if_end_197

%if_end_197:
  %1957 = load @x_1
  %1958 = div %1957, 2
  store %1958, @x_1

  %1959 = load @y_1
  %1960 = div %1959, 2
  store %1960, @y_1

  %1961 = load @i_1
  %1962 = add %1961, 1
  store %1962, @i_1

  jump %while_entry_88

%while_end_88:
  %1963 = load @ans_1
  store %1963, @sum_314

  store 0, @ans_1

  store 0, @i_1

  %1964 = load @al_314
  store %1964, @x_1

  %1965 = load @c_314
  store %1965, @y_1

  jump %while_entry_89

%while_entry_89:
  %1966 = load @i_1
  %1967 = lt %1966, 16
  br %1967, %while_body_89, %while_end_89

%while_body_89:
  @result_201 = alloc i32
  store 0,@result_201
  %1968 = load @x_1
  %1969 = mod %1968, 2
  %1970 = ne 0, %1969
  br %1970, %then_201, %if_end_201

%then_201:
  %1971 = load @y_1
  %1972 = mod %1971, 2
  %1973 = ne 0, %1972
 store %1973,@result_201
  jump %if_end_201

%if_end_201:
  %1974= load @result_201
  br %1974, %then_200, %if_end_200

%then_200:
  %1975 = load @ans_1
  %1976 = load @i_1
  %1977 = getelemptr @SHIFT_TABLE, %1976
  %1978 = load %1977

  %1979 = mul 1, %1978
  %1980 = add %1975, %1979
  store %1980, @ans_1

  jump %if_end_200

%if_end_200:
  %1981 = load @x_1
  %1982 = div %1981, 2
  store %1982, @x_1

  %1983 = load @y_1
  %1984 = div %1983, 2
  store %1984, @y_1

  %1985 = load @i_1
  %1986 = add %1985, 1
  store %1986, @i_1

  jump %while_entry_89

%while_end_89:
  %1987 = load @ans_1
  store %1987, @c_314

  %1988 = gt 1, 15
  br %1988, %then_202, %else_202

%then_202:
  store 0, @ans_1

  jump %if_end_202

%else_202:
  store 0, @ans_1

  store 0, @i_1

  %1989 = load @c_314
  %1990 = getelemptr @SHIFT_TABLE, 1
  %1991 = load %1990

  %1992 = mul %1989, %1991
  store %1992, @x_1

  store 65535, @y_1

  jump %while_entry_90

%while_entry_90:
  %1993 = load @i_1
  %1994 = lt %1993, 16
  br %1994, %while_body_90, %while_end_90

%while_body_90:
  @result_204 = alloc i32
  store 0,@result_204
  %1995 = load @x_1
  %1996 = mod %1995, 2
  %1997 = ne 0, %1996
  br %1997, %then_204, %if_end_204

%then_204:
  %1998 = load @y_1
  %1999 = mod %1998, 2
  %2000 = ne 0, %1999
 store %2000,@result_204
  jump %if_end_204

%if_end_204:
  %2001= load @result_204
  br %2001, %then_203, %if_end_203

%then_203:
  %2002 = load @ans_1
  %2003 = load @i_1
  %2004 = getelemptr @SHIFT_TABLE, %2003
  %2005 = load %2004

  %2006 = mul 1, %2005
  %2007 = add %2002, %2006
  store %2007, @ans_1

  jump %if_end_203

%if_end_203:
  %2008 = load @x_1
  %2009 = div %2008, 2
  store %2009, @x_1

  %2010 = load @y_1
  %2011 = div %2010, 2
  store %2011, @y_1

  %2012 = load @i_1
  %2013 = add %2012, 1
  store %2013, @i_1

  jump %while_entry_90

%while_end_90:
  jump %if_end_202

%if_end_202:
  %2014 = load @ans_1
  store %2014, @c_314

  %2015 = load @sum_314
  store %2015, @al_314

  jump %while_entry_87

%while_end_87:
  %2016 = load @al_314
  store %2016, @ans_1

  %2017 = load @ans_1
  store %2017, @ml_297

  %2018 = load @mr_297
  store %2018, @x_1

  store 1, @y_1

  %2019 = load @y_1
  %2020 = ge %2019, 15
  br %2020, %then_205, %else_205

%then_205:
  %2021 = load @x_1
  %2022 = lt %2021, 0
  br %2022, %then_206, %else_206

%then_206:
  store 65535, @ans_1

  jump %if_end_206

%else_206:
  store 0, @ans_1

  jump %if_end_206

%if_end_206:
  jump %if_end_205

%else_205:
  %2023 = load @y_1
  %2024 = gt %2023, 0
  br %2024, %then_207, %else_207

%then_207:
  %2025 = load @x_1
  %2026 = gt %2025, 32767
  br %2026, %then_208, %else_208

%then_208:
  %2027 = load @x_1
  %2028 = load @y_1
  %2029 = getelemptr @SHIFT_TABLE, %2028
  %2030 = load %2029

  %2031 = div %2027, %2030
  store %2031, @x_1

  %2032 = load @x_1
  %2033 = add %2032, 65536
  %2034 = load @y_1
  %2035 = sub 15, %2034
  %2036 = add %2035, 1
  %2037 = getelemptr @SHIFT_TABLE, %2036
  %2038 = load %2037

  %2039 = sub %2033, %2038
  store %2039, @ans_1

  jump %if_end_208

%else_208:
  %2040 = load @x_1
  %2041 = load @y_1
  %2042 = getelemptr @SHIFT_TABLE, %2041
  %2043 = load %2042

  %2044 = div %2040, %2043
  store %2044, @ans_1

  jump %if_end_208

%if_end_208:
  jump %if_end_207

%else_207:
  %2045 = load @x_1
  store %2045, @ans_1

  jump %if_end_207

%if_end_207:
  jump %if_end_205

%if_end_205:
  %2046 = load @ans_1
  store %2046, @mr_297

  jump %while_entry_81

%while_end_81:
  %2047 = load @mres_297
  store %2047, @ans_1

  %2048 = load @ans_1
  store %2048, @pl_256

  %2049 = load @pr_256
  store %2049, @x_1

  store 1, @y_1

  %2050 = load @y_1
  %2051 = ge %2050, 15
  br %2051, %then_209, %else_209

%then_209:
  %2052 = load @x_1
  %2053 = lt %2052, 0
  br %2053, %then_210, %else_210

%then_210:
  store 65535, @ans_1

  jump %if_end_210

%else_210:
  store 0, @ans_1

  jump %if_end_210

%if_end_210:
  jump %if_end_209

%else_209:
  %2054 = load @y_1
  %2055 = gt %2054, 0
  br %2055, %then_211, %else_211

%then_211:
  %2056 = load @x_1
  %2057 = gt %2056, 32767
  br %2057, %then_212, %else_212

%then_212:
  %2058 = load @x_1
  %2059 = load @y_1
  %2060 = getelemptr @SHIFT_TABLE, %2059
  %2061 = load %2060

  %2062 = div %2058, %2061
  store %2062, @x_1

  %2063 = load @x_1
  %2064 = add %2063, 65536
  %2065 = load @y_1
  %2066 = sub 15, %2065
  %2067 = add %2066, 1
  %2068 = getelemptr @SHIFT_TABLE, %2067
  %2069 = load %2068

  %2070 = sub %2064, %2069
  store %2070, @ans_1

  jump %if_end_212

%else_212:
  %2071 = load @x_1
  %2072 = load @y_1
  %2073 = getelemptr @SHIFT_TABLE, %2072
  %2074 = load %2073

  %2075 = div %2071, %2074
  store %2075, @ans_1

  jump %if_end_212

%if_end_212:
  jump %if_end_211

%else_211:
  %2076 = load @x_1
  store %2076, @ans_1

  jump %if_end_211

%if_end_211:
  jump %if_end_209

%if_end_209:
  %2077 = load @ans_1
  store %2077, @pr_256

  jump %while_entry_69

%while_end_69:
  %2078 = load @pres_256
  store %2078, @ans_1

  %2079 = load @cur_1
  %2080 = getelemptr @SHIFT_TABLE, %2079
  %2081 = load %2080

  %2082 = load @ans_1
  %2083 = ne %2081, %2082
  br %2083, %then_213, %if_end_213

%then_213:
  ret 1

%if_end_213:
  %2084 = load @cur_1
  %2085 = add %2084, 1
  store %2085, @cur_1

  jump %while_entry_68

%while_end_68:
  ret 0

}

fun @main():i32 {
%entry:
  %0 = call @long_func()
  ret %0

}

