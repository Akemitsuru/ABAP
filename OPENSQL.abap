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

*-----------------------------------------------------------------------------------------------------*
*COMMIT e ROLLBACK - Quando trabalhamos com alteração nos dados do banco, é bom sabermos que todas as
* alterações que estamos fazendo ainda não aconterem efetivamente. Isso só ocorre quando se encontra
* o primeiro commit. Automaticamente, quando acaba a execução de um programa, já é executado um
* commit. No caso do Rollback, ele retorna o BD para como estava antes, mantendo o original.
*-----------------------------------------------------------------------------------------------------*
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
  ULINE.
  
*&---------------------------------------------------------------------*
*& Report ZATSR0009
*&---------------------------------------------------------------------*
*& SELECT com ENDSELECT
*&---------------------------------------------------------------------*
REPORT zatsr0009.

* TABELA TRANSPARENTE
TABLES t005t.   "Denominação dos países

* TELA DE SELEÇÃO
PARAMETERS p_spras LIKE t005t-spras DEFAULT 'EN'.    "SPRAS = Código de idioma

ULINE /(30).

WRITE: /01 '|',
        02 'PAÍS',
        07 '|',
        08 'DENOMINAÇÃO',
        30 '|'.
ULINE /(30).

*-----------------------------------------------------------------------------------------------------*
* SELECT permite a leitura de dados do banco de dados; retorna um conjunto de dados (registro) que
* atendem a um determinado critério. As cláusulas do comando SELECT são as seguintes:
* SINTAXE:
*           SELECT <lista de campos>
* Pode-se selecionar uma lista de campos a serem retornados, separados per espaços. Ou, usando <*>
* (asterisco) para retornar todos os campos disponíveis.
* SELECT SINGLE retorna somente um registro que atende às restrições impostas.
* Caso a tabela tenha sido declarada por meio de TABLES, é automaticamente crido um registro na memória
* com o mesmo nome para manipulá-la, caso o SELECT traga campos de mais de uma tabela, não é possível
* utilizar esse artifício. Nesse caso, as tabelas não precisam ser declaradas TABLES, mas a seleção dos
* campos deve separar o nome da tabela e o campo com um til (~).
* O uso de SELECT sem especificar SINGLE ou INTO TABLE exige o uso de ENDSELECT.
*-----------------------------------------------------------------------------------------------------*
SELECT * FROM t005t WHERE spras = p_spras.

  WRITE: /01 '|',
          02 T005T-LAND1,
          07 '|',
          08 T005T-LANDX,
          30 '|'.

ULINE /(30).

ENDSELECT.

*---------------------------------------------------------------------------------------------------*
* No exemplo acima foi utilizado o SELECT com ENDSELECT. Essa instrução tem a performance muito ruim,
* pois ela faz uma consulta ao BD para cada conteúdo, tornendo o precessamento moroso.
* Sendo assim, recomenda-se utilizar a opção INTO TABLE.
*---------------------------------------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Report ZATSR0010
*&---------------------------------------------------------------------*
*& SELECT (sem ENDSELECT)
*&---------------------------------------------------------------------*
REPORT zatsr0010.

* TABELA TRANSPARENTE
TABLES t005t.   "Denominação dos países

*TABELA INTERNA
DATA: T_T005T TYPE TABLE OF T005T WITH HEADER LINE.

* TELA DE SELEÇÃO
PARAMETERS p_spras LIKE t005t-spras DEFAULT 'EN'.    "SPRAS = Código de idioma

ULINE /(30).

WRITE: /01 '|',
        02 'PAÍS',
        07 '|',
        08 'DENOMINAÇÃO',
        30 '|'.
ULINE /(30).

SELECT * FROM T005T INTO TABLE T_T005T WHERE SPRAS = P_SPRAS.
LOOP AT T_T005T.
  WRITE: /01 '|',
          02 T_T005T-LAND1,
          07 '|',
          08 T_T005T-LANDX,
          30 '|'.

ULINE /(30).
ENDLOOP.
ULINE.

* OUTROS EXEMPLOS:
*     TABLES SFLIGHT.
*     DATA: T_SFLIGHT LIKE SFLIGHT.
*     SELECT CARRID CONNID FLDATE SEATSOCC FROM SFLIGHT INTO TABLE T_SFLIGHT.

* 'itab' é o nome da tabela interna.

* INTO <lista de campos>| INTO TABLE <tabela interna>: permite armazenar o retorno numa tabela interna
* ou em campos definidos como o comando DATA.

* FROM <tabela> [[INNER|LEFT OUTER]JOIN <tabela>...]: especifica a origem dos dados.

* FOR ALL ENTRIES: usado quando selecionamos dados de uma tabela e precisamos de dados de outra
* tabela para compor as condições do where.
*           SELECT * FROM dtab FOR ALL ENTRIES IN itab WHERE...

* SELECT * FROM BSEG FOR ALL ENTRIES IN T_BKPF WHERE BUKRS = T_BUKPF-BUKRS
*  AND BELNR = T_BKPF-BELNR AND BELNR = T_BKPF-BELNR.
* Onde T_BKPF é uma tabela interna que recebeu o conteúdo da tabela BKPF.
* Se a Tabela Interna da condição FOR ALL ENTRIES estiver vazia, esse comando selecionará
* todo o conteúdo da tabela, pois nenhuma restrição está sendo colocada. Uma maneira de fazer
* essa verificação é a seguinte:

*   IF NOT itab[] IS INITIAL.   " Se itab não está vazia
*     SELECT * FROM dtab FOR ALL ENTRIES IN itab WHERE campo = itab-campo...
*   ENDIF.    " Fim do: se itab não está

