*&---------------------------------------------------------------------*
*& Include          ZPMSPROGRAM_CLS
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION.
  PUBLIC SECTION.
    METHODS handle_top_of_page          "TOP_OF_PAGE
        FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING
        e_dyndoc_id
        table_index.

    METHODS handle_top_of_page2          "TOP_OF_PAGE
        FOR EVENT top_of_page OF cl_gui_alv_grid
      IMPORTING
        e_dyndoc_id
        table_index.

    METHODS handle_hotspot_click        "HOTSPOT_CLICK
        FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING
        e_row_id
        e_column_id.

    METHODS handle_double_click         "DOUBLE CLICK
        FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING
        e_row
        e_column
        es_row_no.

    METHODS handle_data_changed         "DATA_CHANGED
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_data_changed2         "DATA_CHANGED
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_data_changed3         "DATA_CHANGED
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_data_changed4         "DATA_CHANGED
        FOR EVENT data_changed OF cl_gui_alv_grid
      IMPORTING
        er_data_changed
        e_onf4
        e_onf4_before
        e_onf4_after
        e_ucomm.

    METHODS handle_onf4                 "ONF4
        FOR EVENT onf4 OF cl_gui_alv_grid
      IMPORTING
        e_fieldname
        e_fieldvalue
        es_row_no
        er_event_data
        et_bad_cells
        e_display.

    METHODS handle_toolbar              "TOOLBAR
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_object
        e_interactive.

    METHODS handle_toolbar2              "TOOLBAR
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_object
        e_interactive.

    METHODS handle_toolbar3              "TOOLBAR
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_object
        e_interactive.

    METHODS handle_toolbar4              "TOOLBAR
        FOR EVENT toolbar OF cl_gui_alv_grid
      IMPORTING
        e_object
        e_interactive.

    METHODS handle_user_command         "USER_COMMAND
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

    METHODS handle_user_command2         "USER_COMMAND
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

    METHODS handle_user_command3         "USER_COMMAND
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

    METHODS handle_user_command4         "USER_COMMAND
        FOR EVENT user_command OF cl_gui_alv_grid
      IMPORTING
        e_ucomm.

ENDCLASS.

CLASS cl_event_receiver IMPLEMENTATION.

  METHOD handle_top_of_page.
    DATA: lv_text_top  TYPE sdydo_text_element,
          lv_text_top2 TYPE sdydo_text_element,
          lv_text_top3 TYPE sdydo_text_element.

    lv_text_top  = 'Personel Düzenleme'.

    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text_top                 " Single Text, Up To 255 Characters Long
        sap_style = cl_dd_document=>heading.                 " Recommended Styles

    CALL METHOD go_docu->display_document
      EXPORTING
        parent = go_gui_top.                " Contain Object Already Exists

    CREATE OBJECT go_docu.

    lv_text_top2 = 'Departman Düzenleme'.
    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text_top2
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu->display_document
      EXPORTING
        parent = go_gui_top2.

*  go_docu = NEW cl_dd_document( ).
    CREATE OBJECT go_docu.

    lv_text_top3 = 'İzin Düzenleme'.
    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text_top3
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu->display_document
      EXPORTING
        parent = go_gui_top3.

  ENDMETHOD.                    "handle_top_of_page

  METHOD handle_top_of_page2.
    DATA: lv_text_top  TYPE sdydo_text_element.

    lv_text_top  = 'Personel Detayları'.

    CALL METHOD go_docu->add_text
      EXPORTING
        text      = lv_text_top
        sap_style = cl_dd_document=>heading.

    CALL METHOD go_docu->display_document
      EXPORTING
        parent = go_gui_top.

  ENDMETHOD.                    "handle

  METHOD handle_hotspot_click.
*    BREAK-POINT.
  ENDMETHOD.                    "handle_hotspot_click

  METHOD handle_double_click.
