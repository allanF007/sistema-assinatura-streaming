-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS streaming_db;
USE streaming_db;

-- Tabela de Planos de Assinatura
CREATE TABLE IF NOT EXISTS planos (
    id_plano INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    duracao_dias INT NOT NULL
);

-- Tabela de Usuários
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_cadastro DATE NOT NULL
);

-- Tabela de Assinaturas
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

-- Inserção de dados de exemplo
INSERT INTO planos (nome, preco, duracao_dias) VALUES
    ('Básico', 19.90, 30),
    ('Premium', 29.90, 30),
    ('Família', 39.90, 30);
