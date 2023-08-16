*&---------------------------------------------------------------------*
*& Include          ZPMSPROGRAM_TOP
*&---------------------------------------------------------------------*
CLASS cl_event_receiver DEFINITION DEFERRED.
DATA: go_event_receiver TYPE REF TO cl_event_receiver.

DATA: go_grid  TYPE REF TO cl_gui_alv_grid,
      go_grid2 TYPE REF TO cl_gui_alv_grid,
      go_grid3 TYPE REF TO cl_gui_alv_grid,
      go_grid4 TYPE REF TO cl_gui_alv_grid,
      go_cont  TYPE REF TO cl_gui_custom_container.

DATA: go_docu TYPE REF TO cl_dd_document.

DATA: go_splitter TYPE REF TO cl_gui_splitter_container,
      go_gui1     TYPE REF TO cl_gui_container,
      go_gui2     TYPE REF TO cl_gui_container,
      go_gui3     TYPE REF TO cl_gui_container,
      go_gui4     TYPE REF TO cl_gui_container,
      go_gui5     TYPE REF TO cl_gui_container,
      go_gui_top  TYPE REF TO cl_gui_container,
      go_gui_top2 TYPE REF TO cl_gui_container,
      go_gui_top3 TYPE REF TO cl_gui_container.

DATA: ok_code_0100 TYPE sy-ucomm,
      ok_code_0200 TYPE sy-ucomm,
      ok_code_0101 TYPE sy-ucomm,
      ok_code_0102 TYPE sy-ucomm.

CONTROLS tb_id TYPE TABSTRIP.

DATA: gt_users TYPE TABLE OF zusers_t,
      gs_users TYPE zusers_t.

TYPES: BEGIN OF gty_userrol_t,
         username  TYPE  zusername_de,
         password  TYPE  zpassword_de,
         role_name TYPE zrolename_de,
       END OF gty_userrol_t.

TYPES: BEGIN OF gty_employees_t,
         emp_id     TYPE zempid_de,
         first_name TYPE zfirstname_de,
         last_name  TYPE zlastname_de,
         birthdate  TYPE zbirthdate_de,
         gender     TYPE zgender_de,
         department TYPE zdepartment_de,
         positions  TYPE zposition_de,
         dd_handle  TYPE int4,
       END OF gty_employees_t.

TYPES: BEGIN OF gty_departments_t,
         dept_id   TYPE zdeptid_de,
         dept_name TYPE zdeptname_de,
         manager   TYPE zmanager_de,
         location  TYPE zlocation_de,
       END OF gty_departments_t.

TYPES: BEGIN OF gty_leaves_t,
         leave_id   TYPE  zleaveid_de,
         emp_id     TYPE  zempid_de,
         leave_type TYPE  zleavetype_de,
         start_date TYPE  zstartdate_de,
         end_date   TYPE  zenddate_de,
         reason     TYPE  zreason_de,
       END OF gty_leaves_t.

TYPES: BEGIN OF gty_roles_t,
         role_id   TYPE zroleid_de,
         role_name TYPE   zrolename_de,
       END OF gty_roles_t.

TYPES : BEGIN OF gty_join_t,
          emp_id     TYPE zempid_de,
          first_name TYPE zfirstname_de,
          last_name  TYPE zlastname_de,
          birthdate  TYPE zbirthdate_de,
          gender     TYPE zgender_de,
          positions  TYPE zposition_de,
          dept_name  TYPE zdeptname_de,
          location   TYPE zlocation_de,
          leave_type TYPE  zleavetype_de,
          start_date TYPE  zstartdate_de,
          end_date   TYPE  zenddate_de,
          reason     TYPE  zreason_de,
        END OF gty_join_t.

DATA: gt_join TYPE TABLE OF gty_join_t.

