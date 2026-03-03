CREATE TABLE tb_uf ( sg_uf VARCHAR2(2) PRIMARY KEY, 
                     nome_uf VARCHAR2(50) NOT NULL );

COMMENT ON COLUMN TB_UF.SG_UF IS 'Sigla da UF';
COMMENT ON COLUMN TB_UF.NOME_UF IS 'Nome da UF';

/


