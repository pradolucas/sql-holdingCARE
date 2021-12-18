/* Lógico_1: */

CREATE DATABASE "Holding_Care"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


CREATE TABLE Alas (
	ID_Alas INT NOT NULL PRIMARY KEY,
	fk_Hospital_Id INT NOT NULL,
	fk_Ala_consultas INT NOT NULL,
	fk_Ala_operados_Id INT,
	fk_Ala_internados_Id INT,
	fk_Trabalha_em INT NOT NULL
);  


CREATE TABLE Ala_consultas (
    ID_Ala_consultas INT NOT NULL PRIMARY KEY,
	fk_Sala_atendimento_Id INT NOT NULL,
	fk_Alas_Id INT NOT NULL
);


CREATE TABLE Ala_operados(
	ID_Ala_operados INT NOT NULL PRIMARY KEY,
	fk_Sala_operacoes_Id INT,
	fk_Alas_Id INT
);


CREATE TABLE Ala_internados (
    ID_Ala_internados INT NOT NULL PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL CONSTRAINT single_Nome UNIQUE,
	fk_Leito_Id INT,
	fk_Alas_Id INT
);


CREATE TABLE Sala_atendimento (
    ID_Sala_atendimento INT NOT NULL PRIMARY KEY,
	fk_Ala_consultas_Id INT NOT NULL,
	fk_Resultado_consulta_Id INT
);


CREATE TABLE Sala_operacoes (
	ID_Sala_operacoes INT NOT NULL PRIMARY KEY,
	fk_Especialidade_Id INT NOT NULL,    
	fk_Andar_Id INT NOT NULL,
	fk_Ala_operados_id INT
);


CREATE TABLE Leito (
	ID_Leito INT NOT NULL PRIMARY KEY,
    fk_Andar_Id INT NOT NULL,
	fk_Ala_internados_id INT,
	fk_Agendamento_Id INT
);


CREATE TABLE Andar (
    ID_Andar INT NOT NULL PRIMARY KEY,
    Andar INT NOT NULL, 
	fk_Leito_Id INT NOT NULL,
	fk_Sala_operacoes_Id INT
);


CREATE TABLE Hospital (
	ID_Hospital INT NOT NULL PRIMARY KEY,
	fk_Funcionario_Id INT,
	fk_Alas_Id INT NOT NULL
);


CREATE TABLE Funcionario (
	ID_Funcionario INT NOT NULL PRIMARY KEY,
	Funcionario_tipo CHAR(100) NOT NULL,
	Data_contratacao DATE NOT NULL,
	Telefone CHAR(13),
	fk_Endereco_Id INT NOT NULL,
	fk_Enfermeiro_Id INT,
	fk_Medico_Id INT,
	fk_Tecnico_Id INT,
	fk_Hospital_Id INT,
	fk_Trabalha_em_Id INT
);


CREATE TABLE Especialidade (
    ID_Especialidade INT NOT NULL PRIMARY KEY,
    Especialidade VARCHAR(50) NOT NULL,
	fk_Medico_Id INT,
	fk_Sala_operacoes_Id INT
);


CREATE TABLE Endereco (
    ID_Endereco INT NOT NULL PRIMARY KEY,
    Numero INT NOT NULL,
	Logradouro VARCHAR(200) NOT NULL,
	Bairro VARCHAR(150) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
	Estado VARCHAR(50) NOT NULL
);


CREATE TABLE Tecnico (
	ID_Tecnico INT NOT NULL PRIMARY KEY,
	fk_Funcionario_Id INT
); 



CREATE TABLE Enfermeiro (
    ID_Enfermeiro INT NOT NULL PRIMARY KEY,
	fk_Prof_saude_Id INT
);


CREATE TABLE Medico (
	ID_Medico INT NOT NULL PRIMARY KEY, 
    CRM VARCHAR(6) NOT NULL CONSTRAINT single_CRM UNIQUE, 
	fk_Especialidade_Id INT NOT NULL,
	fk_Prof_saude_Id INT
); 
-- A relacao de ID_Medico -> ID_Funcionario é 1-1 então é valido


