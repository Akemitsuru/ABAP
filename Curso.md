# **INTRODUÇÃO A DICIONÁRIO DE DADOS**

## **Transação SE11:**
    Permite a administração de todas as definições de dados do SAP.
Com ele, é possível criar Tabelas, Estruturas, Visões, Elemento de dados, Domínio, Objetos de bloqueio, etc.

    Uma das grandes vantagens do Dicionário de Dados é não ter que se
preocupar com qual banco está sendo utilizado junto ao sistema SAP. Quando uma empresa decide implementar o sistema SAP, ela pode optar por utilizar os principais os principais bancos de dados disponíveis no mercado (SQL, Oracle, etc). Independentemente do tipo que ela optar, o procedimento de criação de objetos sempre será o mesmo. Em momento algum haverá necessidade de acessar o BD, pois o próprio dicionário de dados se encarregará disso.


## **Modelo entidade e relacionamento:**
    É a maneira sistemática de descreve e definir um processo de negócio.
Alguns conceitos são:
    *CHAVE PRIMÁRIA* - Se refere a um ou mais campos e seus valores nunca se repetem.
    *NORMALIZAÇÃO DE TABELAS* - É uma série de passos que tem como objetivo ter um banco de dados consistente, melhor forma de armazenamento das informações, sem redundância e consistente.
    *CHAVE ESTRANGEIRA* - É utilizada para garantir que aquele registro que está sendo utilizado realmente exista.

## **Relacionamento de cardinalidade:**
    Forma de determinar o relacionamento entre duas entidades (tabelas),
como, por exemplo:
    *Um-para-Um;*
    *Um-para-N;*
    *N-para-Um;*
    *N-para-N.*

## **Domínio:**
    Objeto onde são defeinidos os atributos: Tipo, tamanho e número de 
casas decimais. Não podem utilizar caracteres especiais e podem ter, no máximo, 30 posições. São utilizados para a criação de Tabelas e é o elemento de mais baixo nível no Dicionário de Dados.
    
