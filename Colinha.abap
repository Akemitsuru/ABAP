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
*-------------------------------------------------------------------------------------------------

*&---------------------------------------------------------------------*
*& Report ZATSR0007
*&---------------------------------------------------------------------*
*& PROGRAMAÇÃO II
*&---------------------------------------------------------------------*
REPORT ZATSR0007.
*--------------------------------------------------------------------------------------------------
* DECLARAÇÃO DE TIPOS (TYPES):
*--------------------------------------------------------------------------------------------------
* COM ESSE COMANDO É POSSÍVEL DECLARAR TIPOS QUE PODEM SER UTILIZADOS PARA DECLARAÇÕES DE ESTRUTURAS
* (WORK AREA) E TABELAS INTERNAS.
* TODOSO OS TIPOS DECLARADOS VIA COMANDO SÃO LOCAIS.
* PARA CRIAÇÃO DE TIPOS GLOBAIS, É NECESSÁRIO SER FEITO PELA TRANSAÇÃO SE11 > TIPO DADOS > ESTRUTURA.

TYPES: BEGIN OF TY_MATERIAL,
       CODMAT(10) TYPE C,
       DESCRI(35) TYPE C,
END OF TY_MATERIAL.

*--------------------------------------------------------------------------------------------------
* DECLARAÇÃO DE ESTRUTURAS (WORK AREA):
*--------------------------------------------------------------------------------------------------
* ESTRUTURA É UMA VARIÁVEL QUE ARMAZENA VÁRIAS VARIÁVEIS E TEM TAMANHO FIXO (ARRAY UNIDIMENSIONAL),
* SÃO UTILIZADAS PARA ARMAZENAR INFORMAÇÕES EM TEMPO DE EXECUÇÃO.
* É POSSÍVEL DECLARAR DE DUAS FORMAS:
* A) FAZENDO A DECLARAÇÃO DE TIPOS E, DEPOIS, CRIANDO A ESTRUTURA:
DATA W_MATERIAL TYPE TY_MATERIAL. " Neste caso, utilizamos a declaração acima (TY_MATERIAL).

* B) DECLARANDO A ESTRUTURA E O TIPO DE UMA ÚNICA VEZ:
DATA: BEGIN OF W_CLIENTE,
   CODCLI(10) TYPE C,
   NOME(35)   TYPE C,
END OF W_CLIENTE.

*--------------------------------------------------------------------------------------------------
* TABELA INTERNA: É UTILIZADA PARA ARMAZENAR INFORMAÇÕES EM TEMPO DE EXECUÇÃO;
*--------------------------------------------------------------------------------------------------
* SE PARECEM MUITO COM ESTRUTURAS, PORÉM, PODEM VARIAR SEU TAMANHO (LINHAS).
* TAMBÉM PODERIAM SER CHAMADAS DE "TABELAS TEMPORÁRIAS", MAS ESTE TERMO NÃO É USADO NO ABAP.

* A INCLUSÃO DE INFORMAÇÕES É FEITO LINHA A LINHA, UTILIZANDO UMA WORK AREA COMO INTERFACE PARA
* TRANSFERIR OS DADOS. A WORK AREA TEM A MESMA FORMA DA SUA TABELA INTERNA (MESMAS INFORMAÇÕES/COLUNAS)

* STANDART TABLE: É A TABELA MAIS UTILIZADA E OS REGISTROS SÃO ARMAZENADOS NA ORDEM EM QUE
* FOREM SENDO INSERIDOS NELA.

* SORTED TABLE: É OBRIGATÓRIO INFORMAR UMA CHAVE, POIS É POR MEIO DELA QUE O ABAP FARÁ A ORDENAÇÃO DOS
* REGISTROS INSERIDOS NA TABELA. A DIFERENÇA É QUE A CHAVE PODE SER ÚNICA OU NÃO-ÚNICA, ENQUANTO QUE
* NA STANDART TABLE É ACEITA APENAS CHAVES NÃO-ÚNICAS.

* HASHED TABLE: É OBRIGATÓRIO O USO DE CHAVE ÚNICA, POIS É POR MEIO DELA QUE SERÁ APLICADA
* UMA FUNÇÃO DE PESQUISA HASH.

