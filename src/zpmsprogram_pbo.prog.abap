*&---------------------------------------------------------------------*
*& Include          ZPMSPROGRAM_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET TITLEBAR '0100'.
  IF gs_userrol-role_name = 'ADMIN'.
    SET PF-STATUS '0100'.
  ELSE.
    SET PF-STATUS '0100' EXCLUDING '&BAK'.
  ENDIF.

  LOOP AT SCREEN.
    IF gs_userrol-role_name EQ 'EMPLOYEE'.
      IF screen-group1 EQ 'GR4'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0101 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0101 OUTPUT.
  LOOP AT SCREEN.
    IF gv_rbpersk EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group2 EQ 'GR3'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF gv_rbdeptk EQ abap_true.
      IF screen-group1 EQ 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group2 EQ 'GR3'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '0200'.
  SET TITLEBAR '0200'.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0102 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0102 OUTPUT.
  LOOP AT SCREEN.
    IF gv_rbpersg EQ abap_true.
      IF screen-group1 EQ 'GR1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group2 EQ 'GR3'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
    IF gv_rbdeptg EQ abap_true.
      IF screen-group1 EQ 'GR2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'GR1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group2 EQ 'GR3'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

  PERFORM get_data_personal.
  PERFORM get_data_departman.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0103 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0103 OUTPUT.
  IF tb_id-activetab EQ '&TAB3'.
    CLEAR: go_cont.
    PERFORM display_alv.
  ENDIF.
ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0104 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0104 OUTPUT.
  IF tb_id-activetab EQ '&TAB4'.
    CLEAR: go_cont.
    PERFORM display_alv2.
    PERFORM get_pdf_data. "Get PDF
    PERFORM display_pdf.
  ENDIF.
ENDMODULE.
