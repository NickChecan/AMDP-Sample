class zcl_amdp_demo definition
  public
  final
  create public .

public section.

    interfaces: if_amdp_marker_hdb.
    interfaces: if_oo_adt_classrun.

    types: begin of ty_result_line,
        airline           type s_carrname,
        flight_connection type s_conn_id,
        old_price         type s_price,
        old_currency      type s_currcode,
        new_price         type s_price,
        new_currency      type s_currcode,
    end of ty_result_line.

    types: begin of ty_flights_line,
        airline           type s_carrname,
        flight_connection type s_conn_id,
        price             type s_price,
        currency          type s_currcode,
    end of ty_flights_line.

    types: ty_result_table  type standard table of ty_result_line with empty key.
    types: ty_flights_table type standard table of ty_flights_line with empty key.
    types: ty_flights       type standard table of sflight.

    methods: get_flights
    exporting value(result) type ty_result_table
    raising cx_amdp_execution_error.

    methods: convert_currency
    importing value(flights) type ty_flights_table
    exporting value(result)  type ty_result_table
    raising cx_amdp_execution_error.

    methods: test_amdp
    exporting value(flights) type ty_flights_table
    raising cx_amdp_execution_error.

protected section.

private section.

endclass.

class zcl_amdp_demo implementation.

  method convert_currency by database procedure
  for hdb
  language sqlscript
  options read-only.

    declare today date;
    declare new_currency nvarchar(3);

    select current_date into today from dummy;
    new_currency := 'EUR';

    result = select distinct
                airline,
                flight_connection,
                price    as old_price,
                currency as old_currency,
                convert_currency(
                    "AMOUNT"          => price,
                    "SOURCE_UNIT"     => currency,
                    "TARGET_UNIT"     => :new_currency,
                    "REFERENCE_DATE"  => :today,
                    "CLIENT"          => '001',
                    "ERROR_HANDLING"  => 'set to null',
                    "SCHEMA"          => 'SAPA4H'
                ) as new_price,
             :new_currency as new_currency
             from :flights;

  endmethod.

  method get_flights by database procedure
  for hdb
  language sqlscript
  options read-only
  using
    sflight
    scarr
    zcl_amdp_demo=>convert_currency.

    flights = select distinct
                c.carrname as airline,
                f.connid as flight_connection,
                f.price as price,
                f.currency as currency
              from "SFLIGHT" as f
              inner join "SCARR" as c
              on f.carrid = c.carrid;

    call "ZCL_AMDP_DEMO=>CONVERT_CURRENCY"( :flights, result );

  endmethod.

  method if_oo_adt_classrun~main.

    try.
        me->get_flights(
            importing
                result = data(lt_result)
        ).

    catch cx_amdp_execution_error into data(lx_amdp).
      out->write( lx_amdp->get_longtext( ) ).
    endtry.

  out->write( lt_result ).

  endmethod.

  method test_amdp by database procedure
  for hdb
  language sqlscript
  options read-only
  using sflight scarr.

    flights = select distinct
                c.carrname as airline,
                f.connid as flight_connection,
                f.price as price,
                f.currency as currency
              from "SFLIGHT" as f
              inner join "SCARR" as c
              on f.carrid = c.carrid;

  endmethod.

endclass.