* HÁ DUAS FORMAS DE SE CRIAR TABELA INTERNA:
* 1) COM WORK AREA INTEGRADA:
* EXEMPLO 1:
* DATA: <NOME TABELA> TYPE TABLE OF <REFERÊNCIA> WITH HEADER LINE.('WITH HEADER LINE' É OPCIONAL).
* COMO REFERÊNCIA É POSSÍVEL UTILIZAR TABELA INTERNA, TABELA TRANSPARENTE, TIPO OU ESTRUTURA.

* EXEMPLO 2:
* DATA: BEGIN OF <NOME TABELA> OCCURS 0,   " A DIFERENÇA É O 'OCCURS 0'
*    CAMPO1 TYPE C,
*    CAMPO2 TYPE N,
*  END OF <NOME TABELA>.

DATA: BEGIN OF T_FORNEC OCCURS 0,   "O TAMANHO 0 SIGNIFICA: SEM LIMITE DE REGISTROS
  CODFOR(10)  TYPE C,
  NOME(35)    TYPE C,
END OF T_FORNEC.
* OBS: A SAP NÃO RECOMENDA DECLARAR TABELA COM WORK AREA INTEGRADA, DEVIDO À PROGRAMAÇÃO
* ORIENTADA A OBJETO.

* 2) COM WORK AREA SEPARADA (ESTA É A MANEIRA INDICADA PELA SAP PARA DECLARAÇÃO DE TABELAS):
* DATA: <NOME TABELA> TYPE TABLE OF <REFERÊNCIA>.
  DATA: T_MATERIAL TYPE TABLE OF TY_MATERIAL. " A WORK AREA É A ESTRUTURA DA LINHA 24
* DATA: <WORK AREA> TYPE <REFERÊNCIA>.

*--------------------------------------------------------------------------------------------------
* COMANDO APPEND: INSERE UMA NOVA LINHA NA TABELA INTERNA COM BASE NOS TIPOS DE TABELA
*--------------------------------------------------------------------------------------------------
* STANDARD TABLE: NOVA LINHA AO FINAL DA TABELA.
*                 APPEND <TABELA INTERNA>.

* SORTED TABLE: NOVA LINHA SEGUINDO A ORDENAÇÃO DA TABELA, DESDE QUE A CHAVE PRIMÁRIA NÃO SEJA
*               DUPLICADA.
*               APPEND <WORK AREA> TO <TABELA INTERNA>.

* HASHED TABLE: NÁO É PUSSÍVEL UTILIZAR APPEND (DEVE-SE USAR O 'INSERT TABLE').
* OBS.: O COMANDO APPEND TEM VÁRIAS DERIVAÇÒES, BASTA USAR O CTRL+SPACE PARA VISUALIZÁ-LAS.

* EXEMPLO PARA TABELA COM HEADER LINE:
*--------------------------------------
        T_FORNEC-CODFOR = 'FORN-0001'.
        T_FORNEC-NOME   = 'APPLE'.
        APPEND T_FORNEC.

* O COMANDO CLEAR, EM UMA TABELA COM HEADER LINE, LIMPA SOMENTE A HEADER LINE (ÁREA DE TRANSFERÊNCIA)
        CLEAR T_FORNEC.
* DICA: PARA LIMPAR O CONTEÚDO DA TABELA DEVE-SE UTILIZAR COLCHETES: CLEAR <WORK AREA>[], OU
* O COMANDO REFRESH, MAS ESTE LIMPA APENAS O CONTEÚDO, NÃO LIMPA A WORK AREA.

         T_FORNEC-CODFOR = 'FORN-0002'.
         T_FORNEC-NOME   = 'SAMSUNG'.
         APPEND T_FORNEC.
*--------------------------------------

* EXEMPLO COM TABELA SEM HEADER LINE:
*--------------------------------------
         W_MATERIAL-CODMAT = 'MAT-0001'.
         W_MATERIAL-DESCRI = 'IPHONE 6'.
         APPEND W_MATERIAL TO T_MATERIAL.

         CLEAR W_MATERIAL.
* OBS.: COMO A WORK AREA É UMA ESTRUTURA SEPARADA DA TABELA, PODEMOS APAGAR TODO O CONTEÚDO DELA
*       (UNIDIMENSIONAL), OU SEJA, SEMPRE UTILIZAMOS O CLEAR PARA LIMPAR ESTRUTURA E VARIÁVEIS.
*        O REFRESH É APENAS PARA CONTEÚDO DE TABELAS.
         W_MATERIAL-CODMAT = 'MAT-0002'.
         W_MATERIAL-DESCRI = 'GALAXY 6'.
         APPEND W_MATERIAL TO T_MATERIAL.
