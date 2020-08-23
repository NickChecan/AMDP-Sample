@AbapCatalog.sqlViewName: 'Y_STRING_AMDP'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Substring Value AMDP Table Function Consumption'
define view Y_SUBSTRING_FUNC_AMDP 
as select from zstringdata as _Main
inner join zstring_amdp_tf as _AMDP
on _Main.id = _AMDP.id {
    
    key _Main.id,
    _Main.id_desc,
    _AMDP.required_value
        
}