DATA: gs_employees   TYPE gty_employees_t,
      gt_employees   TYPE TABLE OF gty_employees_t,
      gs_empdisplay  TYPE zemployees_t,
      gt_empdisplay  TYPE TABLE OF zemployees_t,
      gs_departments TYPE  gty_departments_t,
      gt_departments TYPE TABLE OF gty_departments_t,
      gt_leaves      TYPE TABLE OF gty_leaves_t,
      gs_leaves      TYPE  gty_leaves_t,
      gt_roles       TYPE TABLE OF gty_roles_t,
      gs_roles       TYPE  gty_roles_t,
      gs_deptdisplay TYPE  zdepartments_t,
      gt_deptdisplay TYPE TABLE OF zdepartments_t,
      gs_userrol     TYPE gty_userrol_t.

* personel datası
DATA: gv_emp_id     TYPE  zempid_de,
      gv_first_name TYPE  zfirstname_de,
      gv_last_name  TYPE  zlastname_de,
      gv_birthdate  TYPE  zbirthdate_de,
      gv_genderrad1 TYPE  char1,
      gv_genderrad2 TYPE  char1,
      gv_department TYPE  zdepartment_de,
      gv_positions  TYPE  zposition_de.

*departman datası
DATA: gv_dept_id   TYPE zdeptid_de,
      gv_dept_name TYPE zdeptname_de,
      gv_manager   TYPE zmanager_de,
      gv_location  TYPE zlocation_de.


DATA: gt_fcat_emp   TYPE lvc_t_fcat,
      gt_fcat_dep   TYPE lvc_t_fcat,
      gt_fcat_rol   TYPE lvc_t_fcat,
      gt_fcat_lev   TYPE lvc_t_fcat,
      gt_fcat_joi   TYPE lvc_t_fcat,
      gs_fcat_emp   TYPE lvc_s_fcat,
      gs_fcat_dep   TYPE lvc_s_fcat,
      gs_fcat_rol   TYPE lvc_s_fcat,
      gs_fcat_lev   TYPE lvc_s_fcat,
      gs_layout_emp TYPE lvc_s_layo,
      gs_layout_dep TYPE lvc_s_layo,
      gs_layout_rol TYPE lvc_s_layo,
      gs_layout_lev TYPE lvc_s_layo,
      gs_layout_joi TYPE lvc_s_layo.
"""""

DATA: gv_rbpersk TYPE xfeld,
      gv_rbdeptk TYPE xfeld,
      gv_rbpersg TYPE xfeld,
      gv_rbdeptg TYPE xfeld.

gv_rbpersk = abap_true.
gv_rbdeptk = abap_false.
gv_rbpersg = abap_true.
gv_rbdeptg = abap_false.

FIELD-SYMBOLS: <gfs_fcat_emp>  TYPE lvc_s_fcat,
               <gfs_employees> TYPE gty_employees_t.


"smartforms
DATA:     html_viewer         TYPE REF TO cl_gui_html_viewer.
TYPES :
  ty_control_par     TYPE ssfctrlop,
  ty_output_options  TYPE ssfcompop,
  ty_job_output_info TYPE ssfcrescl,
  ty_otf_data        TYPE itcoo,
  ty_pdf             TYPE tline.

DATA:
  wa_control_par     TYPE ty_control_par,
  wa_output_options  TYPE ty_output_options,
  wa_job_output_info TYPE ty_job_output_info,
  wa_pdf             TYPE ty_pdf.

DATA:
  it_otf_data TYPE STANDARD TABLE OF ty_otf_data,
  it_pdf      TYPE STANDARD TABLE OF ty_pdf,
  it_data     TYPE STANDARD TABLE OF x255.
DATA:
  gv_fm_name      TYPE  rs38l_fnam,
  gv_url          TYPE char255,
  gv_content      TYPE xstring,
  okcode          TYPE sy-ucomm,
  gv_bin_filesize TYPE i.

FIELD-SYMBOLS <fs_x> TYPE x.

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_usrnme TYPE zusername_de,
            p_paswrd TYPE zpassword_de.
SELECTION-SCREEN END OF BLOCK block1.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF screen-name = 'P_PASWRD'.
      screen-invisible = 1.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.
