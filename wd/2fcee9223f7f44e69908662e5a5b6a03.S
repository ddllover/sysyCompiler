decl @getint(): i32
decl @getch(): i32
decl @getarray(*i32): i32
decl @putint(i32)
decl @putch(i32)
decl @putarray(i32, *i32)
decl @starttime()
decl @stoptime()

fun @main():i32 {
%entry:
  @i_1= alloc i32

  @sum_1= alloc i32

  @a_1= alloc [i32,10]

  store 0, @sum_1

  store 0, @i_1

  jump %while_entry_1

%while_entry_1:
  %0 = load @i_1
  %1 = lt %0, 10
  br %1, %while_body_1, %while_end_1

%while_body_1:
  %2 = load @i_1
  %3 = getelemptr @a_1, %2
  %4 = load @i_1
  %5 = add %4, 1
  store %5, %3
  %6 = load @i_1
  %7 = add %6, 1
  store %7, @i_1

  jump %while_entry_1

%while_end_1:
  @x_1= alloc i32

  @high_1= alloc i32

  @low_1= alloc i32

  @mid_1= alloc i32

  @n_1= alloc i32

  store 10, @n_1

  %8 = call @getint()
  store %8, @x_1

  %9 = load @n_1
  %10 = sub %9, 1
  store %10, @high_1

  store 0, @low_1

  %11 = load @high_1
  %12 = load @low_1
  %13 = add %11, %12
  %14 = div %13, 2
  store %14, @mid_1

  @flag_1= alloc i32

  store 0, @flag_1

  store 0, @i_1

  @j_1= alloc i32

  store 0, @j_1

  jump %while_entry_2

%while_entry_2:
  @result_1 = alloc i32
  store 0,@result_1
  %15 = load @i_1
  %16 = lt %15, 10
  %17 = ne 0, %16
  br %17, %then_1, %if_end_1

%then_1:
  %18 = load @flag_1
  %19 = eq %18, 0
  %20 = ne 0, %19
 store %20,@result_1
  jump %if_end_1

%if_end_1:
  %21= load @result_1
  br %21, %while_body_2, %while_end_2

%while_body_2:
  %22 = load @i_1
  %23 = getelemptr @a_1, %22
  %24 = load %23

  %25 = load @x_1
  %26 = eq %24, %25
  br %26, %then_2, %if_end_2

%then_2:
  store 1, @flag_1

  %27 = load @i_1
  store %27, @j_1

  jump %if_end_2

%if_end_2:
  %28 = load @i_1
  %29 = add %28, 1
  store %29, @i_1

  jump %while_entry_2

%while_end_2:
  %30 = load @flag_1
  %31 = eq %30, 1
  br %31, %then_3, %else_3

%then_3:
  %32 = load @j_1
  call @putint(%32)
  jump %if_end_3

%else_3:
  store 0, @x_1

  %33 = load @x_1
  call @putint(%33)
  jump %if_end_3

%if_end_3:
  store 10, @x_1

  %34 = load @x_1
  call @putch(%34)
  ret 0

}

