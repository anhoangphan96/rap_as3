CLASS lhc_ZI_AS3_ZORGBU DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_as3_zorgbu RESULT result.

ENDCLASS.

CLASS lhc_ZI_AS3_ZORGBU IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
