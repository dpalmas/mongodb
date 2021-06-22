CREATE TABLE alunos (id INTEGER PRIMARY KEY AUTO_INCREMENT, nome VARCHAR(255), data_nascimento DATE, cursos_id INTEGER);
CREATE TABLE cursos (id INTEGER PRIMARY KEY AUTO_INCREMENT, nome VARCHAR(255));
CREATE TABLE notas (id INTEGER PRIMARY KEY AUTO_INCREMENT, nota DECIMAL(3, 2), aluno_id INTEGER);
CREATE TABLE habilidades (id INTEGER PRIMARY KEY AUTO_INCREMENT, nome VARCHAR(255), nivel VARCHAR(255), aluno_id INTEGER);

INSERT INTO alunos VALUES (1, "Felipe", "19940226");

SELECT * FROM alunos WHERE nome = "Felipe";

SELECT 
    h.aluno_id 
FROM 
    habilidades h 
        JOIN alunos a ON (a.id = h.aluno_id)
WHERE 
    h.nome = "Inglês" 
    AND a.nome = "Felipe";

UPDATE curso SET nome = "Sistemas de Informação" WHERE nome = "Sistema de Informação";