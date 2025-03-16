CLASS lhc_ZI_AS3_ZORGBU DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR OrganizationBusiness RESULT result.
    METHODS assignorgname FOR DETERMINE ON MODIFY
      IMPORTING keys FOR organizationbusiness~assignorgname.

ENDCLASS.

CLASS lhc_ZI_AS3_ZORGBU IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD assignOrgName.

    DATA: lt_update TYPE TABLE FOR UPDATE zi_as3_zorgbu.

    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
    ENTITY OrganizationBusiness
        FIELDS ( BusinessName )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_zorgbu).

    lt_update = CORRESPONDING #( lt_zorgbu ).
    IF lt_update IS NOT INITIAL.
      READ TABLE lt_update ASSIGNING FIELD-SYMBOL(<lfs_update>) INDEX 1.
      IF <lfs_update> IS NOT INITIAL.
        <lfs_update>-OrgName = <lfs_update>-BusinessName.
      ENDIF.

      MODIFY ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
      ENTITY OrganizationBusiness
          UPDATE FIELDS ( OrgName )
          WITH lt_update.

    ENDIF.



  ENDMETHOD.

ENDCLASS.
