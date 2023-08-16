*&---------------------------------------------------------------------*
*& Include          ZPMSPROGRAM_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM personal_save_data .

  DATA: ls_employees TYPE zemployees_t.
  DATA: lv_pers_mess TYPE char30.

  IF gv_genderrad1 EQ abap_true.
    gs_employees-gender = 'K'.
  ELSE.
    gs_employees-gender = 'E'.
  ENDIF.

  IF gs_employees IS NOT INITIAL.
    SELECT SINGLE * FROM zemployees_t
    INTO ls_employees
    WHERE zemployees_t~emp_id EQ gs_employees-emp_id.
    IF sy-subrc EQ 0.
      CONCATENATE gs_employees-emp_id
                  'personel numarası'
                  INTO lv_pers_mess
                  SEPARATED BY space.
      MESSAGE w004 WITH lv_pers_mess.
    ELSE.
      CLEAR: ls_employees.
      ls_employees-emp_id     = gs_employees-emp_id.
      ls_employees-first_name = gs_employees-first_name.
      ls_employees-last_name  = gs_employees-last_name.
      ls_employees-birthdate  = gs_employees-birthdate.
      ls_employees-gender     = gs_employees-gender.
      ls_employees-department = gs_employees-department.
      ls_employees-positions  = gs_employees-positions.
      INSERT zemployees_t FROM ls_employees.
      COMMIT WORK AND WAIT.
      MESSAGE s001 WITH 'Personel'.
    ENDIF.

  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CLEAR_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM personal_clear_data .
  CLEAR: gs_employees.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CHECK_INPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM personal_check_input .
  IF gs_employees-first_name IS INITIAL.
    MESSAGE w000 WITH 'Personel Adı'.
  ELSEIF gs_employees-last_name IS INITIAL.
    MESSAGE w000 WITH 'Personel Soyadı'.
  ELSEIF gs_employees-birthdate IS INITIAL.
    MESSAGE w000 WITH 'Personel Doğum Tarihi'.
  ELSEIF gs_employees-department IS INITIAL.
    MESSAGE w000 WITH 'Departman'.
  ELSEIF gs_employees-positions IS INITIAL.
    MESSAGE w000 WITH 'Ünvan/Görev'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DEPARTMAN_CHECK_INPUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM departman_check_input .
  IF gs_departments-dept_name IS INITIAL.
    MESSAGE w000 WITH 'Departman Adı'.
  ELSEIF gs_departments-manager IS INITIAL.
    MESSAGE w000 WITH 'Departman Yöneticisi'.
  ELSEIF gs_departments-location IS INITIAL.
    MESSAGE w000 WITH 'Departman Lokasyonu'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DEPARTMAN_SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM departman_save_data .
  DATA: ls_departments TYPE zdepartments_t.
  DATA: lv_dept_mess TYPE char20.

  IF gs_departments IS NOT INITIAL.
    SELECT SINGLE * FROM zdepartments_t
    INTO ls_departments
    WHERE zdepartments_t~dept_id EQ gs_departments-dept_id.
    IF sy-subrc EQ 0.
      CONCATENATE gs_employees-emp_id
                  'personel numarası'
                  INTO lv_dept_mess
   	              SEPARATED BY space.
      MESSAGE w004 WITH lv_dept_mess.
    ELSE.
      CLEAR: ls_departments.
      ls_departments-dept_id   = gs_departments-dept_id.
      ls_departments-dept_name = gs_departments-dept_name.
      ls_departments-manager   = gs_departments-manager.
      ls_departments-location  = gs_departments-location.
      INSERT zdepartments_t FROM ls_departments.
      COMMIT WORK AND WAIT.
      MESSAGE s001 WITH 'Departman'.
    ENDIF.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DEPARTMAN_CLEAR_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM departman_clear_data .
  CLEAR: gs_departments.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_TABLEMAIN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM call_tablemain USING p_tablename.
  DATA: lv_tablename TYPE tabname.

  lv_tablename = p_tablename.

  CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
    EXPORTING
      action    = 'U'          "Display/Maintenance/Transport
      view_name = lv_tablename. "here comes the name of the table/view
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_PERSONAL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data_personal .
  IF gs_empdisplay-emp_id IS NOT INITIAL.
    SELECT SINGLE * FROM zemployees_t
    INTO gs_empdisplay
    WHERE zemployees_t~emp_id EQ gs_empdisplay-emp_id.
    IF sy-subrc EQ 0.
      MESSAGE s003 WITH 'personel numarası'.
    ELSE.
      MESSAGE w002 WITH 'personel numarası' DISPLAY LIKE 'W'.
      CLEAR: gs_empdisplay.
    ENDIF.
    CLEAR: gs_empdisplay-emp_id.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_DEPARTMAN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data_departman .
  IF gs_deptdisplay-dept_id IS NOT INITIAL.
    SELECT SINGLE * FROM zdepartments_t
    INTO gs_deptdisplay
    WHERE zdepartments_t~dept_id EQ gs_deptdisplay-dept_id.
    IF sy-subrc EQ 0.
      MESSAGE s003 WITH 'departman numarası'.
    ELSE.
      MESSAGE w002 WITH 'departman numarası'.
      CLEAR: gs_deptdisplay.
    ENDIF.
    CLEAR: gs_deptdisplay-dept_id.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .

  IF go_cont IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_cont
        rows    = 2
        columns = 1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui2.

    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_gui1
        rows    = 2
        columns = 2.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui_top.

    CALL METHOD go_splitter->set_row_height
      EXPORTING
        id     = 1
        height = 15.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 2
      RECEIVING
        container = go_gui_top2.

    CALL METHOD go_splitter->set_row_height
      EXPORTING
        id     = 1
        height = 15.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui3.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2
        column    = 2
      RECEIVING
        container = go_gui4.

    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_gui2
        rows    = 2
        columns = 1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui_top3.

    CALL METHOD go_splitter->set_row_height
      EXPORTING
        id     = 1
        height = 15.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui5.


    CREATE OBJECT go_docu
      EXPORTING
        style = 'ALV_GRID'.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_gui3.                 " Parent Container*

    CREATE OBJECT go_grid2
      EXPORTING
        i_parent = go_gui4.

    CREATE OBJECT go_grid3
      EXPORTING
        i_parent = go_gui5.


    CREATE OBJECT go_event_receiver.

    SET HANDLER go_event_receiver->handle_top_of_page FOR go_grid.
    SET HANDLER go_event_receiver->handle_onf4 FOR go_grid.
    SET HANDLER go_event_receiver->handle_toolbar FOR go_grid.
    SET HANDLER go_event_receiver->handle_user_command FOR go_grid.
    SET HANDLER go_event_receiver->handle_data_changed FOR go_grid.


    SET HANDLER go_event_receiver->handle_toolbar2 FOR go_grid2.
    SET HANDLER go_event_receiver->handle_user_command2 FOR go_grid2.
    SET HANDLER go_event_receiver->handle_data_changed2 FOR go_grid2.


    SET HANDLER go_event_receiver->handle_toolbar3 FOR go_grid3.
    SET HANDLER go_event_receiver->handle_user_command3 FOR go_grid3.
    SET HANDLER go_event_receiver->handle_data_changed3 FOR go_grid3.

    PERFORM set_dropdown.
    PERFORM register_f4.

    CALL METHOD go_grid->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout_emp
      CHANGING
        it_outtab       = gt_employees
        it_fieldcatalog = gt_fcat_emp.

    CALL METHOD go_grid2->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout_dep
      CHANGING
        it_outtab       = gt_departments
        it_fieldcatalog = gt_fcat_dep.

    CALL METHOD go_grid3->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout_lev
      CHANGING
        it_outtab       = gt_leaves
        it_fieldcatalog = gt_fcat_lev.

    CALL METHOD go_grid->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = go_docu.

    CALL METHOD go_grid2->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = go_docu.

    CALL METHOD go_grid3->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = go_docu.

    CALL METHOD go_grid->register_edit_event
      EXPORTING