CREATE TABLE Prof_saude (
	ID_Prof_saude INT NOT NULL PRIMARY KEY,
	Tipo INT NOT NULL,
	fk_Funcionario_Id INT,
	fk_Medico_Id INT,
	fk_Enfermeiro_Id INT,
	fk_Substitui_Id INT,
	fk_Substituido_Id INT
); -- Essa relação permite que um funcionario substitua mais de uma pessoa?


CREATE TABLE Substitui (
	ID_Substitui INT NOT NULL PRIMARY KEY,
    fk_Prof_saude_substituido_Id INT NOT NULL CONSTRAINT single_Substituido UNIQUE ,
	fk_Prof_saude_suplente_Id INT NOT NULL  CONSTRAINT single_Suplente UNIQUE,
    Data_Hora INT NOT NULL
); 


CREATE TABLE Trabalha_em (
    ID_Trabalha_em INT NOT NULL PRIMARY KEY,
	fk_Funcionario_Id INT NOT NULL CONSTRAINT single_Funcionario UNIQUE,
	fk_Alas_Id INT NOT NULL CONSTRAINT single_Ala UNIQUE,
	Data_Hora_Id DATE NOT NULL
); 


CREATE TABLE Agendamento (
	ID_Agendamento INT NOT NULL PRIMARY KEY,
    Data_Hora DATE,
    fk_Leito_Id INT NOT NULL,
	fk_Internacao_Id INT
);


CREATE TABLE Internacao(
    ID_Internacao INT NOT NULL PRIMARY KEY,
	fk_Agendamento_Id INT NOT NULL,
	fk_Solicitacao_Id INT NOT NULL
);


CREATE TABLE Solicitacao (
	ID_Solicitacao INT NOT NULL PRIMARY KEY,
    descricao_motivo VARCHAR(350),
	cirurgia VARCHAR(100),
	fk_Internacao_Id INT, 
	fk_Resultado_retorno_Id INT
);


CREATE TABLE Resultado_retorno (
	ID_Resultado_retorno INT NOT NULL PRIMARY KEY,
    fk_Paciente_Id INT NOT NULL,
	fk_Resultado_consulta_id INT NOT NULL,
    fk_Medico_Id INT NOT NULL,
	fk_Solicitacao_Id INT
);


CREATE TABLE Resultado_consulta (
	ID_Resultado_consulta INT NOT NULL PRIMARY KEY,
    fk_Paciente_Id INT NOT NULL,
	fk_Sala_Atendimento_Id INT NOT NULL,
	fk_Medico_Id INT NOT NULL,
	fk_Requere_Id INT,
	fk_Emite_Id INT,	
	fk_Resultado_retorno_Id INT
);


CREATE TABLE Emite (
	ID_Emite INT NOT NULL PRIMARY KEY,
    fk_Diagnostico_Id INT NOT NULL,
	fk_Resultado_consulta_Id INT
);


CREATE TABLE Diagnostico (
    ID_Diagnostico INT NOT NULL PRIMARY KEY,
 	Tipo VARCHAR(100),
    Descricao VARCHAR(350),
    Data_Hora DATE,
    fk_Emite_Id INT NOT NULL
);


CREATE TABLE Requere (
	ID_Requere INT NOT NULL PRIMARY KEY,
    fk_Exame_Id INT,
	fk_Resultado_consulta_Id INT,
	Data_requerimento Date
);


CREATE TABLE Exame (
    ID_Exame INT NOT NULL PRIMARY KEY,
	Tipo VARCHAR(100),
	fk_Resultado_exame_Id INT,
	fk_Agenda_Id INT,
	fk_Requere_Id INT,	
	fk_Cobre_Id INT
);


CREATE TABLE Paciente (
	ID_Paciente INT NOT NULL PRIMARY KEY,
	Num_inscricao INT NOT NULL CONSTRAINT single_Num_inscricao UNIQUE,
	Data_Nasc DATE NOT NULL,
	Nome VARCHAR(150) NOT NULL,
	Genero CHAR NOT NULL,
	fk_Endereco_Id INT NOT NULL,
	fk_Agenda_exame_Id INT,
	fk_Resultado_consulta_id INT NOT NULL,
	fk_Resultado_retorno_Id INT NOT NULL,
	fk_Resultado_exame_Id INT NOT NULL
);


