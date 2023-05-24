*&---------------------------------------------------------------------*
*& Report ZATSR0016
*&---------------------------------------------------------------------*
*& UPDATE
*&---------------------------------------------------------------------*
REPORT zatsr0016.

* TIPOS
TYPES: BEGIN OF ty_txt,
         nup(25)     TYPE c,
         autor(15)   TYPE c,
         resumo(256) TYPE c,
       END OF ty_txt.

TYPES: BEGIN OF ty_csv,
         line(500) TYPE c,
       END OF ty_csv.

*TABELAS INTERNAS
DATA: t_txt TYPE TABLE OF ty_txt,
      t_csv TYPE TABLE OF ty_csv.

* WORK AREA
DATA: w_txt TYPE ty_txt,
      w_csv TYPE ty_csv.

* TELA DE SELEÇÃO
PARAMETERS: p_file TYPE localfile,
            p_csv  RADIOBUTTON GROUP gr1,
            p_txt  RADIOBUTTON GROUP gr1.

* EVENTO SERÁ ATIVADO AO CLICAR NO PARÂMETRO P_FILE.
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.
  PERFORM f_seleciona_arquivo.

START-OF-SELECTION.
  PERFORM f_upload.
  PERFORM f_imprime_dados.

*&---------------------------------------------------------------------*
*& Form f_seleciona_arquivo
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM f_seleciona_arquivo .

*DATA PROGRAM_NAME  TYPE SY-REPID.
*DATA DYNPRO_NUMBER TYPE SY-DYNNR.
*DATA FILE_NAME     TYPE RLGRAP-FILENAME.
*DATA LOCATION_FLAG TYPE DXFIELDS-LOCATION.

  CALL FUNCTION 'KD_GET_FILENAME_ON_F4'   "Função usada para seleção de arquivo.
    EXPORTING
*     PROGRAM_NAME  = SYST-REPID
*     DYNPRO_NUMBER = SYST-DYNNR
      field_name    = p_file
*     STATIC        = ' '
*     MASK          = ' '
*     FILEOPERATION = 'R'
*     PATH          = PATH
    CHANGING
      file_name     = p_file
*     LOCATION_FLAG = 'P'
    EXCEPTIONS
      mask_too_long = 1.

  IF sy-subrc <> 0.
    MESSAGE TEXT-001 TYPE 'I'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
FORM f_upload .

  DATA vl_filename TYPE string.
  FIELD-SYMBOLS <fs_tabela> TYPE STANDARD TABLE.
*  FIELD-SYMBOLS: Uma variável decladara como FIELD-SYMBOL não armazena fisicamente um valor, apenas
*                 possui referência ao endereó de memória de uma variável. Toda modificação feita no
*                 símbolo é realizada na variável que está sendo referenciada. Ganha-se flexibilidade
*                 e desempenho na manipulação de alguns
  vl_filename = p_file.

  IF p_txt = 'X'.
    ASSIGN t_txt TO <fs_tabela>.
*     Atribui o endereço da variável 't_txt' a <fs_tabela>. A partir de agora, toda operação reali-
*     zada no símbolo será replicada para a variável e vice-versa. Isso será válido até que a refe-
*     rência seja desfeita usando a instrução UNASSIGN.
  ELSE.
    ASSIGN t_csv TO <fs_tabela>.
  ENDIF.

*DATA FILENAME            TYPE STRING.
*DATA FILETYPE            TYPE CHAR10.
*DATA HAS_FIELD_SEPARATOR TYPE CHAR01.
*DATA HEADER_LENGTH       TYPE I.
*DATA READ_BY_LINE        TYPE CHAR01.
*DATA DAT_MODE            TYPE CHAR01.
*DATA CODEPAGE            TYPE ABAP_ENCODING.
*DATA IGNORE_CERR         TYPE ABAP_BOOL.
*DATA REPLACEMENT         TYPE ABAP_REPL.
*DATA CHECK_BOM           TYPE CHAR01.
*DATA VIRUS_SCAN_PROFILE  TYPE VSCAN_PROFILE.
*DATA NO_AUTH_CHECK       TYPE CHAR01.
*DATA FILELENGTH          TYPE I.
*DATA HEADER              TYPE XSTRING.
*DATA ISSCANPERFORMED     TYPE CHAR01.

  CALL FUNCTION 'GUI_UPLOAD'    "PEGA OS DADOS DO ARQUIVO E CARREGA PARA UMA ITAB.
    EXPORTING
      filename                = vl_filename
      filetype                = 'ASC'
*     HAS_FIELD_SEPARATOR     = ''
*     HEADER_LENGTH           = 0
*     READ_BY_LINE            = 'X'
*     DAT_MODE                = ' '
*     CODEPAGE                = ' '
*     IGNORE_CERR             = ABAP_TRUE
      replacement             = ''
*     CHECK_BOM               = ' '
*     VIRUS_SCAN_PROFILE      = VIRUS_SCAN_PROFILE
*     NO_AUTH_CHECK           = ' '
* IMPORTING
*     FILELENGTH              = FILELENGTH
*     HEADER                  = HEADER
    TABLES
      data_tab                = <fs_tabela>
* CHANGING
*     ISSCANPERFORMED         = ' '
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16.

  IF sy-subrc <> 0.
    MESSAGE TEXT-001 TYPE 'I'.    "NENHUM
  ENDIF.
IF p_csv = 'X'.
  LOOP AT <fs_tabela> INTO w_csv.
    SPLIT w_csv at ';' INTO w_txt-nup w_txt-autor w_txt-resumo.
*    Vai separar os campos pelo separador ';' já usando os nomes já designados no txt.
    APPEND w_txt to t_txt.
    ENDLOOP.
ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
FORM f_imprime_dados .

  LOOP AT t_txt INTO w_txt.
    WRITE:/ w_txt-nup, w_txt-autor, w_txt-resumo.
  ENDLOOP.
ENDFORM.
