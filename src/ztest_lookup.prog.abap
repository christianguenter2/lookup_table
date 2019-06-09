*&---------------------------------------------------------------------*
*& Report ztest_lookup
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_lookup.

TYPES: BEGIN OF ty_base,
         uname TYPE xubname,
         date  TYPE datum,
         time  TYPE uzeit,
       END OF ty_base,
       tty_base TYPE STANDARD TABLE OF ty_base
                     WITH NON-UNIQUE KEY uname.

TYPES: BEGIN OF ty_lookup,
         uname TYPE xubname,
         text  TYPE char10,
       END OF ty_lookup,
       tty_lookup TYPE HASHED TABLE OF ty_lookup
                       WITH UNIQUE KEY uname.

TYPES: BEGIN OF ty_result,
         uname TYPE xubname,
         date  TYPE datum,
         time  TYPE uzeit,
         text  TYPE char10,
       END OF ty_result,
       tty_result TYPE STANDARD TABLE OF ty_result
                       WITH NON-UNIQUE KEY uname.

DATA(base_table) = VALUE tty_base(
                     ( uname = 'DEVELOPER' date = sy-datum time = sy-uzeit )
                     ( uname = 'USER01'    date = sy-datum time = sy-uzeit )
                     ( uname = 'USER02'    date = sy-datum time = sy-uzeit )
                     ( uname = 'USER03'    date = sy-datum time = sy-uzeit )
                   ).

DATA(lookup_table) = VALUE tty_lookup(
                       ( uname = 'DEVELOPER' text = 'root' )
                       ( uname = 'USER01'    text = 'u1' )
                       ( uname = 'USER02'    text = 'u2' )
                       ( uname = 'USER03'    text = 'u3' )
                     ).

DATA(result_table) = CORRESPONDING tty_result( base_table FROM lookup_table
                                                          USING uname = uname ) ##operator.

cl_demo_output=>write( base_table ).
cl_demo_output=>write( lookup_table ).
cl_demo_output=>write( result_table ).
cl_demo_output=>display( ).
