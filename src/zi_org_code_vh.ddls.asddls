@AbapCatalog.sqlViewName: 'ZORGCODEVH'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORG_CODE Value help'
@Metadata.ignorePropagatedAnnotations: true
define view ZI_ORG_CODE_VH
  as select from ztorgbu
{
      @EndUserText.label: 'Organization Code'
  key org_code as OrgCode,
      @EndUserText.label: 'Organization ID'
      org_id   as OrgId,
      @EndUserText.label: 'Valid From Year/Month'
      valid_fr as ValidFrom,
      @EndUserText.label: 'Valid End Year/Month'
      valid_to as ValidTo,
      status   as Status
}

where
      valid_to = '999912'
  and status   = '1';
