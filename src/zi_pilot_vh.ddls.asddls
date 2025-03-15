@AbapCatalog.sqlViewName: 'ZSPILOTVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for status'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_PILOT_VH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_PILOT') 
{   
    @UI.hidden: true
    key domain_name,
    @UI.hidden: true
    key value_position,
    @UI.hidden: true
    @Semantics.language: true
    key language,
    @EndUserText.label: 'Pilot'
    value_low,
    @Semantics.text: true
    text
}