*--------------------------------------

*--------------------------------------------------------------------------------------------------
* COMANDO LOOP: USADO PARA LEITURA DE DADOS EM TABELA INTERNA.
*--------------------------------------------------------------------------------------------------
*SINTAXE BÁSICA:
* LOOP AT <TABELA INTERNA>.
*       <ROTINAS E TRATAMENTOS>.
*ENDLOOP.

* QUANDO SE TRATAR DE MANDAR A LINHA DA TABELA PARA UMA ESTRUTURA:
* LOOP AT <TABELA INTERNA> INTO <ESTRUTURA>.
*       <ROTINAS E TRATAMENTOS>.
*ENDLOOP.

* PODE-SE FAZER LOOP COM CONDIÇÕES:
* LOOP AT <TABELA INTERNA> WHERE <CONDIÇÕES>.
*       <ROTINAS E TRATAMENTOS>.
* ENDLOOP.

* EXEMPLO DE LOOP EM TABELA INTERNA COM HEADER LINE.
LOOP AT T_FORNEC WHERE CODFOR = 'FORN-0001'.
  WRITE:/ T_FORNEC-CODFOR, T_FORNEC-NOME, 'LOOP'.
ENDLOOP.

ULINE.

* EXEMPLO DE LOOP EM TABELA INTERNA SEM HEADER LINE.
LOOP AT T_MATERIAL INTO W_MATERIAL.
  WRITE:/ W_MATERIAL-CODMAT, W_MATERIAL-DESCRI, 'LOOP'.
ENDLOOP.

ULINE.

*--------------------------------------------------------------------------------------------------
* COMANDO READ TABLE: LEITURA DE DADOS EM TABELA INTERNA, PORÉM, DE APENAS UM REGISTRO.
*--------------------------------------------------------------------------------------------------
* IMPORTANTE: A variável SY-SUBRC é utilizada para verificar se uma operação foi realizada com
* sucesso, poir isso a utilizamos para verificar se o registro foi encontrado no comando READ TABLE.

* SINTAXE:
* READ TABLE <tabela interna> WITH KEY INDEX 1.
* IF SY-SUBRC = 0.
*   <FAZ ALGO>
*ENDIF.

* READ TABLE <tabela interna> WITH KEY campo1 = <variavel>.
* IF SY-SUBRC = 0.
*   <FAZ ALGO>.
* ENDIF.

READ TABLE T_FORNEC INDEX 2.
IF SY-SUBRC = 0.  " SE O RESULTADO FOR VERDADEIRO, RETORNA 0.
  WRITE:/ T_FORNEC-CODFOR, T_FORNEC-NOME, 'READ'.
ENDIF.

ULINE.

*--------------------------------------------------------------------------------------------------
* COMANDO MODIFY: UTILIZADO PARA MODIFICAR DADOS EM TABELAS INTERNAS.
*--------------------------------------------------------------------------------------------------
* SINTAXE:
* Atualiza todos os campos da tabela.
* MODIFY <tabela interna>.

*Atualiza todos os campos de um determinado index.
* MODIFY <tabela interna> INDEX <index>.

* Atualiza todos os campos da tabela com base nos registros da work area de um determinado index.
* MODIFY <tabela interna> FROM <work area> INDEX <index>.

* Atualiza apenas o campo que foi informado após o comando TRANSPORTING de um determinado index.
* MODIFY <tabela interna> INDEX <index> TRANSPORTING <campo1>.

LOOP AT T_MATERIAL INTO W_MATERIAL.
  CONCATENATE W_MATERIAL-DESCRI 'BRANCO' INTO W_MATERIAL-DESCRI SEPARATED BY SPACE.
  MODIFY T_MATERIAL FROM W_MATERIAL TRANSPORTING DESCRI.
ENDLOOP.

LOOP AT T_MATERIAL INTO W_MATERIAL.
  WRITE:/ W_MATERIAL-CODMAT, W_MATERIAL-DESCRI, 'MODIFY'.
ENDLOOP.
ULINE.
*--------------------------------------------------------------------------------------------------