CREATE TABLE Agenda_exame(
	ID_Agenda_exame INT NOT NULL PRIMARY KEY,
    Data_Hora DATE NOT NULL,
	Valor INT NOT NULL,
	fk_Paciente_Id INT NOT NULL,
	fk_Laboratorio_Id INT NOT NULL,
    fk_Exame_Id INT NOT NULL
);


CREATE TABLE Laboratorio(
	ID_Laboratorio INT NOT NULL PRIMARY KEY,
	fk_Agenda_exame_Id INT NOT NULL,
	fk_Resultado_exame_Id INT NOT NULL,
	fk_Contrato_Id INT NOT NULL,
	fk_Cobre_Id INT
);


CREATE TABLE Contrato (
	ID_Contrato INT NOT NULL PRIMARY KEY,
	Data_expiracao DATE NOT NULL,
	fk_Laboratorio_Id INT NOT NULL,
	fk_Holding_Id INT NOT NULL
);


CREATE TABLE Holding (
	ID_Holding INT NOT NULL PRIMARY KEY,
	fk_Contrato_Id INT NOT NULL
);


CREATE TABLE Cobre (
	ID_Cobre INT NOT NULL PRIMARY KEY,
	fk_Laboratorio_Id INT CONSTRAINT single_Lab_Id UNIQUE,
	fk_Exame_Id INT CONSTRAINT single_Exame_Id Unique
);


CREATE TABLE Resultado_exame (
	ID_Resultado_exame INT NOT NULL PRIMARY KEY,
    fk_Paciente_Id INT NOT NULL,
    fk_Exame_Id INT NOT NULL, 
	fk_Laboratorio_Id INT NOT NULL,	
	fk_Resultado_Id INT NOT NULL
);


CREATE TABLE Resultado (
    ID_Resultado INT NOT NULL PRIMARY KEY,
	Tipo VARCHAR(100),
    Descricao VARCHAR(400),
    Descricao_pedido VARCHAR(350),
	fk_Resultado_exame INT NOT NULL
);


ALTER TABLE Alas add
	CONSTRAINT FK_Alas_Hospital FOREIGN KEY (fk_Hospital_Id) REFERENCES Hospital (ID_Hospital);
ALTER TABLE Alas add
	CONSTRAINT FK_Alas_Ala_consultas FOREIGN KEY (fk_Ala_consultas) REFERENCES Ala_consultas (ID_Ala_consultas);
ALTER TABLE Alas add
	CONSTRAINT FK_Alas_Ala_operados FOREIGN KEY (fk_Ala_operados_Id) REFERENCES Ala_operados (ID_Ala_operados);
ALTER TABLE Alas add
	CONSTRAINT FK_Alas_Ala_internados FOREIGN KEY (fk_Ala_internados_Id) REFERENCES Ala_internados (ID_Ala_internados);
ALTER TABLE Alas add
	CONSTRAINT FK_Alas_Trabalha_em FOREIGN KEY (fk_Trabalha_em) REFERENCES Trabalha_em (fk_Alas_Id);

ALTER TABLE Ala_consultas add
	CONSTRAINT FK_Ala_consultas_Sala_atendimento FOREIGN KEY (fk_Sala_atendimento_Id) REFERENCES Sala_atendimento (ID_Sala_atendimento);
ALTER TABLE Ala_consultas add
	CONSTRAINT FK_Ala_consultas_Alas FOREIGN KEY (fk_Alas_Id) REFERENCES Alas (ID_Alas);

ALTER TABLE Ala_operados add
	CONSTRAINT FK_Ala_operados_Sala_operacoes FOREIGN KEY (fk_Sala_operacoes_Id) REFERENCES Sala_operacoes (ID_Sala_operacoes);
ALTER TABLE Ala_operados add
	CONSTRAINT FK_Ala_operados_Alas FOREIGN KEY (fk_Alas_Id) REFERENCES Alas (ID_Alas);

