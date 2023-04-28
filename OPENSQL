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
