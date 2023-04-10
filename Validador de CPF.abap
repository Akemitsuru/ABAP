*&---------------------------------------------------------------------*
*& Report ZLAT_ATIV001
*&---------------------------------------------------------------------*
*& Pode ser utilizado com ou sem pontos, traços. Verifica se tem dígitos
*& suficientes e retorna o aviso, caso não esteja dentro dos conformes.
*&---------------------------------------------------------------------*
REPORT ZLAT_ATIV001.
*Escreva um programa que faça a validação de um CPF informado pelo usuário
*e informe ao final se o CPF é válido ou não.

*Os CPF's com todos os números iguais (11111111111, 22222222222, ..., 99999999999)
*devem ser considerados inválidos, apesar de serem considerados válidos pela regra
*de validação do CPF.

*Ao final, o programa deve apresentar uma das seguintes mensagens: "CPF válido!",
*"CPF inválido!" ou "CPF inválido (números iguais)!"

PARAMETERS: PNUM(14)    TYPE C.

DATA: VDG10     TYPE C,  "VERIFICAR PRIMEIRO DÍGITO
      VDG11     TYPE C,  "VERIFICAR SEGUNDO DÍGITO
      LEN    TYPE i,  "CONTAR CARACTERES
      VCPF(14)  TYPE c,
      I         TYPE I,   "Andar na cadeia de caracteres do cpf
      M         TYPE I,   "Multiplica o caractere do cpf
      VSOMA     TYPE I,
      VCALC     TYPE I.

LEN = STRLEN( PNUM ).
vcpf = pnum.

*Retira Letras, espaço, pontuação e caraceteres unicode:
REPLACE ALL OCCURRENCES OF REGEX '[a-zA-Z[:space:][:punct:][:unicode:]]' IN vCpf WITH ''.
CONDENSE VCPF.
CONCATENATE '' VCPF INTO VCPF.
*WRITE:/ 'vcpf', vcpf.

*VERIFICA, NOVAMENTE, SE O CPF CONTÉM 11 DÍGITOS NUMÉRICOS.
LEN = STRLEN( VCPF ).
WRITE: / 'CPF DIGITADO: ', PNUM, "'len ', len,
       / .

IF LEN > 11.
  WRITE:/ 'VERIFIQUE O CPF DIGITADO, POIS POSSUI MAIS DO QUE 11 DÍGITOS!'.
  STOP.
ELSEIF LEN < 11.
  WRITE:/ 'CPF COM MENOS DO QUE 11 DÍGITOS!'.
  STOP.
ELSEIF LEN = 11. "SE TIVER 11 DÍGITOS, VERIFICA SE É FALSO POSITIVO (DÍGITOS IGUAIS).
  CASE VCPF.
    WHEN '00000000000' OR '11111111111' OR '22222222222' OR '33333333333' OR '44444444444' OR '55555555555' OR
      '66666666666' OR '77777777777' OR '88888888888' OR '99999999999'.
      WRITE:/ 'CPF INVÁLIDO (NÚMEROS IGUAIS)!'.
      STOP.
  ENDCASE.
ENDIF.


*CASO TENHA PASSADO DAS ETAPAS ANTERIORES, FAZ A VALIDAÇÀO.
I = 0.
M = 10.
VSOMA = 0.
DO 9 TIMES.
  VDG10 = VCPF+I(1).
  VSOMA = ( VDG10 * M ) + VSOMA.
  "WRITE:/ ' VSOMA=', VSOMA.
  I = I + 1.
  M = M - 1.
ENDDO.

VCALC = ( VSOMA * 10 ) MOD 11.

*WRITE:/ 'VSOMA ', VSOMA, ' VCALC ', VCALC.
VDG10 = VCPF+9(1).
*WRITE:/ ' VDG10=', VDG10.

IF VDG10 = VCALC.
  I = 0.
  M = 11.
  VSOMA = 0.
  VCALC = 0.
  DO 10 TIMES.
    VDG11 = VCPF+I(1).
    VSOMA = ( VDG11 * M ) + VSOMA.
    "WRITE:/ ' VSOMA=', VSOMA.
    I = I + 1.
    M = M - 1.
  ENDDO.

  VCALC = ( VSOMA * 10 ) MOD 11.
  "WRITE:/ 'VSOMA ', VSOMA, ' VCALC ', VCALC.
  VDG11 = VCPF+10(1).

  "WRITE:/ VCALC, ' VDG11=', VDG11.

  IF VCALC = VDG11.
     WRITE:/ 'CPF ', PNUM, 'É VÁLIDO!'.
  ENDIF.

ELSE.
  WRITE:/ 'CPF ', PNUM, ' É INVÁLIDO!'.
  STOP.
ENDIF.
