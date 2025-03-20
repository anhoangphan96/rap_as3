@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Organization of Business View'
@Metadata.ignorePropagatedAnnotations: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZI_AS3_ZORGBU as select from ztorgbu
//composition of target_data_source_name as _association_name
    association [0..1] to ZI_ORG_ID_VH as _OrgIdText on $projection.OrgId = _OrgIdText.value_low and _OrgIdText.language = $session.system_language
    association [0..1] to I_CountryText as _CountryText on $projection.Land1 = _CountryText.Country and _CountryText.Language = $session.system_language
    association [0..1] to ZI_PILOT_VH as _PilotText on $projection.PilotOd = _PilotText.value_low and _PilotText.language = $session.system_language
    association [0..1] to ZI_ORG_MASTER_ID_VH as _OrgMasText on $projection.OrgMasterId = _OrgMasText.value_low and _OrgMasText.language = $session.system_language
    association [0..1] to ZI_UNIT_ID_VH as _UnitText on $projection.UnitId = _UnitText.value_low and _UnitText.language = $session.system_language
    association [0..1] to ZI_STATUS_VH as _StatusText on $projection.Status = _StatusText.value_low and _StatusText.language = $session.system_language
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
    last_change_at as LastChangeAt,
//    _association_name // Make association public
    _OrgIdText,
    _CountryText,
    _PilotText,
    _OrgMasText,
    _UnitText,
    _StatusText
}
