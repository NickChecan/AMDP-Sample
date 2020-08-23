*&---------------------------------------------------------------------*
*& Report z_fill_zstringdata
*&---------------------------------------------------------------------*
report z_fill_zstringdata.

selection-screen begin of block a with frame.
parameters: rb_add radiobutton group op default 'X'.
parameters: rb_del radiobutton group op.
selection-screen end of block a.

start-of-selection.

    data(sub_routine) = cond #(
        when rb_add is not initial then 'ADD_DATA'
        else 'DEL_DATA'
    ).

    perform: (sub_routine) in program (sy-repid).

    commit work and wait.

    data(lv_message) = cond #(
        when rb_add is not initial then 'Data added to the ZSTRINGDATA table'
        else 'Data deleted from the ZSTRINGDATA'
    ).

    message lv_message type 'S'.

form: add_data.

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID001' id_desc = 'abcd_12345.txt' ) ).

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID002' id_desc = 'efg_678.xml') ).

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID003' id_desc = 'hijll_9101112.pdf') ).

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID004' id_desc = 'm_13141516.xlsx') ).

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID005' id_desc = 'no_17.csv') ).

    insert into zstringdata values @(
    value #( mandt = '001' id = 'ID006' id_desc = 'pqrstuv_1819202122.pptx') ).

endform.

form: del_data.

    delete from zstringdata.

endform.
