
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
