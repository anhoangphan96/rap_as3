@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for ZI_AS3_ZORGBU'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AS3_ZORGBU
  provider contract transactional_query as projection on ZI_AS3_ZORGBU
{
    key Bukrs,
    key OrgCode,
    key ValidFr,
    key ValidTo,
    OrgCode2,
    OrgId,
    Land1,
    PilotOd,
    OrgMasterId,
    UnitId,
    DivisionCode,
    BusinessName,
    OrgName,
    Status,
    Erdat,
    Ernam,
    Aedat,
    Aenam,
    LastChangeAt
}
