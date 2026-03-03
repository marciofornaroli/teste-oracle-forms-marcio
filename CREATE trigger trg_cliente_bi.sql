-- Criar trigger para usar a sequence automaticamente 
CREATE OR REPLACE TRIGGER trg_cliente_bi 
BEFORE INSERT ON tb_cliente 
FOR EACH ROW 
BEGIN 
IF :NEW.id_cliente IS NULL THEN 
   SELECT seq_cliente.NEXTVAL 
     INTO :NEW.id_cliente 
     FROM dual; 
   --
   :NEW.dt_criacao    := SYSTIMESTAMP;
   :NEW.login_criacao := substr(user,1,30);
   --
END IF; 
END; 
/
