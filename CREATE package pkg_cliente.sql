CREATE OR REPLACE PACKAGE PKG_CLIENTE AS

FUNCTION FN_VALIDAR_EMAIL(P_EMAIL  VARCHAR2)
  RETURN NUMBER; -- (1 v lido, 0 inv lido)

FUNCTION FN_NORMALIZAR_CEP(P_CEP  VARCHAR2)
  RETURN VARCHAR2; -- (somente digitos; 8 chars)

PROCEDURE PRC_DELETAR_CLIENTE(P_ID NUMBER,
                              P_RETORNO OUT NUMBER);

PROCEDURE PRC_LISTAR_CLIENTES(P_NOME VARCHAR2, P_EMAIL VARCHAR2, P_RC OUT SYS_REFCURSOR);

END PKG_CLIENTE;
/

CREATE OR REPLACE PACKAGE BODY PKG_CLIENTE AS

FUNCTION FN_VALIDAR_EMAIL(P_EMAIL IN VARCHAR2) RETURN NUMBER IS
  -- (1 valido, 0 invalido)
BEGIN
  if p_email is not null then
    -- Regex simplificado para validar formato b sico de email
    IF REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN --'Email v lido'
      RETURN 1;
    ELSE --'Email invalido'
      RETURN 0;
      --RAISE_APPLICATION_ERROR(-20001, 'Email invalido!');
    END IF;
  else
    RETURN 0;
    --RAISE_APPLICATION_ERROR(-20002, 'Email nao informado!');
  end if;
END FN_VALIDAR_EMAIL;

FUNCTION FN_NORMALIZAR_CEP(P_CEP IN VARCHAR2) RETURN VARCHAR2 IS
  -- (somente digitos; 8 chars numericos do cep)
v_cep VARCHAR2(20) := '';

BEGIN

  if p_cep is not null then
    -- Remove tudo que n o for n mero

    v_cep := REGEXP_REPLACE(p_cep, '[^0-9]', '');

    v_cep := SUBSTR(v_cep, 1, 8);

    -- Se tiver mais que 8 digitos numericos, da erro

    IF LENGTH(v_cep) != 8 THEN
      RETURN v_cep;
      --RAISE_APPLICATION_ERROR(-20001, 'CEP invalido!');
    ELSE
      RETURN v_cep;
    END IF;
  else
    RETURN v_cep;
  end if;

END FN_NORMALIZAR_CEP;

PROCEDURE PRC_DELETAR_CLIENTE(P_ID      IN NUMBER,
                              P_RETORNO OUT NUMBER) IS
cursor c_cliente is
    select 'S' existe
      from tb_cliente
     where id_cliente = p_id; -- identificador do cliente

reg_cliente c_cliente%rowtype;

BEGIN
    open c_cliente;
    fetch c_cliente into reg_cliente;
    close c_cliente;
    --
    if reg_cliente.existe = 'S' then
      delete from tb_cliente
       where id_cliente = p_id;
      --
      p_retorno := 0; -- sucesso na delecao
    else
      p_retorno := 1; -- falha
      --RAISE_APPLICATION_ERROR(-20001,'Cliente nao encontrado!');
    end if;
END PRC_DELETAR_CLIENTE;

PROCEDURE PRC_LISTAR_CLIENTES(P_NOME IN VARCHAR2, P_EMAIL IN VARCHAR2, P_RC OUT SYS_REFCURSOR) IS
  BEGIN
    OPEN P_RC FOR
        SELECT id_cliente,
               nome,
               email,
               cep,
               logradouro,
               bairro,
               cidade,
               uf,
               ativo,
               dt_criacao,
               login_criacao,
               dt_atualizacao,
               login_atualizacao
          FROM tb_cliente
         WHERE nome  = P_NOME
           AND email = P_EMAIL;

  END;

END PKG_CLIENTE;
/
