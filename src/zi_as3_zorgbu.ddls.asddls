@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Organization of Business View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_AS3_ZORGBU as select from ztorgbu
//composition of target_data_source_name as _association_name
{
    key zzid as ID,
    bukrs as Bukrs,
    org_code as OrgCode,
    valid_fr as ValidFr,
    valid_to as ValidTo,
    org_code as OrgCode2,
    org_id as OrgId,
    land1 as Land1,
    pilot_od as PilotOd,
    org_master_id as OrgMasterId,
    unit_id as UnitId,
    division_code as DivisionCode,
    business_name as BusinessName,
    org_name as OrgName,
    status as Status,
    erdat as Erdat,
    @Semantics.user.createdBy: true
    ernam as Ernam,
    aedat as Aedat,
    @Semantics.user.lastChangedBy: true
    aenam as Aenam,
    @Semantics.systemDateTime.lastChangedAt: true
    last_change_at as LastChangeAt
//    _association_name // Make association public
}
