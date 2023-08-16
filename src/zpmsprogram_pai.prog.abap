*&---------------------------------------------------------------------*
*& Include          ZPMSPROGRAM_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0.
    WHEN '&TAB1'.
      tb_id-activetab = '&TAB1'.
    WHEN '&TAB2'.
      tb_id-activetab = '&TAB2'.
    WHEN '&TAB3'.
      tb_id-activetab = '&TAB3'.
    WHEN '&TAB4'.
      tb_id-activetab = '&TAB4'.
    WHEN '&BAK'.
      CALL SCREEN 0200 STARTING AT 10 5
                       ENDING AT   60 17.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0101  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0101 INPUT.
  CASE sy-ucomm.
    WHEN '&SAV'.
      PERFORM personal_check_input.
      PERFORM personal_save_data.
      PERFORM personal_clear_data.
    WHEN '&CLR'.
      PERFORM personal_clear_data.
    WHEN '&SAV2'.
      PERFORM departman_check_input.
      PERFORM departman_save_data.
      PERFORM departman_clear_data.
    WHEN '&CLR2'.
      PERFORM departman_clear_data.
    WHEN '&RAD'.
      IF gv_rbdeptk EQ abap_true.
      ENDIF.
  ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN '&CAN'.
      LEAVE TO SCREEN 0.
    WHEN '&EMP'.
      PERFORM call_tablemain USING 'ZEMPLOYEES_T'.
    WHEN '&USR'.
      PERFORM call_tablemain USING 'ZUSERS_T'.
    WHEN '&DPT'.
      PERFORM call_tablemain USING 'ZDEPARTMENTS_T'.
    WHEN '&ROL'.
      PERFORM call_tablemain USING 'ZROLES_T'.
    WHEN '&LEV'.
      PERFORM call_tablemain USING 'ZLEAVES_T'.
  ENDCASE.
  CLEAR: ok_code_0200.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0102  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0102 INPUT.
  CASE sy-ucomm.
    WHEN '&RAD'.
  ENDCASE.
ENDMODULE.
