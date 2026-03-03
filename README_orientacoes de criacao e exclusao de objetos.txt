Para criar os objetos:
Seguir os passos para criar os objetos , seguir a ordem abaixo:
1- criar a tabela tb_uf (Estados da Federação) - CREATE table tb_uf.sql
2- inserir os registros na tabela tb_uf (Estados da Federação) - INSERT table tb_uf.sql
3- criar a tabela tb_cliente (sequence, constraints, índices) - CREATE table tb_cliente.sql
4- criar a trigger before insert para a tabela tb_cliente - CREATE trigger trg_cliente_bi.sql
5- criar a package pkg_cliente - CREATE package pkg_cliente.sql


Para dropar os objetos:
1- dropar a tabela tb_cliente - DROP table tb_cliente.sql
2- dropar a sequence da tabela tb_cliente - DROP sequence seq_cliente.sql
3- dropar a tabela tb_uf - DROP table tb_uf.sql
4- dropar a trigger da tabela tb_cliente - DROP trigger trg_cliente_bi.sql
5- dropar a package pkg_cliente - DROP package pkg_cliente.sql