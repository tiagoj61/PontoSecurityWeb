CREATE OR REPLACE FUNCTION fn_gerenciar_estoque()
	RETURNS TRIGGER 
	LANGUAGE PLPGSQL
AS $$
DECLARE
    idMaterial BIGINT;
BEGIN
    IF TG_OP = 'DELETE' THEN

        CASE 
            WHEN TG_TABLE_NAME = 'entradaalmoxarifado' THEN
                UPDATE material SET estoqueatual = (estoqueatual - OLD.quantidade) WHERE id = OLD.material_id;
            WHEN TG_TABLE_NAME = 'devolucaoalmoxarifado' THEN
                idMaterial := (SELECT material_id FROM saidaalmoxarifado WHERE saidaalmoxarifado.id = OLD.saidaalmoxarifado_id);
                UPDATE material SET estoqueatual = (estoqueatual - OLD.quantidade) WHERE id = idMaterial;
            ELSE            
                UPDATE material SET estoqueatual = (estoqueatual + OLD.quantidade) WHERE id = OLD.material_id;
        END CASE;

        RETURN OLD;
    ELSE
        CASE
            WHEN TG_TABLE_NAME = 'entradaalmoxarifado' THEN                
                UPDATE material SET estoqueatual = (estoqueatual + NEW.quantidade) WHERE id = NEW.material_id;
            WHEN TG_TABLE_NAME = 'devolucaoalmoxarifado' THEN
                idMaterial := (SELECT material_id FROM saidaalmoxarifado WHERE saidaalmoxarifado.id = NEW.saidaalmoxarifado_id);
                UPDATE material SET estoqueatual = (estoqueatual + NEW.quantidade) WHERE id = idMaterial;
            ELSE
                UPDATE material SET estoqueatual = (estoqueatual - NEW.quantidade) WHERE id = NEW.material_id;
        END CASE;

        RETURN NEW;
    END IF;
END;
$$

CREATE OR REPLACE FUNCTION haversine(latitude1 numeric(10,6),longitude1 numeric(10,6), latitude2 numeric(10,6), longitude2 numeric(10,6))
RETURNS double precision AS
$BODY$
	SELECT 6371 * acos( cos( radians(latitude1) ) * cos( radians( latitude2 ) ) * cos( radians( longitude1 ) - radians(longitude2) ) + sin( radians(latitude1) ) * sin( radians( latitude2 ) ) ) AS distance
$BODY$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION fn_devolucao_maxima(BIGINT)
	RETURNS INT
	LANGUAGE PLPGSQL
AS $$
BEGIN
    
    RETURN ( 
        SELECT 
            saidaalmoxarifado.quantidade - COALESCE(SUM(devolucaoalmoxarifado.quantidade), 0) 
        FROM saidaalmoxarifado 
        LEFT JOIN devolucaoalmoxarifado ON saidaalmoxarifado.id = devolucaoalmoxarifado.saidaalmoxarifado_id 
        WHERE saidaalmoxarifado.id = $1
        GROUP BY saidaalmoxarifado.quantidade
    );

END;
$$

CREATE OR REPLACE FUNCTION fn_ultima_prova_vida(BIGINT)
	RETURNS TIMESTAMP
	LANGUAGE PLPGSQL
AS $$
BEGIN
    
    RETURN ( 
        SELECT 
            COALESCE(MAX(provavida.createdat), tombamento.createdat)
        FROM tombamento
        LEFT JOIN provavida ON provavida.tombamento_id = tombamento.id
        WHERE tombamento.id = $1
	GROUP BY tombamento.createdat
    );

END;
$$

CREATE TRIGGER tg_gerenciar_estoque 
    AFTER INSERT OR UPDATE OR DELETE ON entradaalmoxarifado
FOR EACH ROW 
    EXECUTE PROCEDURE fn_gerenciar_estoque();


CREATE TRIGGER tg_gerenciar_estoque 
    AFTER INSERT OR UPDATE OR DELETE ON saidaalmoxarifado
FOR EACH ROW 
    EXECUTE PROCEDURE fn_gerenciar_estoque();
	
CREATE TRIGGER tg_gerenciar_estoque 
    AFTER INSERT OR UPDATE OR DELETE ON devolucaoalmoxarifado
FOR EACH ROW 
    EXECUTE PROCEDURE fn_gerenciar_estoque();
	

CREATE OR REPLACE VIEW public.vw_manutencao_necessaria
 AS
 SELECT veiculo.id AS veiculo_id,
    veiculo.modelo AS veiculo_modelo,
    veiculo.placa AS veiculo_placa,
    veiculo.quilometragem AS veiculo_quilometragem,
    veiculo.tipoveiculo_id AS veiculo_tipoveiculo_id,
    tiposervico.id AS tiposervico_id,
    tiposervico.nome AS tiposervico_nome,
    tiposervico.quilometragem AS tiposervico_quilometragem,
    MAX(manutencao.quilometragem) AS manutencao_quilometragem,
    MIN(
		round(((veiculo.quilometragem - manutencao.quilometragem) * 100::double precision / tiposervico.quilometragem)::numeric, 2)
	) AS percentual_revisao
   FROM manutencao
     JOIN manutencao_tiposervico ON manutencao_tiposervico.manutencao_id = manutencao.id
     JOIN tiposervico ON tiposervico.id = manutencao_tiposervico.tiposervico_id
     JOIN veiculo ON veiculo.id = manutencao.veiculo_id
  WHERE tiposervico.limitaquilometragem = true AND tiposervico.ativo = true AND (veiculo.situacaoveiculoenum = ANY (ARRAY[0, 1, 2, 3]))
  GROUP BY veiculo.id, veiculo.modelo, veiculo.placa, veiculo.quilometragem, veiculo.tipoveiculo_id,
        tiposervico.id, tiposervico.nome, tiposervico.quilometragem
  ORDER BY percentual_revisao DESC;