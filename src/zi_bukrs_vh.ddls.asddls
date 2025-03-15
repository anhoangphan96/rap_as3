@AbapCatalog.sqlViewName: 'ZBUKRSVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BUKRS Value Help'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_BUKRS_VH as select from ztbukrs
{
    key bukrs as Bukrs,
        butxt as Butxt,
        @EndUserText.label: 'City'
        ort01 as Ort01,
        waers as Waers
}