*       i_event_id = cl_gui_alv_grid=>mc_evt_enter
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
    CALL METHOD go_grid2->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
    CALL METHOD go_grid3->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  ELSE.
    CALL METHOD go_grid->refresh_table_display.
    CALL METHOD go_grid2->refresh_table_display.
    CALL METHOD go_grid3->refresh_table_display.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data_alv .
  SELECT * FROM zemployees_t
    INTO CORRESPONDING FIELDS OF TABLE gt_employees.

  SELECT * FROM zdepartments_t
    INTO CORRESPONDING FIELDS OF TABLE gt_departments.

  SELECT * FROM zleaves_t
    INTO CORRESPONDING FIELDS OF TABLE gt_leaves.

  SELECT * FROM zroles_t
    INTO CORRESPONDING FIELDS OF TABLE gt_roles.

  SELECT * FROM zemployees_t AS e
    INNER JOIN zdepartments_t AS d ON e~emp_id EQ d~manager
    INNER JOIN zleaves_t AS l ON e~emp_id EQ l~emp_id
    INTO CORRESPONDING FIELDS OF TABLE gt_join.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FCAT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fcat_alv .
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZEMPLOYEES_T'
    CHANGING
      ct_fieldcat      = gt_fcat_emp.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZDEPARTMENTS_T'
    CHANGING
      ct_fieldcat      = gt_fcat_dep.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZLEAVES_T'
    CHANGING
      ct_fieldcat      = gt_fcat_lev.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZROLES_T'
    CHANGING
      ct_fieldcat      = gt_fcat_rol.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'ZPMS_JOIN_S'
    CHANGING
      ct_fieldcat      = gt_fcat_joi.

  LOOP AT gt_fcat_emp ASSIGNING <gfs_fcat_emp>.
    IF <gfs_fcat_emp>-fieldname EQ 'GENDER'.
      <gfs_fcat_emp>-edit     = abap_true.
      <gfs_fcat_emp>-drdn_hndl = 1.
    ENDIF.
    IF <gfs_fcat_emp>-fieldname EQ 'POSITIONS'.
      <gfs_fcat_emp>-f4availabl = abap_true.
    ENDIF.
    IF <gfs_fcat_emp>-fieldname EQ 'DEPARTMENT'.
      <gfs_fcat_emp>-f4availabl = abap_true.
    ENDIF.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout_alv .
  CLEAR: gs_layout_emp.
  gs_layout_emp-cwidth_opt = abap_true.
  gs_layout_emp-edit = abap_true.

  CLEAR: gs_layout_dep.
  gs_layout_dep-cwidth_opt = abap_true.
  gs_layout_dep-edit = abap_true.

  CLEAR: gs_layout_lev.
  gs_layout_lev-cwidth_opt = abap_true.
  gs_layout_lev-edit = abap_true.

  CLEAR: gs_layout_rol.
  gs_layout_rol-cwidth_opt = abap_true.
  gs_layout_rol-edit = abap_true.

  CLEAR: gs_layout_joi.
  gs_layout_joi-cwidth_opt = abap_true.
  gs_layout_joi-no_toolbar = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_DROPDOWN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .
  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'E'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value = 'K'.
  APPEND ls_dropdown TO lt_dropdown.

  go_grid->set_drop_down_table(
  EXPORTING
    it_drop_down       = lt_dropdown
    ).
