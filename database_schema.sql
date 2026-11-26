-- 1. Таблица клиентов (справочник)
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    passport_series VARCHAR(10) NOT NULL,
    passport_number VARCHAR(10) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100)
);

-- 2. Таблица предметов лизинга (активов)
CREATE TABLE assets (
    asset_id INT PRIMARY KEY AUTO_INCREMENT,
    asset_type VARCHAR(50) NOT NULL,
    asset_price DECIMAL(15, 2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'BYN'
);

-- 3. Таблица заявок (связующая)
CREATE TABLE leasing_applications (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    asset_id INT NOT NULL,
    term_months INT,
    down_payment DECIMAL(15, 2),
    application_status VARCHAR(20) DEFAULT 'PENDING', -- 'APPROVED', 'REJECTED'
    score INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Внешние ключи (связи)
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (asset_id) REFERENCES assets(asset_id)
);

-- Пример запроса (JOIN), который теперь показывает мощь нормализации:
-- Найти все одобренные заявки с именами клиентов и ценой авто
SELECT 
    la.application_id,
    c.first_name || ' ' || c.last_name AS client_name,
    a.asset_price
FROM leasing_applications la
JOIN clients c ON la.client_id = c.client_id
JOIN assets a ON la.asset_id = a.asset_id
WHERE la.application_status = 'APPROVED' AND a.asset_price > 40000.00;