ALTER TABLE Ala_internados add
	CONSTRAINT FK_Ala_internados_Leito FOREIGN KEY (fk_Leito_Id) REFERENCES Leito (ID_Leito);
ALTER TABLE Ala_internados add
	CONSTRAINT FK_Ala_internados_Alas FOREIGN KEY (fk_Alas_Id) REFERENCES Alas (ID_Alas);

ALTER TABLE Sala_atendimento add
	CONSTRAINT FK_Sala_atendimento_Ala_consultas FOREIGN KEY (fk_Ala_consultas_Id) REFERENCES Ala_consultas (ID_Ala_consultas);
ALTER TABLE Sala_atendimento add
	CONSTRAINT FK_Sala_atendimento_Resultado_consulta FOREIGN KEY (fk_Resultado_consulta_Id) REFERENCES Resultado_consulta (ID_Resultado_consulta);

ALTER TABLE Sala_operacoes add
	CONSTRAINT FK_Sala_operacoes_Especialidade FOREIGN KEY (fk_Especialidade_Id) REFERENCES Especialidade (ID_Especialidade);
ALTER TABLE Sala_operacoes add
	CONSTRAINT FK_Sala_operacoes_Andar FOREIGN KEY (fk_Andar_Id) REFERENCES Andar (ID_Andar);
ALTER TABLE Sala_operacoes add
	CONSTRAINT FK_Sala_operacoes_Ala_operados FOREIGN KEY (fk_Ala_operados_id) REFERENCES Ala_operados (ID_Ala_operados);

ALTER TABLE Leito add
    CONSTRAINT FK_Leito_Andar FOREIGN KEY (fk_Andar_Id) REFERENCES Andar (ID_Andar);
ALTER TABLE Leito add
	CONSTRAINT FK_Leito_Ala_internados FOREIGN KEY (fk_Ala_internados_id) REFERENCES Ala_internados (ID_Ala_internados);
ALTER TABLE Leito add
	CONSTRAINT FK_Leito_Agendamento FOREIGN KEY (fk_Agendamento_Id) REFERENCES Agendamento (ID_Agendamento);

ALTER TABLE Andar add
	CONSTRAINT FK_Andar_Leito FOREIGN KEY (fk_Leito_Id) REFERENCES Leito (ID_Leito);
ALTER TABLE Andar add
	CONSTRAINT FK_Andar_Sala_operacoes FOREIGN KEY (fk_Sala_operacoes_Id) REFERENCES Sala_operacoes (ID_Sala_operacoes);

ALTER TABLE Hospital add
	CONSTRAINT fk_Hospital_Alas FOREIGN KEY (fk_Alas_Id) REFERENCES Alas (ID_Alas);
ALTER TABLE Hospital add
	CONSTRAINT fk_Hospital_Funcionario FOREIGN KEY (fk_Funcionario_Id) REFERENCES Funcionario (ID_Funcionario);

ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Endereco FOREIGN KEY (fk_Endereco_Id) REFERENCES Endereco (ID_Endereco);
ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Enfermeiro FOREIGN KEY (fk_Enfermeiro_Id) REFERENCES Enfermeiro (ID_Enfermeiro);
ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Medico FOREIGN KEY (fk_Medico_Id) REFERENCES Medico (ID_Medico);
ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Tecnico FOREIGN KEY (fk_Tecnico_Id) REFERENCES Tecnico (ID_Tecnico);
ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Hospital FOREIGN KEY (fk_Hospital_Id) REFERENCES Hospital (ID_Hospital);
ALTER TABLE Funcionario add
	CONSTRAINT FK_Funcionario_Trabalha_em FOREIGN KEY (fk_Trabalha_em_Id) REFERENCES Trabalha_em (fk_Funcionario_Id);

ALTER TABLE Especialidade add
	CONSTRAINT FK_Especialidade_Medico FOREIGN KEY (fk_Medico_Id) REFERENCES Medico (ID_Medico);
ALTER TABLE Especialidade add
	CONSTRAINT FK_Especialidade_Sala_operacoes FOREIGN KEY (fk_Sala_operacoes_Id) REFERENCES Sala_operacoes (ID_Sala_operacoes);

