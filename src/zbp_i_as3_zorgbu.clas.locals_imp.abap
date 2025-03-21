CLASS lsc_zi_as3_zorgbu DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zi_as3_zorgbu IMPLEMENTATION.

  METHOD save_modified.
    DATA: lt_zorgbu TYPE STANDARD TABLE OF ztorgbu,
          ls_zorgbu TYPE ztorgbu.

*   Set up unmanaged save for RateName
    IF create-organizationbusiness IS NOT INITIAL.
      CLEAR: lt_zorgbu.
      LOOP AT create-organizationbusiness INTO DATA(ls_create).
        CLEAR: ls_zorgbu.
        ls_zorgbu = CORRESPONDING #( ls_create ).
        ls_zorgbu-zzid = ls_create-id.
        ls_zorgbu-org_code = ls_create-OrgCode.
        ls_zorgbu-valid_fr = ls_create-ValidFr.
        ls_zorgbu-valid_to = ls_create-ValidTo.
        ls_zorgbu-org_id   = ls_create-OrgId.
        ls_zorgbu-pilot_od = ls_create-PilotOd.
        ls_zorgbu-org_master_id = ls_create-OrgMasterId.
        ls_zorgbu-unit_id = ls_create-UnitId.
        ls_zorgbu-division_code = ls_create-DivisionCode.
        ls_zorgbu-business_name = ls_create-BusinessName.
        ls_zorgbu-org_name      = ls_create-OrgName.
        ls_zorgbu-last_change_at = ls_create-LastChangeAt.
        ls_zorgbu-erdat = cl_abap_context_info=>get_system_date( ).
        IF ls_zorgbu-status IS INITIAL.
            ls_zorgbu-status = '0'.
        ENDIF.
        APPEND ls_zorgbu TO lt_zorgbu.
      ENDLOOP.

      INSERT ztorgbu FROM TABLE @lt_zorgbu.
    ENDIF.

    IF update-organizationbusiness IS NOT INITIAL.
      CLEAR: lt_zorgbu.
      LOOP AT update-organizationbusiness INTO DATA(ls_update).
        CLEAR: ls_zorgbu.
        ls_zorgbu = CORRESPONDING #( ls_update ).
        ls_zorgbu-zzid = ls_update-id.
        ls_zorgbu-org_code = ls_update-OrgCode.
        ls_zorgbu-valid_fr = ls_update-ValidFr.
        ls_zorgbu-valid_to = ls_update-ValidTo.
        ls_zorgbu-org_id   = ls_update-OrgId.
        ls_zorgbu-pilot_od = ls_update-PilotOd.
        ls_zorgbu-org_master_id = ls_update-OrgMasterId.
        ls_zorgbu-unit_id = ls_update-UnitId.
        ls_zorgbu-division_code = ls_update-DivisionCode.
        ls_zorgbu-business_name = ls_update-BusinessName.
        ls_zorgbu-org_name      = ls_update-OrgName.
        ls_zorgbu-last_change_at = ls_update-LastChangeAt.
        ls_zorgbu-aedat = cl_abap_context_info=>get_system_date( ).
        IF ls_update-%control-Status = if_abap_behv=>mk-off.
            ls_zorgbu-status = '2'.
        ENDIF.
        APPEND ls_zorgbu TO lt_zorgbu.
      ENDLOOP.
      UPDATE ztorgbu FROM TABLE @lt_zorgbu.
    ENDIF.

    IF delete-organizationbusiness IS NOT INITIAL.
      CLEAR: lt_zorgbu.
      LOOP AT delete-organizationbusiness INTO DATA(ls_delete).
        CLEAR: ls_zorgbu.
        SELECT SINGLE *
            FROM ztorgbu
            WHERE zzid = @ls_delete-id
            INTO @ls_zorgbu.

        APPEND ls_zorgbu TO lt_zorgbu.
      ENDLOOP.
      DELETE ztorgbu FROM TABLE @lt_zorgbu.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_AS3_ZORGBU DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR OrganizationBusiness RESULT result.
    METHODS assignorgname FOR DETERMINE ON MODIFY
      IMPORTING keys FOR organizationbusiness~assignorgname.
    METHODS checkmonthyear FOR VALIDATE ON SAVE
      IMPORTING keys FOR organizationbusiness~checkmonthyear.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR organizationbusiness RESULT result.
    METHODS checkunitid FOR VALIDATE ON SAVE
      IMPORTING keys FOR organizationbusiness~checkunitid.
    METHODS assigndivcode FOR DETERMINE ON MODIFY
      IMPORTING keys FOR organizationbusiness~assigndivcode.

    METHODS checkdivcode FOR VALIDATE ON SAVE
      IMPORTING keys FOR organizationbusiness~checkdivcode.