ENDFORM.
*&---------------------------------------------------------------------*
*& Form REGISTER_F4
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM register_f4 .
  DATA: lt_f4 TYPE lvc_t_f4,
        ls_f4 TYPE lvc_s_f4.

  CLEAR: ls_f4.
  ls_f4-fieldname = 'DEPARTMENT'.
  ls_f4-register  = abap_true.
  APPEND ls_f4 TO lt_f4.

  CLEAR: ls_f4.
  ls_f4-fieldname = 'POSITIONS'.
  ls_f4-register  = abap_true.
  APPEND ls_f4 TO lt_f4.

  CALL METHOD go_grid->register_f4_for_fields
    EXPORTING
      it_f4 = lt_f4.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV2
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv2 .

  IF go_cont IS INITIAL.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV2'.

    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_cont
        rows    = 1
        columns = 2.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 2
      RECEIVING
        container = go_gui2.


    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_gui1
        rows    = 2
        columns = 1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1
        column    = 1
      RECEIVING
        container = go_gui_top.

    CALL METHOD go_splitter->set_row_height
      EXPORTING
        id     = 1
        height = 15.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2
        column    = 1
      RECEIVING
        container = go_gui4.

    CREATE OBJECT go_docu
      EXPORTING
        style = 'ALV_GRID'.

    CREATE OBJECT go_grid4
      EXPORTING
        i_parent = go_gui4.


    CREATE OBJECT go_event_receiver.

    SET HANDLER go_event_receiver->handle_top_of_page2 FOR go_grid4.


    CALL METHOD go_grid4->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout_joi
      CHANGING
        it_outtab       = gt_join
        it_fieldcatalog = gt_fcat_joi.

    CALL METHOD go_grid4->list_processing_events
      EXPORTING
        i_event_name = 'TOP_OF_PAGE'
        i_dyndoc_id  = go_docu.

    CALL METHOD go_grid4->register_edit_event
      EXPORTING