ALTER TABLE Tecnico add
	CONSTRAINT FK_Tecnico_Funcionario FOREIGN KEY (fk_Funcionario_Id) REFERENCES Funcionario (ID_Funcionario);

ALTER TABLE Enfermeiro add
	CONSTRAINT FK_Enfermeiro_Prof_saude FOREIGN KEY (fk_Prof_saude_Id) REFERENCES Prof_saude (ID_Prof_saude);

ALTER TABLE Medico add
	CONSTRAINT FK_Medico_Prof_saude FOREIGN KEY (fk_Prof_saude_Id) REFERENCES Prof_saude (ID_Prof_saude);
ALTER TABLE Medico add
	CONSTRAINT FK_Medico_Especialidade FOREIGN KEY (fk_Especialidade_Id) REFERENCES Especialidade (ID_Especialidade);

ALTER TABLE Prof_saude add
	CONSTRAINT FK_Prof_saude_Funcionario FOREIGN KEY (fk_Funcionario_Id) REFERENCES Funcionario (ID_Funcionario);
ALTER TABLE Prof_saude add
	CONSTRAINT FK_Prof_saude_Medico FOREIGN KEY (fk_Medico_Id) REFERENCES Medico (ID_Medico);
ALTER TABLE Prof_saude add
	CONSTRAINT FK_Prof_saude_Enfermeiro FOREIGN KEY (fk_Enfermeiro_Id) REFERENCES Enfermeiro (ID_Enfermeiro);
ALTER TABLE Prof_saude add
	CONSTRAINT FK_Prof_saude_Substitui FOREIGN KEY (fk_Substitui_Id) REFERENCES Substitui (fk_Prof_saude_substituido_Id);
ALTER TABLE Prof_saude add
	CONSTRAINT FK_Prof_saude_Substituido FOREIGN KEY (fk_Substituido_Id) REFERENCES Substitui (fk_Prof_saude_suplente_Id);

ALTER TABLE Substitui add
	CONSTRAINT FK_Prof_saude_substituido FOREIGN KEY (fk_Prof_saude_substituido_Id) REFERENCES Prof_saude (ID_Prof_saude);
ALTER TABLE Substitui add
	CONSTRAINT FK_Prof_saude_suplente FOREIGN KEY (fk_Prof_saude_suplente_Id) REFERENCES Prof_saude (ID_Prof_saude);

ALTER TABLE Trabalha_em add
	CONSTRAINT FK_Trabalha_em_Funcionario FOREIGN KEY (fk_Funcionario_Id) REFERENCES Funcionario (ID_Funcionario);
ALTER TABLE Trabalha_em add
	CONSTRAINT FK_Trabalha_em_Alas FOREIGN KEY (fk_Alas_Id) REFERENCES Alas (ID_Alas);

ALTER TABLE Agendamento add
	CONSTRAINT FK_Agendamento_Leito FOREIGN KEY (fk_Leito_Id) REFERENCES Leito (ID_Leito);
ALTER TABLE Agendamento add
	CONSTRAINT FK_Agendamento_Internacao FOREIGN KEY (fk_Internacao_Id) REFERENCES Internacao (ID_Internacao);

ALTER TABLE Internacao add
	CONSTRAINT fk_Internacao_Agendamento FOREIGN KEY (fk_Agendamento_Id) REFERENCES Agendamento (ID_Agendamento);
ALTER TABLE Internacao add
	CONSTRAINT fk_Internacao_Solicitacao FOREIGN KEY (fk_Solicitacao_Id) REFERENCES Solicitacao (ID_Solicitacao);

ALTER TABLE Solicitacao add
	CONSTRAINT fk_Solicitacao_Internacao FOREIGN KEY (fk_Internacao_Id) REFERENCES Internacao (ID_Internacao);
ALTER TABLE Solicitacao add
	CONSTRAINT fk_Solicitacao_Resultado_retorno FOREIGN KEY (fk_Resultado_retorno_Id) REFERENCES Resultado_retorno (ID_Resultado_retorno);

