@ClientDependent: false
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Substring Values AMDP Table Function'
define table function ZSTRING_AMDP_TF
returns {
  id: string10;
  id_desc: string40;
  required_value: string40;
} implemented by method zcl_amdp_string_operation=>zstringdata_string_operation;