REPORT ZLAT_EX001 NO STANDARD PAGE HEADING.

PARAMETERS: pNome_a(40) TYPE c, "C para poder definir tamanho da cadeia de caracteres
            pAno_a(4)   TYPE n, "N para definir a quantidade de dígitos numéricos
            pNome_b(40) TYPE c,
            pAno_b(4)   TYPE n
            .

DATA: vIdade_a(3) TYPE N, "Definir tamanho do resultado para não dar erro
      vIdade_b(3) TYPE N,
      vMedia(4)   TYPE P decimals 2.

vIdade_a = sy-datum(4) -  pAno_a.
vIdade_b = sy-datum(4) -  pAno_b.
vMedia = ( vIdade_a + VIDADE_B ) / 2.

WRITE:/ 'Sr(a). ', pNome_a,
      / 'Tem ', vIdade_a, ' anos.',
      / 'Sr(a). ', pNome_b,
      / 'Tem ', vIdade_b, ' anos.',
      / 'A idade média de ', pNome_a, ' e ', pNome_b, ' é de ', vMedia, ' anos.'
      .

uline.  " Para imprimir uma linha

*--------------------------------------------------------------------------
*CÁLCULO IMC

data: v_imc type p decimals 2.

parameters: p_peso type p decimals 2, " Decimals 2 = 2 casas decimais após a vírgula
            p_altu type p decimals 2.

v_imc = p_peso / ( p_altu * p_altu ).

if v_imc < '17'. 
  write:/ 'O IMC é', v_imc, 'e a situação é "Muito abaixo do peso"'.

elseif v_imc >= '17' and v_imc < '18.5'. "Para utilizar decimais, deve-se utilizar o PONTO e colocá-lo entre aspas simples
  write:/ 'O IMC é', v_imc, 'e a situação é "Abaixo peso"'.

elseif v_imc >= '18.5' and v_imc < '25.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Peso normal"'.

elseif v_imc >= '25.0' and v_imc < '30.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Acima do peso"'.

elseif v_imc >= '30.0' and v_imc < '35.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade I"'.

elseif v_imc >= '35.0' and v_imc < '40.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade II (severa)"'.

elseif v_imc >= '40.0'.
  write:/ 'O IMC é', v_imc, 'e a situação é "Obesidade III (mórbida)"'.

endif.

uline.

*--------------------------------------------------------------------------

*Calcular desconto ou acréscimo conforme valor de parcelas e da compra

REPORT ZLAT_EX002 NO STANDARD PAGE HEADING.

DATA: vPerD TYPE p Decimals 2, "Valor percentual do Desconto/ Acréscimo
      vPerc TYPE i, "Valor em porcentagem para visualização
      vDesc TYPE i, "Valor do Desconto ou Ácréscimo
      vTipo TYPE String, "Se é Desconto ou Acréscimo
      vValF Type p DECIMALS 2. "Valor Final com desconto/acréscimo

PARAMETERS: pValor(8)  TYPE p DECIMALS 2, "Valor do produto
            pParce     TYPE i. "Quantidade de Parcelas
ULINE.

IF pValor <= 100 AND pParce = 1.
  vPerD = '-0.15'.
  vTipo = 'Desconto'.

ELSEIF pValor > 100 AND pParce = 1.
  vPerD = '-0.20'.
  vTipo = 'Desconto'.

ELSEIF pValor <= 100 AND pParce <= 3.
  vPerD = '-0.05'.
  vTipo = 'Desconto'.

ELSEIF pValor > 100 AND pParce  <= 3.
  vPerD = '-0.1'.
  vTipo = 'Desconto'.

ELSEIF pParce > 3.
  vPerD = '0.1'.
  vTipo = 'Acréscimo'.
ENDIF.

vPerc = vPerD * 100.
vDesc = pValor * vPerD.
vValF = pValor + vDesc.

WRITE:/ 'Valor Original = R$', pValor,
      / 'Qtde. Parcelas = ', pParce,
      / 'Percentual de ', vTipo, ' = ', vPerc, '%',
      / 'Valor do ', vTipo, ' = ', vDesc,
      / 'Valor Final = R$', vValF.

ULINE.

*-----------------------------------------------------------------------------------------

*Calculadora Simples, tratamento de erro e introdução à Classe de mensagem

REPORT ZLAT_EX003 MESSAGE-ID ZLAT_C001.

PARAMETERS: pNum1 TYPE i,
            pNum2 TYPE i,
            pSoma RADIOBUTTON GROUP GR1,
            pSubt RADIOBUTTON GROUP Gr1,
            pMult RADIOBUTTON GROUP gr1,
            pDivi RADIOBUTTON GROUP gr1.

DATA: vTotal TYPE p DECIMALS 2.

IF pSoma = 'X'.
  vTotal = pNum1 + pNum2.

ELSEIF pSubt = 'X'.
  vTotal = pNum1 - pNum2.

ELSEIF pMult = 'X'.
  vTotal = pNum1 * pNum2.

ELSEIF pDivi = 'X'.
  TRY.
    vTotal = pNum1 / pNum2.
  CATCH CX_SY_ZERODIVIDE. "Erro copiado da transação ST22 (de tratamento de erros)
*    MESSAGE 'DIVISÃO POR 0 (ZERO) NÃO PERMITIDA.' TYPE 'I'. "Mensagem do tipo INFORMAÇÃO, por isso o I é maiúsculo
  MESSAGE I000. "I= tipo de mensagem Informação, 000 Número da classe de mensagem = DIVISÃO POR 0 (ZERO) NÃO PERMITIDA
  ENDTRY.
  STOP. "Encerra o programa e reinicia (tela inicial do programa)
ENDIF.

WRITE:/ 'Resultado: ', vTotal.

uline.

*---------------------------------------------------------------------------------------------

REPORT ZLAT_EX007.
* Área Retângulo, Perímetro e Raiz Quadrada.

DATA: vArea   TYPE P DECIMALS 4,
      vPeri   type p DECIMALS 4,
      vCate   TYPE p DECIMALS 4,
      vDiag   TYPE p DECIMALS 4
      .

PARAMETERS: pBase   TYPE p DECIMALs 4,
            pAltu   TYPE p DECIMALS 4.

vArea = pBase * pAltu.
vPeri = ( pBase + pAltu ) * 2.
vCate = ( ( pBase * pBase ) + ( pAltu * pAltu ) ).
vDiag = sqrt( vCate ).  "Função SQRT() tem que ser escrita sem espaço

WRITE:/ 'Área do Retângulo: ', vArea,
      / 'Perímetro: ', vPeri,
      / 'Diagonal: ', vDiag.

uline.

*----------------------------------------------------------------------------------------------
* OPERADORES DE IGUALDADE E COMPARAÇÃO:
*----------------------------------------------------------------------------------------------
* EQ | =
* NE | <> ou ><
* GT | >
* LT | <
* GE | >=
* LE | <=
* AND = e
* OR = ou
* NOT = Negação
*----------------------------------------------------------------------------------------------



