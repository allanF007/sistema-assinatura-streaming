
CREATE DATABASE IF NOT EXISTS streaming_db;
USE streaming_db;

CREATE TABLE IF NOT EXISTS planos (
    id_plano INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_dias INT NOT NULL
);

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS assinaturas (
    id_assinatura INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    status ENUM('ativo', 'cancelado', 'suspenso') DEFAULT 'ativo',
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_plano) REFERENCES planos(id_plano)
);

INSERT INTO planos (nome, preco, duracao_dias) VALUES
    ('Básico', 19.90, 30),
    ('Premium', 29.90, 30),
    ('Família', 39.90, 30);
DELIMITER //
    
CREATE PROCEDURE renovar_assinatura(IN assinatura_id INT)
BEGIN
    UPDATE assinaturas 
    SET data_fim = DATE_ADD(data_fim, INTERVAL 30 DAY)
    WHERE id_assinatura = assinatura_id;
END //
DELIMITER ;

SELECT u.nome, u.email, p.nome AS plano, a.data_fim
FROM usuarios u
JOIN assinaturas a ON u.id_usuario = a.id_usuario
JOIN planos p ON a.id_plano = p.id_plano
WHERE a.data_fim BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
AND a.status = 'ativo';