*    METHODS approval FOR MODIFY
*      IMPORTING keys FOR ACTION organizationbusiness~approval.

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

  METHOD checkMonthYear.

    DATA: lv_valid TYPE abap_boolean.

    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
      ENTITY OrganizationBusiness
      FIELDS ( ValidFr ValidTo )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_zorgbu).

    IF lt_zorgbu IS NOT INITIAL.
      DATA(ls_zorgbu) = lt_zorgbu[ 1 ].

      IF ls_zorgbu-ValidFr IS NOT INITIAL.

        lv_valid = cl_abap_datfm=>check_date_format(  im_datfm =  |{ ls_zorgbu-ValidFr }01| ).
        IF lv_valid = abap_false .
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
               %tky = ls_zorgbu-%tky
               %element-validfr = if_abap_behv=>mk-on
               %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                   number = 001
                                   severity = ms-error )
                                   ) ).
        ENDIF.
      ENDIF.

      IF ls_zorgbu-ValidTo IS NOT INITIAL.

        lv_valid = cl_abap_datfm=>check_date_format(  im_datfm =  |{ ls_zorgbu-ValidTo }01| ).
        IF lv_valid = abap_false .
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
               %tky = ls_zorgbu-%tky
               %element-validto = if_abap_behv=>mk-on
               %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                   number = 001
                                   severity = ms-error )
                                   )
                                   ).

        ENDIF.

      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD get_instance_features.
    DATA result_line LIKE LINE OF result.
    DATA keys_of_active_instances TYPE TABLE FOR INSTANCE FEATURES KEY zi_as3_zorgbu.

    LOOP AT keys INTO DATA(key).

      CLEAR keys_of_active_instances.
      APPEND INITIAL LINE TO  keys_of_active_instances.

      keys_of_active_instances[ 1 ]-%tky = key-%tky.
      "change the %is_draft flag to read only the active instance
      keys_of_active_instances[ 1 ]-%is_draft = if_abap_behv=>mk-off.

      result_line-%tky = key-%tky.

      READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
            ENTITY OrganizationBusiness
              FIELDS ( Bukrs OrgCode OrgId ValidFr ValidTo )
              WITH CORRESPONDING #( keys_of_active_instances )
            RESULT DATA(active_entity)
            .

      IF active_entity IS NOT INITIAL.
        result_line-%features-%field-Bukrs =  if_abap_behv=>fc-f-read_only .
        result_line-%features-%field-OrgCode =  if_abap_behv=>fc-f-read_only .
        result_line-%features-%field-OrgId =  if_abap_behv=>fc-f-read_only .
        result_line-%features-%field-ValidFr =  if_abap_behv=>fc-f-read_only .
        result_line-%features-%field-ValidTo =  if_abap_behv=>fc-f-read_only .
        result_line-%delete = if_abap_behv=>fc-o-enabled.
      ELSE.
        result_line-%features-%field-Bukrs = if_abap_behv=>fc-f-unrestricted.
        result_line-%features-%field-OrgCode =  if_abap_behv=>fc-f-unrestricted.
        result_line-%features-%field-OrgId =  if_abap_behv=>fc-f-unrestricted.
        result_line-%features-%field-ValidFr =  if_abap_behv=>fc-f-unrestricted.
        result_line-%features-%field-ValidTo =  if_abap_behv=>fc-f-unrestricted.
        result_line-%action-approval =  if_abap_behv=>fc-o-disabled.
      ENDIF.


