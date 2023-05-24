*&---------------------------------------------------------------------*
*& Report ZATSR0017
*&---------------------------------------------------------------------*
*& DOWNLOAD
*&---------------------------------------------------------------------*
REPORT zatsr0017.

* TABELA INTERNA
DATA: t_zatst0001 TYPE TABLE OF zatst0001 WITH HEADER LINE.

* TELA DE SELEÇÃO
PARAMETERS: p_file TYPE localfile.

START-OF-SELECTION.
  PERFORM f_seleciona_dados.
  PERFORM f_download.

*&---------------------------------------------------------------------*
*& Form F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleciona_dados .

  SELECT * FROM zatst0001 INTO TABLE t_zatst0001.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form F_DOWNLOAD
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_download .
  DATA: vl_filename TYPE string.
  vl_filename = p_file.

*DATA BIN_FILESIZE              TYPE I.
*DATA FILENAME                  TYPE STRING.
*DATA FILETYPE                  TYPE CHAR10.
*DATA APPEND                    TYPE CHAR01.
*DATA WRITE_FIELD_SEPARATOR     TYPE CHAR01.
*DATA HEADER                    TYPE XSTRING.
*DATA TRUNC_TRAILING_BLANKS     TYPE CHAR01.
*DATA WRITE_LF                  TYPE CHAR01.
*DATA COL_SELECT                TYPE CHAR01.
*DATA COL_SELECT_MASK           TYPE CHAR255.
*DATA DAT_MODE                  TYPE CHAR01.
*DATA CONFIRM_OVERWRITE         TYPE CHAR01.
*DATA NO_AUTH_CHECK             TYPE CHAR01.
*DATA CODEPAGE                  TYPE ABAP_ENCODING.
*DATA IGNORE_CERR               TYPE ABAP_BOOL.
*DATA REPLACEMENT               TYPE ABAP_REPL.
*DATA WRITE_BOM                 TYPE ABAP_BOOL.
*DATA TRUNC_TRAILING_BLANKS_EOL TYPE CHAR01.
*DATA FILELENGTH                TYPE I.

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
*     BIN_FILESIZE            = BIN_FILESIZE
      filename                = vl_filename
      filetype                = 'ASC'
*     APPEND                  = ' '
*     WRITE_FIELD_SEPARATOR   = ' '
*     HEADER                  = '00'
*     TRUNC_TRAILING_BLANKS   = ' '
*     WRITE_LF                = 'X'
*     COL_SELECT              = ' '
*     COL_SELECT_MASK         = ' '
*     DAT_MODE                = ' '
*     CONFIRM_OVERWRITE       = ' '
*     NO_AUTH_CHECK           = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
*     REPLACEMENT             = '#'
*     WRITE_BOM               = ' '
*     TRUNC_TRAILING_BLANKS_EOL       = 'X'
*     WK1_N_FORMAT            = ' '
*     WK1_N_SIZE              = ' '
*     WK1_T_FORMAT            = ' '
*     WK1_T_SIZE              = ' '
*     WRITE_LF_AFTER_LAST_LINE        = ABAP_TRUE
*     SHOW_TRANSFER_STATUS    = ABAP_TRUE
*     VIRUS_SCAN_PROFILE      = '/SCET/GUI_DOWNLOAD'
* IMPORTING
*     FILELENGTH              = FILELENGTH
    TABLES
      data_tab                = t_zatst0001
*     FIELDNAMES              = FIELDNAMES
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21.

IF SY-SUBRC = 0.


ENDIF.

ENDFORM.
