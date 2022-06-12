decl @getint(): i32
decl @getch(): i32
decl @getarray(*i32): i32
decl @putint(i32)
decl @putch(i32)
decl @putarray(i32, *i32)
decl @starttime()
decl @stoptime()

global @arr1 = alloc [[[[[[[i32,2],6],5],4],3],2],10], zeroinit
global @arr2 = alloc [[[[[[[i32,7],8],4],2],3],2],10], zeroinit
fun @loop1(%0: i32 , %1: i32) {
%entry:
  @x_0= alloc i32
  store %0, @x_0

  @y_0= alloc i32
  store %1, @y_0

  jump %begin

%begin:
  @a_1= alloc i32

  @b_1= alloc i32

  @c_1= alloc i32

  @d_1= alloc i32

  @e_1= alloc i32

  @f_1= alloc i32

  @g_1= alloc i32

  store 0, @a_1

  jump %while_entry_1

%while_entry_1:
  @result_1 = alloc i32
  store 0,@result_1
  %2 = load @a_1
  %3 = load @x_0
  %4 = lt %2, %3
  %5 = ne 0, %4
  br %5, %then_1, %if_end_1

%then_1:
  %6 = load @a_1
  %7 = load @y_0
  %8 = lt %6, %7
  %9 = ne 0, %8
 store %9,@result_1
  jump %if_end_1

%if_end_1:
  %10= load @result_1
  br %10, %while_body_1, %while_end_1

%while_body_1:
  store 0, @b_1

  jump %while_entry_2

%while_entry_2:
  %11 = load @b_1
  %12 = lt %11, 2
  br %12, %while_body_2, %while_end_2

%while_body_2:
  store 0, @c_1

  jump %while_entry_3

%while_entry_3:
  %13 = load @c_1
  %14 = lt %13, 3
  br %14, %while_body_3, %while_end_3

%while_body_3:
  store 0, @d_1

  jump %while_entry_4

%while_entry_4:
  %15 = load @d_1
  %16 = lt %15, 4
  br %16, %while_body_4, %while_end_4

%while_body_4:
  store 0, @e_1

  jump %while_entry_5

%while_entry_5:
  %17 = load @e_1
  %18 = lt %17, 5
  br %18, %while_body_5, %while_end_5

%while_body_5:
  store 0, @f_1

  jump %while_entry_6

%while_entry_6:
  %19 = load @f_1
  %20 = lt %19, 6
  br %20, %while_body_6, %while_end_6

%while_body_6:
  store 0, @g_1

  jump %while_entry_7

%while_entry_7:
  %21 = load @g_1
  %22 = lt %21, 2
  br %22, %while_body_7, %while_end_7

%while_body_7:
  %23 = load @g_1
  %24 = load @f_1
  %25 = load @e_1
  %26 = load @d_1
  %27 = load @c_1
  %28 = load @b_1
  %29 = load @a_1
  %30 = getelemptr @arr1, %29
  %31 = getelemptr %30, %28
  %32 = getelemptr %31, %27
  %33 = getelemptr %32, %26
  %34 = getelemptr %33, %25
  %35 = getelemptr %34, %24
  %36 = getelemptr %35, %23
  %37 = load @a_1
  %38 = load @b_1
  %39 = add %37, %38
  %40 = load @c_1
  %41 = add %39, %40
  %42 = load @d_1
  %43 = add %41, %42
  %44 = load @e_1
  %45 = add %43, %44
  %46 = load @f_1
  %47 = add %45, %46
  %48 = load @g_1
  %49 = add %47, %48
  %50 = load @x_0
  %51 = add %49, %50
  %52 = load @y_0
  %53 = add %51, %52
  store %53, %36
  %54 = load @g_1
  %55 = add %54, 1
  store %55, @g_1

  jump %while_entry_7

%while_end_7:
  %56 = load @f_1
  %57 = add %56, 1
  store %57, @f_1

  jump %while_entry_6

%while_end_6:
  %58 = load @e_1
  %59 = add %58, 1
  store %59, @e_1

  jump %while_entry_5

%while_end_5:
  %60 = load @d_1
  %61 = add %60, 1
  store %61, @d_1

  jump %while_entry_4

%while_end_4:
  %62 = load @c_1
  %63 = add %62, 1
  store %63, @c_1

  jump %while_entry_3

%while_end_3:
  %64 = load @b_1
  %65 = add %64, 1
  store %65, @b_1

  jump %while_entry_2

%while_end_2:
  %66 = load @a_1
  %67 = add %66, 1
  store %67, @a_1

  jump %while_entry_1

%while_end_1:
  jump %end

%end:
  ret
}

