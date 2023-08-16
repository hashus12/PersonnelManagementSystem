*&---------------------------------------------------------------------*
*& Report ZPMSPROGRAM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpmsprogram MESSAGE-ID zpms.

INCLUDE zpmsprogram_top.
INCLUDE zpmsprogram_cls.
INCLUDE zpmsprogram_pbo.
INCLUDE zpmsprogram_pai.
INCLUDE zpmsprogram_frm.

START-OF-SELECTION.

  PERFORM get_data_alv.
  PERFORM set_fcat_alv.
  PERFORM set_layout_alv.

  CLEAR: gs_users.
  SELECT SINGLE
    u~username
    u~password
    r~role_name
    FROM zusers_t AS u
    INNER JOIN zroles_t AS r ON u~role_id = r~role_id
    INTO gs_userrol
    WHERE u~username = p_usrnme AND u~password = p_paswrd.
    IF sy-subrc EQ 0.
      MESSAGE s006 .
      CALL SCREEN 0100.
    ELSE.
      IF p_usrnme IS INITIAL.
        MESSAGE s007 DISPLAY LIKE 'E' .
      ELSE.
        MESSAGE s008 DISPLAY LIKE 'E' .
      ENDIF.
    ENDIF.
