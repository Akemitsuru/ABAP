*&---------------------------------------------------------------------*
*& Report ZLAT_ATIV002
*&---------------------------------------------------------------------*
*& Escreva um programa que a partir da entrada dos 9 primeiros dígitos de um CPF,
*& calcule o seu primeiro e o seu segundo dígito verificador. Em seguida,
*& apresente o CPF completo.
*&---------------------------------------------------------------------*
REPORT ZLAT_ATIV002.

PARAMETERS: PNUM(9)    TYPE C.

DATA: VDG10     TYPE C,  "VERIFICAR PRIMEIRO DÍGITO
      VDG11     TYPE C,  "VERIFICAR SEGUNDO DÍGITO
      LEN    TYPE i,  "CONTAR CARACTERES
      VCPF(12)  TYPE c,
      I         TYPE I,   "Andar na cadeia de caracteres do cpf
      M         TYPE I,   "Multiplica o caractere do cpf
      VSOMA     TYPE I,
      VCALC     TYPE I.

LEN = STRLEN( PNUM ).
vcpf = pnum.

*RETIRA TRAÇOS E PONTOS, SE HOUVER:
*REPLACE ALL OCCURRENCES OF '-' IN VCPF WITH ''.
*REPLACE ALL OCCURRENCES OF '.' IN VCPF WITH ''.
*REPLACE ALL OCCURRENCES OF '\n' IN VCPF WITH ''.
*REPLACE ALL OCCURRENCES OF '\a' IN VCPF WITH ''.
*REPLACE ALL OCCURRENCES OF '\t' IN VCPF WITH ''.
*REPLACE ALL OCCURRENCES OF ',' IN VCPF WITH ''.

*Retira Letras, espaço, pontuação e caraceteres unicode:
REPLACE ALL OCCURRENCES OF REGEX '[a-zA-Z[:space:][:punct:][:unicode:]]' IN vCpf WITH ''.
CONDENSE VCPF.
CONCATENATE '' VCPF INTO VCPF.
WRITE:/ 'vcpf', vcpf.

*VERIFICA, NOVAMENTE, SE O CPF CONTÉM 11 DÍGITOS NUMÉRICOS.
LEN = STRLEN( VCPF ).
WRITE: / 'NÚMERO DIGITADO: ', PNUM, ", 'len ', len,
       / .

IF LEN > 9.
  WRITE:/ 'VERIFIQUE O CPF DIGITADO, POIS POSSUI MAIS DO QUE 9 DÍGITOS!'.
  STOP.
ELSEIF LEN < 9.
  WRITE:/ 'CPF COM MENOS DO QUE 9 DÍGITOS!'.
  STOP.
ELSEIF LEN = 9. "SE TIVER 9 DÍGITOS, VERIFICA SE É FALSO POSITIVO (DÍGITOS IGUAIS).
  CASE VCPF.
    WHEN '000000000' OR '111111111' OR '222222222' OR '333333333' OR '444444444' OR '555555555' OR
      '666666666' OR '777777777' OR '888888888' OR '999999999'.
      WRITE:/ 'CPF INVÁLIDO (NÚMEROS IGUAIS)!'.
      STOP.
  ENDCASE.
ENDIF.

*CASO TENHA PASSADO DAS ETAPAS ANTERIORES, FAZ A VALIDAÇÀO.
I = 0.
M = 10.
VSOMA = 0.
vdg10 = 0.
DO 9 TIMES.
  VCALC = VCPF+I(1).
  VSOMA = ( VCALC * M ) + VSOMA.
  I = I + 1.
  M = M - 1.
ENDDO.
VCALC = ( VSOMA * 10 ).
WRITE:/ ' VSOMA=', VSOMA, 'VCALC: ', VCALC.

TRY.
  VDG10 =  VCALC MOD 11.
  IF VDG10 = '*'.
    VDG10 = 0.
  ENDIF.
CATCH CX_SY_CONVERSION_NO_NUMBER.
  VDG10 = 0.
ENDTRY.

*WRITE:/ 'VDG10=', VDG10.
CONCATENATE VCPF VDG10 INTO VCPF.
*WRITE:/ VCPF.

I = 0.
M = 11.
VCALC = 0.
VSOMA = 0.
  DO 10 TIMES.
    VCALC = VCPF+I(1).
    VSOMA = ( VCALC * M ) + VSOMA.
    I = I + 1.
    M = M - 1.
  ENDDO.
VCALC = ( VSOMA * 10 ).
TRY.
  VDG11 =  VCALC MOD 11.
CATCH CX_SY_CONVERSION_NO_NUMBER.
  VDG11 = 0.
ENDTRY.

WRITE:/ 'O novo CPF é ', pnum+0(3), '.', pnum+3(3), '.', pnum+6(3), '-', vdg10, vdg11.
