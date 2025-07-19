--Selecionar todas as espécies:
SELECT * FROM especie;

-- Selecionar nomes e telefones de todos os donos:
SELECT nome, telefone FROM dono;

--Selecionar veterinários com especialidade em espécie específica (ID 1):
SELECT * FROM veterinario WHERE especialidade = 1;

--Selecionar animais de um dono específico (CPF '23410316304'):
SELECT * FROM animal WHERE cpf_dono = '23410316304';

--Selecionar medicamentos controlados:
SELECT * FROM medicamento WHERE tipo_controle = 'Sem prescrição';

--Selecionar consultas realizadas em uma data específica ('2023-01-15'):
SELECT * FROM consulta WHERE data < '2025-01-01';

--Selecionar laudos que solicitaram exames:
SELECT * FROM laudo WHERE exames_solicitados IS NOT NULL;

--Selecionar medicamentos contraindicados para certas espécies:
SELECT * FROM medicamento_especie WHERE contraindicacao IS NOT NULL;

-- Selecionar todos os animais da espécie com id_especie = 1 (Canina)
SELECT * FROM animal
WHERE id_especie = 1;

-- Selection que pega todos os laudos com detalhes acima de 500 caracteres
SELECT * FROM laudo
WHERE LENGTH(detalhes) > 500;