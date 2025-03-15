@AbapCatalog.sqlViewName: 'ZORGMASIDVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORG_ID Value Help'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_ORG_MASTER_ID_VH as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZD_ORG_MASTER_ID') 
{   
    @UI.hidden: true
    key domain_name,
    @UI.hidden: true
    key value_position,
    @UI.hidden: true
    @Semantics.language: true
    key language,
    @EndUserText.label: 'Org Master ID'
    value_low,
    @Semantics.text: true
    text
}