*       i_event_id = cl_gui_alv_grid=>mc_evt_enter
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  ELSE.
    CALL METHOD go_grid4->refresh_table_display.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_PDF_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_pdf_data .
  "Get smartform function module name
  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = 'ZPMS_SF'
    IMPORTING
      fm_name            = gv_fm_name
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.
  "Pass Printer related Parameters to Smartform
  wa_control_par-no_dialog = 'X'.     " It supresses the Printer dialog.
  wa_control_par-getotf    = 'X'.     " Get OTF data
*    wa_control_par-preview    = 'X'.     " Get OTF data
  wa_output_options-tddest = 'LP01'. " Set printer

  "Call Smartform
  CALL FUNCTION gv_fm_name
    EXPORTING
      control_parameters = wa_control_par
      output_options     = wa_output_options
      user_settings      = ' '
      it_join            = gt_join
      iv_username        = p_usrnme
    IMPORTING
      job_output_info    = wa_job_output_info
    EXCEPTIONS
      formatting_error   = 1
      internal_error     = 2
      send_error         = 3
      user_canceled      = 4
      OTHERS             = 5.
  IF sy-subrc <> 0.
  ELSE .
    it_otf_data = wa_job_output_info-otfdata.
    "Convert OTF data to PDF
    CALL FUNCTION 'CONVERT_OTF'
      EXPORTING
        format                = 'PDF'
      IMPORTING
        bin_filesize          = gv_bin_filesize
      TABLES
        otf                   = it_otf_data
        lines                 = it_pdf
      EXCEPTIONS
        err_max_linewidth     = 1
        err_format            = 2
        err_conv_not_possible = 3
        err_bad_otf           = 4
        OTHERS                = 5.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_PDF
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_pdf .
  LOOP AT it_pdf INTO wa_pdf.
    ASSIGN wa_pdf TO <fs_x> CASTING.
    CONCATENATE gv_content <fs_x> INTO gv_content IN BYTE MODE.
  ENDLOOP.

  "create PDF Viewer object
  CREATE OBJECT html_viewer
    EXPORTING
      parent = go_gui2.
  IF sy-subrc <> 0.
    "NO PDF viewwer
  ENDIF.

  "Convert xstring to binary table to pass to the LOAD_DATA method
  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = gv_content
    TABLES
      binary_tab = it_data.
  " Load the HTML
  CALL METHOD html_viewer->load_data(
    EXPORTING
      type                 = 'application'
      subtype              = 'pdf'
    IMPORTING
      assigned_url         = gv_url
    CHANGING
      data_table           = it_data
    EXCEPTIONS
      dp_invalid_parameter = 1
      dp_error_general     = 2
      cntl_error           = 3
      OTHERS               = 4 ).
  IF sy-subrc <> 0.
    WRITE:/ 'ERROR: CONTROL->LOAD_DATA'.
    EXIT.
  ENDIF.
  "Show it
  CALL METHOD html_viewer->show_url( url = gv_url in_place = 'X').
  IF sy-subrc <> 0.
    WRITE:/ 'ERROR: CONTROL->SHOW_DATA'.
    EXIT.
  ENDIF.
ENDFORM.