ALTER TABLE Resultado_retorno add
	CONSTRAINT FK_Resultado_retorno_Paciente FOREIGN KEY (fk_Paciente_Id) REFERENCES Paciente (ID_Paciente);
ALTER TABLE Resultado_retorno add
	CONSTRAINT FK_Resultado_retorno_Resultado_consulta FOREIGN KEY (fk_Resultado_consulta_id) REFERENCES Resultado_consulta (ID_Resultado_consulta);
ALTER TABLE Resultado_retorno add
	CONSTRAINT FK_Resultado_retorno_Medico FOREIGN KEY (fk_Medico_Id) REFERENCES Medico (ID_Medico);
ALTER TABLE Resultado_retorno add
	CONSTRAINT FK_Resultado_retorno_Solicitacao FOREIGN KEY (fk_Solicitacao_Id) REFERENCES Solicitacao (ID_Solicitacao);

ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Paciente FOREIGN KEY (fk_Paciente_Id) REFERENCES Paciente (ID_Paciente);
ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Sala_atendimento FOREIGN KEY (fk_Sala_Atendimento_Id) REFERENCES Sala_atendimento (ID_Sala_atendimento);
ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Medico FOREIGN KEY (fk_Medico_Id) REFERENCES Medico (ID_Medico);
ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Requere FOREIGN KEY (fk_Requere_Id) REFERENCES Requere (ID_Requere);
ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Emite FOREIGN KEY (fk_Emite_Id) REFERENCES Emite (ID_Emite);
ALTER TABLE Resultado_consulta add
	CONSTRAINT FK_Resultado_consulta_Resultado_retorno FOREIGN KEY (fk_Resultado_retorno_Id) REFERENCES Resultado_retorno (ID_Resultado_retorno);

ALTER TABLE Emite add
	CONSTRAINT FK_Emite_Diagnostico FOREIGN KEY (fk_Diagnostico_Id) REFERENCES Diagnostico (ID_Diagnostico);
ALTER TABLE Emite add
	CONSTRAINT FK_Emite_Resultado_consulta FOREIGN KEY (fk_Resultado_consulta_Id) REFERENCES Resultado_consulta (ID_Resultado_consulta);

ALTER TABLE Diagnostico add
	CONSTRAINT FK_Diagnostico_Emite FOREIGN KEY (fk_Emite_Id) REFERENCES Emite (ID_Emite);

ALTER TABLE Requere add
	CONSTRAINT FK_Requere_Exame FOREIGN KEY (fk_Exame_Id) REFERENCES Exame (ID_Exame);
ALTER TABLE Requere add
	CONSTRAINT FK_Requere_Resultado_consulta FOREIGN KEY (fk_Resultado_consulta_Id) REFERENCES Resultado_consulta (ID_Resultado_consulta);

ALTER TABLE Exame add
	CONSTRAINT FK_Exame_Resultado_exame FOREIGN KEY (fk_Resultado_exame_Id) REFERENCES Resultado_exame (ID_Resultado_exame);
ALTER TABLE Exame add
	CONSTRAINT FK_Exame_Agenda FOREIGN KEY (fk_Agenda_Id) REFERENCES Agenda_exame (ID_Agenda_exame);
ALTER TABLE Exame add
	CONSTRAINT FK_Exame_Requere FOREIGN KEY (fk_Requere_Id) REFERENCES Requere (ID_Requere);
ALTER TABLE Exame add
	CONSTRAINT FK_Exame_Cobre FOREIGN KEY (fk_Cobre_Id) REFERENCES Cobre (fk_Exame_Id);

ALTER TABLE Paciente add
	CONSTRAINT FK_Paciente_Endereco FOREIGN KEY (fk_Endereco_Id) REFERENCES Endereco (ID_Endereco);
ALTER TABLE Paciente add
	CONSTRAINT FK_Paciente_Agenda_exame FOREIGN KEY (fk_Agenda_exame_Id) REFERENCES Agenda_exame (ID_Agenda_exame);