fun @loop2() {
%entry:
  jump %begin

%begin:
  @a_1= alloc i32

  @b_1= alloc i32

  @c_1= alloc i32

  @d_1= alloc i32

  @e_1= alloc i32

  @f_1= alloc i32

  @g_1= alloc i32

  store 0, @a_1

  jump %while_entry_1

%while_entry_1:
  %0 = load @a_1
  %1 = lt %0, 10
  br %1, %while_body_1, %while_end_1

%while_body_1:
  store 0, @b_1

  jump %while_entry_2

%while_entry_2:
  %2 = load @b_1
  %3 = lt %2, 2
  br %3, %while_body_2, %while_end_2

%while_body_2:
  store 0, @c_1

  jump %while_entry_3

%while_entry_3:
  %4 = load @c_1
  %5 = lt %4, 3
  br %5, %while_body_3, %while_end_3

%while_body_3:
  store 0, @d_1

  jump %while_entry_4

%while_entry_4:
  %6 = load @d_1
  %7 = lt %6, 2
  br %7, %while_body_4, %while_end_4

%while_body_4:
  store 0, @e_1

  jump %while_entry_5

%while_entry_5:
  %8 = load @e_1
  %9 = lt %8, 4
  br %9, %while_body_5, %while_end_5

%while_body_5:
  store 0, @f_1

  jump %while_entry_6

%while_entry_6:
  %10 = load @f_1
  %11 = lt %10, 8
  br %11, %while_body_6, %while_end_6

%while_body_6:
  store 0, @g_1

  jump %while_entry_7

%while_entry_7:
  %12 = load @g_1
  %13 = lt %12, 7
  br %13, %while_body_7, %while_end_7

%while_body_7:
  %14 = load @g_1
  %15 = load @f_1
  %16 = load @e_1
  %17 = load @d_1
  %18 = load @c_1
  %19 = load @b_1
  %20 = load @a_1
  %21 = getelemptr @arr2, %20
  %22 = getelemptr %21, %19
  %23 = getelemptr %22, %18
  %24 = getelemptr %23, %17
  %25 = getelemptr %24, %16
  %26 = getelemptr %25, %15
  %27 = getelemptr %26, %14
  %28 = load @a_1
  %29 = load @b_1
  %30 = add %28, %29
  %31 = load @d_1
  %32 = add %30, %31
  %33 = load @g_1
  %34 = add %32, %33
  store %34, %27
  %35 = load @g_1
  %36 = add %35, 1
  store %36, @g_1

  jump %while_entry_7

%while_end_7:
  %37 = load @f_1
  %38 = add %37, 1
  store %38, @f_1

  jump %while_entry_6

%while_end_6:
  %39 = load @e_1
  %40 = add %39, 1
  store %40, @e_1

  jump %while_entry_5

%while_end_5:
  %41 = load @d_1
  %42 = add %41, 1
  store %42, @d_1

  jump %while_entry_4

%while_end_4:
  %43 = load @c_1
  %44 = add %43, 1
  store %44, @c_1

  jump %while_entry_3

%while_end_3:
  %45 = load @b_1
  %46 = add %45, 1
  store %46, @b_1

  jump %while_entry_2

%while_end_2:
  %47 = load @a_1
  %48 = add %47, 1
  store %48, @a_1

  jump %while_entry_1

%while_end_1:
  jump %end

%end:
  ret
}