*&---------------------------------------------------------------------*
*& Report ZATSR0008
*&---------------------------------------------------------------------*
*& COMANDOS SQL
*&---------------------------------------------------------------------*
REPORT zatsr0008.

* Tabela transparente (são tabelas do Banco de Dados, feitas diretamente na Transação SE11, por ex.).
TABLES zatst0001.   " Tabela de TIPO DE MATERIAL
*DICA: Se der duplo-clique no nome da tabela, vai levar até a transação SE11 e consultar as informações


* Tela de seleção
PARAMETERS: p_tpmat  LIKE zatst0001-tpmat OBLIGATORY,
            p_denom  LIKE zatst0001-denom OBLIGATORY,
            p_insert RADIOBUTTON GROUP gr1,
            p_update RADIOBUTTON GROUP gr1,
            p_modify RADIOBUTTON GROUP gr1,
            p_delete RADIOBUTTON GROUP gr1.

*----------------------------------------------------------------------------------------------------
* INSERT - Insere dados no banco a partir de uma área de dados especificada em TABLES ou área
* declarada com DATA. Os dados desejados devem ser colocados na área intermediária e, então,
* chamar o comando INSERT. Caso a área não seja especificada em TABLEs, usar FROM. SINTAXE:
*     table-campo1 = vg_campo1.
*     table-campoN = vg_campoN.
*     INSERT <table>.
*----------------------------------------------------------------------------------------------------
IF p_insert = 'X'.
  CLEAR zatst0001.  "É uma boa prática sempre dar o comando Clear para limpar a memória.
  zatst0001-tpmat = p_tpmat.
  zatst0001-denom = p_denom.
  INSERT zatst0001.

  IF sy-subrc = 0.
    COMMIT WORK.  " Confirma a gravação no banco de dados.
    MESSAGE 'Registro cadastrado com sucesso' TYPE 'S'.
  ELSE.
    ROLLBACK WORK.  " Mantém o BD como antes.
    MESSAGE 'Erro no Cadastro' TYPE 'I'.
  ENDIF.

*----------------------------------------------------------------------------------------------------
* UPDATE - Altera dados no banco a partir de uma área ou tabela interna, neste não é necessário espe-
* cificar a cláusula WHERE: serão alterados os registros correspondentes de acordo com as chaves.
*       UPDATE <table>
*            SET campo1 = vg_campo1             " Note que não há ponto nem vírgula
*                campo2 = vg_campo2
*       WHERE campo3 = vg_campo3
*             AND campo4 = vg_campo4.
*----------------------------------------------------------------------------------------------------
ELSEIF p_update = 'X'.

  UPDATE zatst0001     " Tabela a ser atualizada
    SET denom = p_denom
    WHERE tpmat = p_tpmat.

  IF sy-subrc = 0.
    COMMIT WORK.  " Confirma a gravação no banco de dados.
    MESSAGE 'Registro atualizado com sucesso' TYPE 'S'.
  ELSE.
    ROLLBACK WORK.  " Mantém o BD como antes.
    MESSAGE 'Erro na atualização' TYPE 'I'.
  ENDIF.

*----------------------------------------------------------------------------------------------------
* MODIFY - parecido com Update, mas insere um novo registro caso o especificado não exista.
*       table-campo1 = vg_campo1.
*       table-campo2 = vg_campo2.
*       MODIFY <table>.
*----------------------------------------------------------------------------------------------------
ELSEIF p_modify = 'X'.
  CLEAR zatst0001.
  zatst0001-tpmat = p_tpmat.
  zatst0001-denom = p_denom.
  MODIFY zatst0001.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE 'Processos realizados com sucesso' TYPE 'S'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE 'Erro no processamento.' TYPE 'I'.
  ENDIF.

*----------------------------------------------------------------------------------------------------
* DELETE - elimina registros do banco. Sua sintaxe é igual ao Insert.
*       DELETE FROM <table> WHERE campo1 = vg_campo1.
*----------------------------------------------------------------------------------------------------
ELSEIF p_delete = 'X'.
  CLEAR zatst0001.
  DELETE FROM ZATST0001 WHERE tpmat = p_tpmat.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE 'Registro eliminado' TYPE 'S'.
  else.
    ROLLBACK WORK.
    MESSAGE 'Erro ao eliminar' TYPE 'I'.
  endif.

  ENDIF.
  
  uline.
  

