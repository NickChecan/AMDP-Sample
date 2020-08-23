*&---------------------------------------------------------------------*
*& Report z_test_amdp
*&---------------------------------------------------------------------*
report z_test_amdp.


start-of-selection.

    break-point.

    data(o_amdp) = new zcl_amdp_demo( ).

    try.
        o_amdp->test_amdp(
            importing
                flights = data(lt_result)
        ).

    catch cx_amdp_execution_error into data(lx_amdp).
        write lx_amdp->get_longtext( ).
    endtry.

    break-point.