fun @loop3(%0: i32 , %1: i32 , %2: i32 , %3: i32 , %4: i32 , %5: i32 , %6: i32):i32 {
%entry:
  %ret = alloc i32
  @h_0= alloc i32
  store %0, @h_0

  @i_0= alloc i32
  store %1, @i_0

  @j_0= alloc i32
  store %2, @j_0

  @k_0= alloc i32
  store %3, @k_0

  @l_0= alloc i32
  store %4, @l_0

  @m_0= alloc i32
  store %5, @m_0

  @n_0= alloc i32
  store %6, @n_0

  jump %begin

%begin:
  @a_1= alloc i32

  @b_1= alloc i32

  @c_1= alloc i32

  @d_1= alloc i32

  @e_1= alloc i32

  @f_1= alloc i32

  @g_1= alloc i32

  @ans_1= alloc i32
  store 0, @ans_1

  store 0, @a_1

  jump %while_entry_1

%while_entry_1:
  %7 = load @a_1
  %8 = lt %7, 10
  br %8, %while_body_1, %while_end_1

%while_body_1:
  store 0, @b_1

  jump %while_entry_2

%while_entry_2:
  %9 = load @b_1
  %10 = lt %9, 100
  br %10, %while_body_2, %while_end_2

%while_body_2:
  store 0, @c_1

  jump %while_entry_3

%while_entry_3:
  %11 = load @c_1
  %12 = lt %11, 1000
  br %12, %while_body_3, %while_end_3

%while_body_3:
  store 0, @d_1

  jump %while_entry_4

%while_entry_4:
  %13 = load @d_1
  %14 = lt %13, 10000
  br %14, %while_body_4, %while_end_4

%while_body_4:
  store 0, @e_1

  jump %while_entry_5

%while_entry_5:
  %15 = load @e_1
  %16 = lt %15, 100000
  br %16, %while_body_5, %while_end_5

%while_body_5:
  store 0, @f_1

  jump %while_entry_6

%while_entry_6:
  %17 = load @f_1
  %18 = lt %17, 1000000
  br %18, %while_body_6, %while_end_6

%while_body_6:
  store 0, @g_1

  jump %while_entry_7

%while_entry_7:
  %19 = load @g_1
  %20 = lt %19, 10000000
  br %20, %while_body_7, %while_end_7

%while_body_7:
  %21 = load @ans_1
  %22 = mod %21, 817
  %23 = load @g_1
  %24 = load @f_1
  %25 = load @e_1
  %26 = load @d_1
  %27 = load @c_1
  %28 = load @b_1
  %29 = load @a_1
  %30 = getelemptr @arr1, %29
  %31 = getelemptr %30, %28
  %32 = getelemptr %31, %27
  %33 = getelemptr %32, %26
  %34 = getelemptr %33, %25
  %35 = getelemptr %34, %24
  %36 = getelemptr %35, %23
  %37 = load %36

  %38 = add %22, %37
  %39 = load @g_1
  %40 = load @f_1
  %41 = load @e_1
  %42 = load @d_1
  %43 = load @c_1
  %44 = load @b_1
  %45 = load @a_1
  %46 = getelemptr @arr2, %45
  %47 = getelemptr %46, %44
  %48 = getelemptr %47, %43
  %49 = getelemptr %48, %42
  %50 = getelemptr %49, %41
  %51 = getelemptr %50, %40
  %52 = getelemptr %51, %39
  %53 = load %52

  %54 = add %38, %53
  store %54, @ans_1

  %55 = load @g_1
  %56 = add %55, 1
  store %56, @g_1

  %57 = load @g_1
  %58 = load @n_0
  %59 = ge %57, %58
  br %59, %then_1, %if_end_1

%then_1:
  jump %while_end_7

%while_body_7_break_1:
  jump %if_end_1

%if_end_1:
  jump %while_entry_7

%while_end_7:
  %60 = load @f_1
  %61 = add %60, 1
  store %61, @f_1

  %62 = load @f_1
  %63 = load @m_0
  %64 = ge %62, %63
  br %64, %then_2, %if_end_2

%then_2:
  jump %while_end_6

%while_body_6_break_2:
  jump %if_end_2

%if_end_2:
  jump %while_entry_6

%while_end_6:
  %65 = load @e_1
  %66 = add %65, 1
  store %66, @e_1

  %67 = load @e_1
  %68 = load @l_0
  %69 = ge %67, %68
  br %69, %then_3, %if_end_3

%then_3:
  jump %while_end_5

%while_body_5_break_3:
  jump %if_end_3

%if_end_3:
  jump %while_entry_5

%while_end_5:
  %70 = load @d_1
  %71 = add %70, 1
  store %71, @d_1

  %72 = load @d_1
  %73 = load @k_0
  %74 = ge %72, %73
  br %74, %then_4, %if_end_4

%then_4:
  jump %while_end_4

%while_body_4_break_4:
  jump %if_end_4

%if_end_4:
  jump %while_entry_4

%while_end_4:
  %75 = load @c_1
  %76 = add %75, 1
  store %76, @c_1

  %77 = load @c_1
  %78 = load @j_0
  %79 = ge %77, %78
  br %79, %then_5, %if_end_5

%then_5:
  jump %while_end_3

%while_body_3_break_5:
  jump %if_end_5

%if_end_5:
  jump %while_entry_3

%while_end_3:
  %80 = load @b_1
  %81 = add %80, 1
  store %81, @b_1

  %82 = load @b_1
  %83 = load @i_0
  %84 = ge %82, %83
  br %84, %then_6, %if_end_6

%then_6:
  jump %while_end_2

%while_body_2_break_6:
  jump %if_end_6

%if_end_6:
  jump %while_entry_2

%while_end_2:
  %85 = load @a_1
  %86 = add %85, 1
  store %86, @a_1

  %87 = load @a_1
  %88 = load @h_0
  %89 = ge %87, %88
  br %89, %then_7, %if_end_7

%then_7:
  jump %while_end_1

%while_body_1_break_7:
  jump %if_end_7

%if_end_7:
  jump %while_entry_1

%while_end_1:
  %90 = load @ans_1
  store %90, %ret

  jump %end

%ret_1:
  jump %end

%end:
  %91 = load %ret
  ret %91
}

