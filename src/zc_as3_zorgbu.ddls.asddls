@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for ZI_AS3_ZORGBU'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AS3_ZORGBU
  provider contract transactional_query as projection on ZI_AS3_ZORGBU
{
    @UI.hidden: true
    key ID,
    Bukrs,
    @ObjectModel.text.element: [ 'OrgName' ]
    OrgCode,
    ValidFr,
    ValidTo,
    OrgCode2,
    @UI.hidden: true
    _OrgIdText.text as OrgIdText,
    @ObjectModel.text.element: [ 'OrgIdText' ]
    OrgId,
    @UI.hidden: true
    _CountryText.CountryName as CountryName,
    @ObjectModel.text.element: [ 'CountryName' ]
    Land1,
    @UI.hidden: true
    _PilotText.text as PilotText,
    @ObjectModel.text.element: [ 'PilotText' ]
    PilotOd,
    @UI.hidden: true
    _OrgMasText.text as OrgMasText,
    @ObjectModel.text.element: [ 'OrgMasText' ]
    OrgMasterId,
    @UI.hidden: true
    _UnitText.text as UnitText,
    @ObjectModel.text.element: [ 'UnitText' ]
    UnitId,
    DivisionCode,
    BusinessName,
    OrgName,
    @UI.hidden: true
    _StatusText.text as StatusText,
    @ObjectModel.text.element: [ 'StatusText' ]
    Status,
    Erdat,
    Ernam,
    Aedat,
    Aenam,
    LastChangeAt,
    _OrgIdText,
    _CountryText,
    _PilotText,
    _OrgMasText,
    _UnitText,
    _StatusText
}
