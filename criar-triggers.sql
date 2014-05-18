
-- Mantém os campos QTD_VOLUMES e PESO_ENCOMENDA atualizados na tabela PEDIDO.
CREATE FUNCTION attr_redundante_qtd_vol_peso_encomenda()
RETURNS trigger AS 
$$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE PEDIDO
            SET (QTD_VOLUMES, PESO_ENCOMENDA) = (QTD_VOLUMES + NEW.QTD_VOLUMES, PESO_ENCOMENDA + NEW.PESO_VOLUMES)
            WHERE ID = NEW.PEDIDO_ID;
        END IF;
        RETURN NEW;
    END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER attr_redundante_qtd_vol_peso_encomenda_tgr BEFORE INSERT OR UPDATE OF QTD_VOLUMES, PESO_VOLUMES OR DELETE ON VIAGEM
FOR EACH ROW
EXECUTE PROCEDURE attr_redundante_qtd_vol_peso_encomenda();