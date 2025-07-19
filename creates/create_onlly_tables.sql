
-- 1. Tabela especie (sem dependências)
CREATE TABLE especie (
	id_especie INTEGER PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	cuidados_especificos VARCHAR(1000)
);

-- 2. Tabela dono (sem dependências)
CREATE TABLE dono (
	cpf VARCHAR(11) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	telefone VARCHAR(20),
	email VARCHAR(100),
	endereco VARCHAR(200) NOT NULL,
	data_cadastro DATE
);

-- 3. Tabela veterinario (depende de especie)
CREATE TABLE veterinario (
	crmv VARCHAR(6) PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	especialidade INTEGER,
	CONSTRAINT fk_vet_especie FOREIGN KEY (especialidade)
		REFERENCES especie(id_especie)
);

-- 4. Tabela animal (depende de dono e especie)
CREATE TABLE animal (
	id_animal INTEGER PRIMARY KEY,
	nome VARCHAR(100),
	raca VARCHAR(100) NOT NULL,
	data_nascimento DATE,
	cpf_dono VARCHAR(11) NOT NULL,
	id_especie INTEGER NOT NULL,
	CONSTRAINT fk_animal_dono FOREIGN KEY (cpf_dono)
		REFERENCES dono(cpf),
	CONSTRAINT fk_animal_especie FOREIGN KEY (id_especie)
		REFERENCES especie(id_especie)
);

-- 5. Tabela medicamento (sem dependências)
CREATE TABLE medicamento (
	id_medicamento INTEGER PRIMARY KEY,
	nome VARCHAR(100) UNIQUE NOT NULL,
	dosagem VARCHAR(100) NOT NULL,
	tipo_controle VARCHAR(100) NOT NULL
);

-- 6. Tabela consulta (depende de veterinario, animal, dono)
CREATE TABLE consulta (
	id_consulta INTEGER PRIMARY KEY,
	data DATE NOT NULL,
	diagnostico VARCHAR(1000) NOT NULL,
	custo FLOAT NOT NULL,
	crmv_vet VARCHAR(6),
	id_animal INTEGER,
	cpf_dono VARCHAR(11),
	CONSTRAINT fk_consulta_vet FOREIGN KEY (crmv_vet)
		REFERENCES veterinario(crmv),
	CONSTRAINT fk_consulta_animal FOREIGN KEY (id_animal)
		REFERENCES animal(id_animal),
	CONSTRAINT fk_consulta_dono FOREIGN KEY (cpf_dono)
		REFERENCES dono(cpf)
);

-- 7. Tabela laudo (1:1 com consulta)
CREATE TABLE laudo (
	id_laudo INTEGER PRIMARY KEY,
	detalhes VARCHAR(1000) NOT NULL,
	exames_solicitados VARCHAR(100),
	id_consulta INTEGER UNIQUE,
	CONSTRAINT fk_laudo_consulta FOREIGN KEY (id_consulta)
		REFERENCES consulta(id_consulta)
);

-- 8. Tabela intermediária laudo_medicamento (N:N)
CREATE TABLE laudo_medicamento (
	id_laudo INTEGER,
	id_medicamento INTEGER,
	PRIMARY KEY (id_laudo, id_medicamento),
	FOREIGN KEY (id_laudo) REFERENCES laudo(id_laudo),
	FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

-- 9. Tabela medicamento_especie (N:N)
CREATE TABLE medicamento_especie (
	id_medicamento INTEGER,
	id_especie INTEGER,
	contraindicacao VARCHAR(500),
	PRIMARY KEY (id_medicamento, id_especie),
	CONSTRAINT fk_medesp_medicamento FOREIGN KEY (id_medicamento)
		REFERENCES medicamento(id_medicamento),
	CONSTRAINT fk_medesp_especie FOREIGN KEY (id_especie)
		REFERENCES especie(id_especie)
);