*      Check enable/disable for delete action (apply to draft and active instance)
      SELECT SINGLE *
          FROM ztorgbu
          WHERE zzid = @key-id
          INTO @DATA(ls_ztorgbu).

      IF sy-subrc = 0.
        CASE ls_ztorgbu-status.
          WHEN '0'.
            result_line-%delete = if_abap_behv=>fc-o-enabled.
            result_line-%action-approval = if_abap_behv=>fc-o-enabled.
          WHEN '1'.
            result_line-%delete = if_abap_behv=>fc-o-disabled.
            result_line-%action-approval = if_abap_behv=>fc-o-disabled.
          WHEN '2'.
            result_line-%delete = if_abap_behv=>fc-o-disabled.
            result_line-%action-approval = if_abap_behv=>fc-o-enabled.
          WHEN ''.
            result_line-%delete = if_abap_behv=>fc-o-enabled.
            result_line-%action-approval =  if_abap_behv=>fc-o-disabled.
        ENDCASE.
      ELSE.
        result_line-%delete = if_abap_behv=>fc-o-enabled.
      ENDIF.

      APPEND result_line TO result.

    ENDLOOP.
  ENDMETHOD.

  METHOD checkUnitId.
    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
  ENTITY OrganizationBusiness
      FIELDS ( OrgId UnitId )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_zorgbu).

    READ TABLE lt_zorgbu INTO DATA(ls_zorgbu) INDEX 1.
    CASE ls_zorgbu-OrgId.
      WHEN '1'.
        IF ls_zorgbu-UnitId <> '0'
            AND ls_zorgbu-UnitId <> '1'.
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
                                                       %tky = ls_zorgbu-%tky
                                                       %element-unitid = if_abap_behv=>mk-on
                                                       %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                                                           number = 002
                                                                           severity = ms-error
                                                                           v1 = ls_zorgbu-OrgId
                                                                           v2 = '0, 1' )
                                                                           )
                                                                           ).
        ENDIF.
      WHEN '3' OR '4'.
        IF ls_zorgbu-UnitId <> '0'
             AND ls_zorgbu-UnitId <> '2'.
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
                                                       %tky = ls_zorgbu-%tky
                                                       %element-unitid = if_abap_behv=>mk-on
                                                       %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                                                           number = 002
                                                                           severity = ms-error
                                                                           v1 = ls_zorgbu-OrgId
                                                                           v2 = '0, 2' )
                                                                           )
                                                                           ).
        ENDIF.


      WHEN OTHERS.
        IF ls_zorgbu-UnitId <> '0'.
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
                                                       %tky = ls_zorgbu-%tky
                                                       %element-unitid = if_abap_behv=>mk-on
                                                       %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                                                           number = 002
                                                                           severity = ms-error
                                                                           v1 = ls_zorgbu-OrgId
                                                                           v2 = '0' )
                                                                           )
                                                                           ).
        ENDIF.
    ENDCASE.
  ENDMETHOD.

  METHOD assignDivCode.

    DATA: lt_update TYPE TABLE FOR UPDATE zi_as3_zorgbu.

    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
    ENTITY OrganizationBusiness
        FIELDS ( OrgId OrgCode )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_zorgbu).

    lt_update = CORRESPONDING #( lt_zorgbu ).
    IF lt_update IS NOT INITIAL.
      READ TABLE lt_update ASSIGNING FIELD-SYMBOL(<lfs_update>) INDEX 1.
      IF <lfs_update>-OrgId = '1'.
        <lfs_update>-DivisionCode = ''.
      ELSEIF <lfs_update>-OrgId = '3' OR <lfs_update>-OrgId = '4'.
        <lfs_update>-DivisionCode = <lfs_update>-OrgCode.
      ELSE.
      ENDIF.

      MODIFY ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
      ENTITY OrganizationBusiness
          UPDATE FIELDS ( DivisionCode )
          WITH lt_update.

    ENDIF.
  ENDMETHOD.

