SELECT a.nome AS animal_nome, a.raca, d.nome AS dono_nome, d.telefone, d.email
FROM animal a
JOIN dono d ON a.cpf_dono = d.cpf;

SELECT c.data, c.diagnostico, v.nome AS veterinario, a.nome AS animal, e.nome AS especie
FROM consulta c
JOIN veterinario v ON c.crmv_vet = v.crmv
JOIN animal a ON c.id_animal = a.id_animal
JOIN especie e ON a.id_especie = e.id_especie;

SELECT m.nome AS medicamento, m.dosagem, l.detalhes, c.data AS data_consulta
FROM laudo_medicamento lm
JOIN medicamento m ON lm.id_medicamento = m.id_medicamento
JOIN laudo l ON lm.id_laudo = l.id_laudo
JOIN consulta c ON l.id_consulta = c.id_consulta;

SELECT v.crmv, v.nome AS veterinario, e.nome AS especialidade
FROM veterinario v
JOIN especie e ON v.especialidade = e.id_especie
ORDER BY e.nome;

SELECT m.nome AS medicamento, e.nome AS especie, me.contraindicacao
FROM medicamento_especie me
JOIN medicamento m ON me.id_medicamento = m.id_medicamento
JOIN especie e ON me.id_especie = e.id_especie
WHERE me.contraindicacao IS NOT NULL;

SELECT c.data, c.diagnostico, c.custo, d.nome AS dono, a.nome AS animal
FROM consulta c
JOIN dono d ON c.cpf_dono = d.cpf
JOIN animal a ON c.id_animal = a.id_animal
WHERE c.custo > (SELECT AVG(custo) FROM consulta);

SELECT a.nome AS animal, a.raca, e.nome AS especie, e.cuidados_especificos
FROM animal a
JOIN especie e ON a.id_especie = e.id_especie
WHERE e.cuidados_especificos IS NOT NULL;

SELECT l.detalhes, l.exames_solicitados, c.data, c.diagnostico, 
       v.nome AS veterinario, a.nome AS animal
FROM laudo l
JOIN consulta c ON l.id_consulta = c.id_consulta
JOIN veterinario v ON c.crmv_vet = v.crmv
JOIN animal a ON c.id_animal = a.id_animal;

SELECT DISTINCT m.nome AS medicamento, m.dosagem, m.tipo_controle
FROM laudo_medicamento lm
JOIN medicamento m ON lm.id_medicamento = m.id_medicamento
JOIN laudo l ON lm.id_laudo = l.id_laudo
JOIN consulta c ON l.id_consulta = c.id_consulta
JOIN animal a ON c.id_animal = a.id_animal
JOIN especie e ON a.id_especie = e.id_especie
WHERE e.nome = 'Canina';

SELECT v.nome AS veterinario, e.nome AS especialidade, 
       COUNT(c.id_consulta) AS total_consultas
FROM veterinario v
JOIN especie e ON v.especialidade = e.id_especie
LEFT JOIN consulta c ON v.crmv = c.crmv_vet
GROUP BY v.nome, e.nome
ORDER BY total_consultas DESC;