* WHERE <condiçõe>: especifica as condições de busca. Por exemplo, WHERE CARRID = 'AA' faz com que
* apenas os registros em que o campmo CARRID tenha conteúdo igual a 'AA' sejam retornados.

* TESTE SELECT: para saber se o select encontro algum registo ou não, utilizados uma variável de
* sistema SY-SUBRC; se o conteúdo dessa variáve for o (zero), encontrou. Caso contrário, não foi
* encontrado nenhum registro. Pode ser usado para todos os comandos ABAP.

*-----------------------------------------------------------------------------------*
* OUTROS TIPOS DE SELECT:
*-----------------------------------------------------------------------------------*
*1) SELECT * FROM <tabela> - Quando não se impõe nenhum tipo de restrição (where), ocorre uma varredura
* sequencial dos registros da tabela. Quando se utiliza grandes tabela, isso, obviamente,
* afeta o runtime.

* SELECT * - seleciona todas as colunas de uma tabela. É melhor sempre especificar as colunas, pois,
* em caso de tabelas com muitas colunas, prejudicará a performance.

*2) SELECT * FROM <table> WHERE <campo> eq (ou =) <conteúdo>. - Lê todos os registro da tabela
* especificada onde o campo é igual ao conteúdo especificado.

*3) SELECT * FROM <tabela> WHERE <table field> BETWEEN <field1> and <field2>. - Ex.? field1 = 100
* fiels2 = 500. Pega, inclusive, 100 e 500. Você trabalha com o range.

*4) SELECT * FROM <table> WHERE <table field> LIKE ...'_R%'. - '_' significa "independente da
* primeira letra/ qualquer letra", "R" = a segunda letra deve ser R, "%' = Não importa a
* sequência de caracteres que virá.

*5) SELECT * FROM <table> WHERE <table field> IN (...,....).
* Exemplo: SELECT * FROM <table> WHERE campo1 in (123,1000). - podem ser valores ou literais.
* É como perguntar se campo1 é 123 ou 1000.

*6) SELECT * FROM <table> WHERE <table field> IN <itab>.

*7) SELECT * FROM <table> ORDER BY <field1><field2>... PRIMARY KEY. - classifica a tabela interna
* numa área auxiliar, sem afetar a tabela original. Evite o uso de sorts dentro de um select. Consome
* mais tempo que descarregar os dados em uma tabela interna e classificá-los.

*8) SELECT * FROM <table> BYPASSING BUFFER. - usado para ler diretamente da tabela original,
* e não do BUFFER.

*9) SELECT * FROM <table> APPENDING TABLE <itab>. - Lê os registros e os inclui - não
* sobrepõe - em uma tabela interna.

*10) SELECT ... FROM <table> INTO TABLE <itab>. - A estrutura da tabela interna deve
* corresponder à estrutura da tabela que está sendo acessada. O sistema lê os registros em conjunto,
* não individualmente, e os coloca dentro de uma tabela interna. Este processo é mais rápido do que
* ler, individualmente, por meio de um LOOP e ir gravavando os regstiros uma a um.

*11) SELECT ... INTO CORRESPONDING FIELDS OF TABLE <itab>. - A estrutura da tabela interna NÃO
* precisa corresponder à estrutura da tabela que está sendo acessada. Movimentará os registros
* para as colunas definidas na tabela interna que possuam nome ao da tabela aceszada.

*12) SELECT ... APPENDING CORRESPONDING FIELDS OF TABLE <itab>. - Lê e grava (nào sobrepõe) os
* dados em uma tabela interna que possui nomes idênticoos aos nomes da tabela que está sendo lida.

*13) SELECT SINGLE * FROM spfli WHERE ... <campo> ... EQ|= ... <conteúdo>. - Toda vez que se usa
* Select Single *, a chave primária completa deve ser especificada. Se a chave especificada não é
* qualificada, você receberá uma mensagem de warning e a performance ficaraá prejudicada.
* No caso de haver a necessidade de acessar um único registro via select, as opções são:
* SELECT * ... seguido de comando EXIT ou SELECT * ... UP TO 1 ROW. Para esses casos, não é
* necessário especificar a chave completa.

*14) SELECT <a2> <a2> ... INTO (<f1>, <f2>, ...) FROM ... <tabela> WHERE ... . - Lê as colunas
* especificadas (a1, a2). Após INTO deverão ser especificadas as áreas de trabalho auxiliares
* (f1, f2). O número de colunas lidas deverá ser igual ao número de work areas especificadas.

*15) SELECT MAX (campo)
*       MIN (campo)
*       AVG (campo)
*       COUNT(*) FROM <table> INTO (...,...,...,...,...)
*       WHERE ....... .
* AVD e SUM: somente para campos numéricos.
* Não se usa ENDSELECT. É mais rápido fazer uma rotina "à mão" do que utilizar este comando.

*16) SELECT * FROM (<table>) INTO <work area>. - Exemplo:
* DATA: BEGIN OF wa,
*         LINE(100),
* END OF wa.
* PARAMETERS: tabname(10) default 'SPFLI'. *** Ao especificar o nome da tabela em tempo
* dinamicamente no SELECT STATEMENT, sempre consome mais tempo de CPU do que ao fazê-lo
* estatisticamente no programa ***
* SELECT * FROM (tabname) INTO wa.
*     WRITE ....
* ENDSELECT.

*17) SELECT carrid MIN(price) INTO (carrid, mininum, maximum) FROM sflight GROUP BY carrid.
* Todos os campos que eu quero que apareçam na minha lisa eu preciso especificar após GROUP BY.
* (carrid, maximum e minimum são campos auxiliares).
* Se o nome da database não é conhecido até runtime, não se pode especificar a cláusula GROUP BY.