*  METHOD approval.
*
*    DATA: lt_create_orgbu TYPE TABLE FOR CREATE zi_as3_zorgbu,
*          lt_create_orgbu2 TYPE TABLE FOR CREATE zi_as3_zorgbu,
*          lt_delete_orgbu TYPE TABLE FOR DELETE zi_as3_zorgbu,
*          lt_update_orgbu TYPE STANDARD TABLE OF ztorgbu,
*          lv_date         TYPE d.
*
*   " remove travel instances with initial %cid (i.e., not set by caller API)
*   READ TABLE keys WITH KEY %cid = '' INTO DATA(key_with_inital_cid).
*   ASSERT key_with_inital_cid IS INITIAL.
*
*    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
*      ENTITY OrganizationBusiness
*         ALL FIELDS WITH
*         CORRESPONDING #( keys )
*       RESULT DATA(lt_ztorgbu).
*
*
*    IF lt_ztorgbu IS NOT INITIAL.
*
*      lt_create_orgbu = CORRESPONDING #( lt_ztorgbu ).
*      LOOP AT lt_create_orgbu ASSIGNING FIELD-SYMBOL(<lfs_ztorgbu>).
*        SELECT *
*            FROM ztorgbu
*            WHERE bukrs = @<lfs_ztorgbu>-bukrs
*              AND org_code = @<lfs_ztorgbu>-OrgCode
*              AND status = '1'
*              AND valid_to = '999912'
*          INTO TABLE @DATA(lt_zorgbuold).
*
*
*
*        IF sy-subrc = 0 .
*
*
*          <lfs_ztorgbu>-%cid = keys[ KEY entity %key = <lfs_ztorgbu>-%key ]-%cid .
*          lv_date = |{ <lfs_ztorgbu>-ValidFr }01| .
*          lv_date -= 1.
*          <lfs_ztorgbu>-Status = '1'.
*          <lfs_ztorgbu>-ValidTo = '999912'.
*          lt_delete_orgbu = VALUE #( BASE lt_delete_orgbu ( id = <lfs_ztorgbu>-id ) ).
*
*          READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
*          ENTITY OrganizationBusiness
*             ALL FIELDS WITH VALUE #(  (  %key-id = lt_zorgbuold[ 1 ]-zzid ) )
*           RESULT DATA(lt_ztorgbu_old).
*
*          lt_create_orgbu2 = CORRESPONDING #( lt_ztorgbu_old ).
*          READ TABLE lt_create_orgbu2 ASSIGNING FIELD-SYMBOL(<lfs_zorgbu_old>) INDEX 1 .
*          IF sy-subrc = 0.
*              <lfs_zorgbu_old>-%cid = keys[ KEY entity %key = <lfs_zorgbu_old>-%key ]-%cid .
*              <lfs_zorgbu_old>-ValidTo = |{ lv_date(4) }{ lv_date+4(2) }|.
*              lt_delete_orgbu = VALUE #( BASE lt_delete_orgbu ( id =  <lfs_zorgbu_old>-id ) ).
*          ENDIF.
*
*
*          TRY.
*              <lfs_ztorgbu>-id =  cl_system_uuid=>create_uuid_x16_static(   ).
*              <lfs_zorgbu_old>-id = cl_system_uuid=>create_uuid_x16_static(   ).
*            CATCH cx_uuid_error.
*              "handle exception
*          ENDTRY.
*
*        ELSE.
*          <lfs_ztorgbu>-%cid = keys[ KEY entity %key = <lfs_ztorgbu>-%key ]-%cid .
*          <lfs_ztorgbu>-Status = '1'.
*          <lfs_ztorgbu>-ValidTo = '999912'.
*          lt_delete_orgbu = VALUE #( BASE lt_delete_orgbu ( id = <lfs_ztorgbu>-id ) ).
*          TRY.
*              <lfs_ztorgbu>-id =  cl_system_uuid=>create_uuid_x16_static(   ).
*            CATCH cx_uuid_error.
*              "handle exception
*          ENDTRY.
*
*        ENDIF.
*      ENDLOOP.
*
*
*      MODIFY ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
*                ENTITY OrganizationBusiness
*                DELETE FROM lt_delete_orgbu.
*
*      MODIFY ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
*        ENTITY OrganizationBusiness
*        CREATE
*        SET FIELDS WITH lt_create_orgbu2.
*
*      MODIFY ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
*                ENTITY OrganizationBusiness
*                CREATE
*                SET FIELDS WITH lt_create_orgbu
*                MAPPED DATA(lt_mapped)
*                FAILED DATA(lt_failed)
*                REPORTED DATA(lt_reported).
*
*      mapped-organizationbusiness = lt_mapped-organizationbusiness.
*    ENDIF.
*
*
*
*  ENDMETHOD.

  METHOD checkDivCode.

    READ ENTITIES OF zi_as3_zorgbu IN LOCAL MODE
    ENTITY OrganizationBusiness
        FIELDS ( OrgId DivisionCode OrgCode )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_zorgbu).

    READ TABLE lt_zorgbu INTO DATA(ls_zorgbu) INDEX 1.
    CASE ls_zorgbu-OrgId.
      WHEN '1'.
        IF ls_zorgbu-DivisionCode IS NOT INITIAL.
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
                                                       %tky = ls_zorgbu-%tky
                                                       %element-divisioncode = if_abap_behv=>mk-on
                                                       %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                                                           number = 003
                                                                           severity = ms-error
                                                                           v1 = ls_zorgbu-OrgId
                                                                           v2 = 'Division Code must be blank' )
                                                                           )
                                                                           ).
        ENDIF.
      WHEN '3' OR '4'.
        IF ls_zorgbu-DivisionCode <> ls_zorgbu-OrgCode.
          APPEND VALUE #( %tky = ls_zorgbu-%tky ) TO failed-organizationbusiness.
          reported-organizationbusiness =  VALUE #( BASE reported-organizationbusiness (
                                                       %tky = ls_zorgbu-%tky
                                                       %element-divisioncode = if_abap_behv=>mk-on
                                                       %msg = new_message( id = 'ZM_AS3_ZORGBU'
                                                                           number = 003
                                                                           severity = ms-error
                                                                           v1 = ls_zorgbu-OrgId
                                                                           v2 = 'Division Code must be same as Org Code' )
                                                                           )
                                                                           ).
        ENDIF.


      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
