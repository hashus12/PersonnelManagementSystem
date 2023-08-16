*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZDEPARTMENTS_T..................................*
DATA:  BEGIN OF STATUS_ZDEPARTMENTS_T                .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZDEPARTMENTS_T                .
CONTROLS: TCTRL_ZDEPARTMENTS_T
            TYPE TABLEVIEW USING SCREEN '0003'.
*...processing: ZEMPLOYEES_T....................................*
DATA:  BEGIN OF STATUS_ZEMPLOYEES_T                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZEMPLOYEES_T                  .
CONTROLS: TCTRL_ZEMPLOYEES_T
            TYPE TABLEVIEW USING SCREEN '0002'.
*...processing: ZLEAVES_T.......................................*
DATA:  BEGIN OF STATUS_ZLEAVES_T                     .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZLEAVES_T                     .
CONTROLS: TCTRL_ZLEAVES_T
            TYPE TABLEVIEW USING SCREEN '0005'.
*...processing: ZROLES_T........................................*
DATA:  BEGIN OF STATUS_ZROLES_T                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZROLES_T                      .
CONTROLS: TCTRL_ZROLES_T
            TYPE TABLEVIEW USING SCREEN '0004'.
*...processing: ZUSERS_T........................................*
DATA:  BEGIN OF STATUS_ZUSERS_T                      .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUSERS_T                      .
CONTROLS: TCTRL_ZUSERS_T
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZDEPARTMENTS_T                .
TABLES: *ZEMPLOYEES_T                  .
TABLES: *ZLEAVES_T                     .
TABLES: *ZROLES_T                      .
TABLES: *ZUSERS_T                      .
TABLES: ZDEPARTMENTS_T                 .
TABLES: ZEMPLOYEES_T                   .
TABLES: ZLEAVES_T                      .
TABLES: ZROLES_T                       .
TABLES: ZUSERS_T                       .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