fun @main():i32 {
%entry:
  %ret = alloc i32
  jump %begin

%begin:
  @x_1= alloc i32
  %0 = call @getint()
  store %0, @x_1

  @y_1= alloc i32
  %1 = call @getint()
  store %1, @y_1

  @h_1= alloc i32
  %2 = call @getint()
  store %2, @h_1

  @i_1= alloc i32
  %3 = call @getint()
  store %3, @i_1

  @j_1= alloc i32
  %4 = call @getint()
  store %4, @j_1

  @k_1= alloc i32
  %5 = call @getint()
  store %5, @k_1

  @l_1= alloc i32
  %6 = call @getint()
  store %6, @l_1

  @m_1= alloc i32
  %7 = call @getint()
  store %7, @m_1

  @n_1= alloc i32
  %8 = call @getint()
  store %8, @n_1

  %9 = load @x_1
  %10 = load @y_1
  call @loop1(%9,%10)
  call @loop2()
  %11 = load @h_1
  %12 = load @i_1
  %13 = load @j_1
  %14 = load @k_1
  %15 = load @l_1
  %16 = load @m_1
  %17 = load @n_1
  %18 = call @loop3(%11,%12,%13,%14,%15,%16,%17)
  store %18, %ret

  jump %end

%ret_1:
  jump %end

%end:
  %19 = load %ret
  ret %19
}