ALTER TABLE Paciente add
	CONSTRAINT FK_Paciente_Resultado_consulta FOREIGN KEY (fk_Resultado_consulta_id) REFERENCES Resultado_consulta (ID_Resultado_consulta);
ALTER TABLE Paciente add
	CONSTRAINT FK_Paciente_Resultado_retorno FOREIGN KEY (fk_Resultado_retorno_Id) REFERENCES Resultado_retorno (ID_Resultado_retorno);
ALTER TABLE Paciente add
	CONSTRAINT FK_Paciente_Resultado_exame FOREIGN KEY (fk_Resultado_exame_Id) REFERENCES Resultado_exame (ID_Resultado_exame);

ALTER TABLE Agenda_exame add
	CONSTRAINT FK_Agenda_Paciente FOREIGN KEY (fk_Paciente_Id) REFERENCES Paciente (ID_Paciente);
ALTER TABLE Agenda_exame add
	CONSTRAINT FK_Agenda_Lab FOREIGN KEY (fk_Laboratorio_Id) REFERENCES Laboratorio (ID_Laboratorio);
ALTER TABLE Agenda_exame add
	CONSTRAINT FK_Agenda_Exame FOREIGN KEY (fk_Exame_Id) REFERENCES Exame (ID_Exame);

ALTER TABLE Laboratorio add
	CONSTRAINT FK_Laboratorio_Agenda_exame FOREIGN KEY (fk_Agenda_exame_Id) REFERENCES Agenda_exame (ID_Agenda_exame);
ALTER TABLE Laboratorio add
	CONSTRAINT FK_Laboratorio_Resultado_exame FOREIGN KEY (fk_Resultado_exame_Id) REFERENCES Resultado_exame (ID_Resultado_exame);
ALTER TABLE Laboratorio add
	CONSTRAINT FK_Laboratorio_Contrato FOREIGN KEY (fk_Contrato_Id) REFERENCES Contrato (ID_Contrato);
ALTER TABLE Laboratorio add
	CONSTRAINT FK_Laboratorio_Cobre FOREIGN KEY (fk_Cobre_Id) REFERENCES Cobre (fk_Laboratorio_Id);

ALTER TABLE Contrato add
	CONSTRAINT FK_Contrato_Laboratorio FOREIGN KEY (fk_Laboratorio_Id) REFERENCES Laboratorio (ID_Laboratorio);
ALTER TABLE Contrato add
	CONSTRAINT FK_Contrato_Holding FOREIGN KEY (fk_Holding_Id) REFERENCES Holding (ID_Holding);

ALTER TABLE Holding add
	CONSTRAINT FK_Hold_Contrato FOREIGN KEY (fk_Contrato_Id) REFERENCES Contrato (ID_Contrato);

ALTER TABLE Cobre add
	CONSTRAINT FK_Cobre_Laboratorio FOREIGN KEY (fk_Laboratorio_Id) REFERENCES Laboratorio (ID_Laboratorio);	
ALTER TABLE Cobre add
	CONSTRAINT FK_Cobre_Exame FOREIGN KEY (fk_Exame_Id) REFERENCES Exame (ID_Exame);	

ALTER TABLE Resultado_exame add
	CONSTRAINT FK_Realiza_Exame_Paciente FOREIGN KEY (fk_Paciente_Id) REFERENCES Paciente (ID_Paciente);
ALTER TABLE Resultado_exame add
	CONSTRAINT FK_Realiza_Exame_Exame FOREIGN KEY (fk_Exame_Id) REFERENCES Exame (ID_Exame);
ALTER TABLE Resultado_exame add
	CONSTRAINT FK_Realiza_Exame_Laboratorio FOREIGN KEY (fk_Laboratorio_Id) REFERENCES Laboratorio (ID_Laboratorio);
ALTER TABLE Resultado_exame add
	CONSTRAINT FK_Realiza_Exame_Resultado FOREIGN KEY (fk_Resultado_Id) REFERENCES Resultado (ID_Resultado);

ALTER TABLE Resultado add
	CONSTRAINT FK_Resultado_Resultado_exame FOREIGN KEY (fk_Resultado_exame) REFERENCES Resultado_exame (ID_Resultado_exame);
