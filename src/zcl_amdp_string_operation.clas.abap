class zcl_amdp_string_operation definition public final create public .

    public section.

        interfaces: if_amdp_marker_hdb.

        class-methods: zstringdata_string_operation
        for table function zstring_amdp_tf.

    protected section.

    private section.

endclass.

class zcl_amdp_string_operation implementation.

  method zstringdata_string_operation
  by database function for hdb
  language sqlscript
  options read-only
  using zstringdata.

    RETURN SELECT ID AS id,
                  ID_DESC AS ID_DESC,
                  SUBSTR_BEFORE(substr_after(ID_DESC, '_'), '.') as required_value
           FROM ZSTRINGDATA;

  endmethod.

endclass.