*    BREAK-POINT.
  ENDMETHOD.                    "handle_double_click

  METHOD handle_data_changed.
    DATA: ls_modi      TYPE lvc_s_modi,
          ls_employees TYPE gty_employees_t,
          lv_mess      TYPE char200.

    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_employees INTO ls_employees WITH KEY emp_id = ls_modi-value.
      IF sy-subrc = 0.
        MESSAGE s004 WITH 'personel numarası' DISPLAY LIKE 'E'.
        er_data_changed->modify_cell(
        EXPORTING
          i_row_id    = ls_modi-row_id                 " Row ID
          i_tabix     =  ls_modi-tabix        " Row Index
            i_fieldname =  'EMP_ID'                " Field Name
          i_value     =  ' '                " Value
          ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.                   "handle_data_changed

  METHOD handle_data_changed2.
    DATA: ls_modi        TYPE lvc_s_modi,
          ls_departments TYPE gty_departments_t.

    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_departments INTO ls_departments WITH KEY dept_id = ls_modi-value.
      IF sy-subrc = 0.
        MESSAGE s004 WITH 'departman numarası' DISPLAY LIKE 'E'.
        er_data_changed->modify_cell(
        EXPORTING
          i_row_id    = ls_modi-row_id
          i_tabix     =  ls_modi-tabix
          i_fieldname =  'DEPT_ID'
          i_value     =  ' '
          ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_data_changed3.
    DATA: ls_modi   TYPE lvc_s_modi,
          ls_leaves TYPE gty_leaves_t.

    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_leaves INTO ls_leaves WITH KEY leave_id = ls_modi-value.
      IF sy-subrc = 0.
        MESSAGE s004 WITH 'izin numarası' DISPLAY LIKE 'E'.

        er_data_changed->modify_cell(
        EXPORTING
          i_row_id    = ls_modi-row_id
          i_tabix     =  ls_modi-tabix
          i_fieldname =  'LEAVE_ID'
          i_value     =  ' '
          ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_data_changed4.
    DATA: ls_modi  TYPE lvc_s_modi,
          ls_roles TYPE gty_roles_t.

    LOOP AT er_data_changed->mt_good_cells INTO ls_modi.
      READ TABLE gt_roles INTO ls_roles WITH KEY role_id = ls_modi-value.
      IF sy-subrc = 0.
        MESSAGE s004 WITH 'rol numarası' DISPLAY LIKE 'E'.
        er_data_changed->modify_cell(
        EXPORTING
          i_row_id    = ls_modi-row_id
          i_tabix     =  ls_modi-tabix
          i_fieldname =  'ROLE_ID'
          i_value     =  ' '
          ).

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD handle_onf4.
    DATA: lt_return_tab TYPE TABLE OF ddshretval,
          ls_return_tab TYPE ddshretval.

    CASE e_fieldname.
      WHEN 'DEPARTMENT'.
        CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
          EXPORTING
            retfield     = 'DEPT_NAME'
            window_title = 'Department F4'
            value_org    = 'S'
          TABLES
            value_tab    = gt_departments
            return_tab   = lt_return_tab.

        READ TABLE lt_return_tab INTO ls_return_tab WITH KEY fieldname = 'F0002'.
        IF sy-subrc EQ 0.
          READ TABLE gt_employees ASSIGNING <gfs_employees> INDEX es_row_no-row_id.
          IF sy-subrc EQ 0.
            <gfs_employees>-department = ls_return_tab-fieldval.
            go_grid->refresh_table_display( ).
          ENDIF.
        ENDIF.

        er_event_data->m_event_handled = abap_true.

      WHEN 'POSITIONS'.
        CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
          EXPORTING
            retfield     = 'POSITIONS'
            window_title = 'Görev F4'
            value_org    = 'S'
          TABLES
            value_tab    = gt_employees
            return_tab   = lt_return_tab.

        READ TABLE lt_return_tab INTO ls_return_tab WITH KEY fieldname = 'F0007'.
        IF sy-subrc EQ 0.
          READ TABLE gt_employees ASSIGNING <gfs_employees> INDEX es_row_no-row_id.
          IF sy-subrc EQ 0.
            <gfs_employees>-positions = ls_return_tab-fieldval.
            go_grid->refresh_table_display( ).
          ENDIF.
        ENDIF.

        er_event_data->m_event_handled = abap_true.
    ENDCASE.
  ENDMETHOD.                    "handle_onf4

  METHOD handle_toolbar.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-function = '&KAY'.
    ls_toolbar-text = 'Düzenlemeleri Kaydet'.
    ls_toolbar-icon = '@2L@'.
    ls_toolbar-quickinfo = 'Kaydetme işlemi'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_toolbar2.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-function = '&KAY2'.
    ls_toolbar-text = 'Düzenlemeleri Kaydet'.
    ls_toolbar-icon = '@2L@'.
    ls_toolbar-quickinfo = 'Kaydetme işlemi'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_toolbar3.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-function = '&KAY3'.
    ls_toolbar-text = 'Düzenlemeleri Kaydet'.
    ls_toolbar-icon = '@2L@'.
    ls_toolbar-quickinfo = 'Kaydetme işlemi'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_toolbar4.
    DATA: ls_toolbar TYPE stb_button.

    CLEAR: ls_toolbar.
    ls_toolbar-function = '&KAY4'.
    ls_toolbar-text = 'Düzenlemeleri Kaydet'.
    ls_toolbar-icon = '@2L@'.
    ls_toolbar-quickinfo = 'Kaydetme işlemi'.
    APPEND ls_toolbar TO e_object->mt_toolbar.
  ENDMETHOD.

  METHOD handle_user_command.
    DATA: ls_employees TYPE zemployees_t.

    CASE e_ucomm.
      WHEN '&KAY'.
        DELETE FROM zemployees_t.
        COMMIT WORK AND WAIT.
        LOOP AT gt_employees INTO gs_employees.
          CLEAR: ls_employees.
          IF gs_employees IS NOT INITIAL.
            ls_employees-emp_id     = gs_employees-emp_id.
            ls_employees-first_name = gs_employees-first_name.
            ls_employees-last_name  = gs_employees-last_name.
            ls_employees-birthdate  = gs_employees-birthdate.
            ls_employees-department = gs_employees-department.
            ls_employees-positions  = gs_employees-positions.
            ls_employees-gender     = gs_employees-gender.

            MODIFY zemployees_t FROM ls_employees .
            COMMIT WORK AND WAIT.
            IF sy-subrc EQ 0.
              MESSAGE s005 WITH 'Personel'.
            ENDIF.
          ENDIF.
          go_grid->refresh_table_display( ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_user_command2.
    DATA: ls_departments TYPE zdepartments_t.

    CASE e_ucomm.
      WHEN '&KAY2'.
        DELETE FROM zdepartments_t.
        COMMIT WORK AND WAIT.
        LOOP AT gt_departments INTO gs_departments.
          CLEAR: ls_departments.
          IF gs_departments IS NOT INITIAL.
            ls_departments-dept_id   = gs_departments-dept_id.
            ls_departments-dept_name = gs_departments-dept_name.
            ls_departments-manager   = gs_departments-manager.
            ls_departments-location  = gs_departments-location.

            MODIFY zdepartments_t FROM ls_departments .
            COMMIT WORK AND WAIT.
            IF sy-subrc EQ 0.
              MESSAGE s005 WITH 'Departman'.
            ENDIF.
          ENDIF.
          go_grid->refresh_table_display( ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_user_command3.
    DATA: ls_leaves TYPE zleaves_t.

    CASE e_ucomm.
      WHEN '&KAY3'.
        DELETE FROM zleaves_t.
        COMMIT WORK AND WAIT.
        LOOP AT gt_leaves INTO gs_leaves.
          CLEAR: ls_leaves.
          IF gs_leaves IS NOT INITIAL.
            ls_leaves-leave_id   = gs_leaves-leave_id.
            ls_leaves-emp_id     = gs_leaves-emp_id.
            ls_leaves-leave_type = gs_leaves-leave_type.
            ls_leaves-start_date = gs_leaves-start_date.
            ls_leaves-end_date   = gs_leaves-end_date.
            ls_leaves-reason     = gs_leaves-reason.

            MODIFY zleaves_t FROM ls_leaves .
            COMMIT WORK AND WAIT.
            IF sy-subrc EQ 0.
              MESSAGE s005 WITH 'İzin'.
            ENDIF.
          ENDIF.
          go_grid->refresh_table_display( ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.

  METHOD handle_user_command4.
    DATA: ls_roles TYPE zroles_t.

    CASE e_ucomm.
      WHEN '&KAY4'.
        DELETE FROM zroles_t.
        COMMIT WORK AND WAIT.
        LOOP AT gt_roles INTO gs_roles.
          CLEAR: ls_roles.
          IF gs_roles IS NOT INITIAL.
            ls_roles-role_id      = gs_roles-role_id.
            ls_roles-role_name    = gs_roles-role_name.

            MODIFY zroles_t FROM ls_roles .
            COMMIT WORK AND WAIT.
            IF sy-subrc EQ 0.
              MESSAGE s005 WITH 'Rol'.
            ENDIF.
          ENDIF.
          go_grid->refresh_table_display( ).
        ENDLOOP.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
