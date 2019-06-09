*&---------------------------------------------------------------------*
*& Report ztest_lookup
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_lookup.

TYPES: BEGIN OF ty_one,
         uname TYPE xubname,
         date  TYPE datum,
         time  TYPE uzeit,
       END OF ty_one,
       tty_one TYPE STANDARD TABLE OF ty_one
                    WITH NON-UNIQUE KEY uname.

TYPES: BEGIN OF ty_two,
         uname TYPE xubname,
         text  TYPE char10,
       END OF ty_two,
       tty_two TYPE HASHED TABLE OF ty_two
                    WITH UNIQUE KEY uname.

TYPES: BEGIN OF ty_three,
         uname TYPE xubname,
         date  TYPE datum,
         time  TYPE uzeit,
         text  TYPE char10,
       END OF ty_three,
       tty_three TYPE STANDARD TABLE OF ty_three
                      WITH NON-UNIQUE KEY uname.

DATA(lt_one) = VALUE tty_one(
                 ( uname = 'DEVELOPER' date = sy-datum time = sy-uzeit )
                 ( uname = 'USER01'    date = sy-datum time = sy-uzeit )
                 ( uname = 'USER02'    date = sy-datum time = sy-uzeit )
                 ( uname = 'USER03'    date = sy-datum time = sy-uzeit )
               ).

DATA(lt_two) = VALUE tty_two(
                 ( uname = 'DEVELOPER' text = 'root' )
                 ( uname = 'USER01'    text = 'u1' )
                 ( uname = 'USER02'    text = 'u2' )
                 ( uname = 'USER03'    text = 'u3' )
               ).

DATA(lt_three) = CORRESPONDING tty_three( lt_one FROM lt_two
                                                 USING uname = uname ) ##operator.

cl_demo_output=>write( lt_one ).
cl_demo_output=>write( lt_two ).
cl_demo_output=>write( lt_three ).
cl_demo_output=>display( ).
