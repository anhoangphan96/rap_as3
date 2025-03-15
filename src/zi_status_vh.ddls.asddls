@AbapCatalog.sqlViewName: 'ZSTATUSVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for status'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_STATUS_VH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_STATUS') 
{   
    @UI.hidden: true
    key domain_name,
    @UI.hidden: true
    key value_position,
    @UI.hidden: true
    @Semantics.language: true
    key language,
    @EndUserText.label: 'Status'
    value_low,
    @Semantics.text: true
    text
}
