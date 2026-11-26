-- Создание таблицы для хранения заявок на лизинг
CREATE TABLE leasing_applications (
    application_id VARCHAR(50) PRIMARY KEY,
    client_first_name VARCHAR(100) NOT NULL,
    client_last_name VARCHAR(100) NOT NULL,
    passport_series VARCHAR(10) NOT NULL,
    passport_number VARCHAR(10) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    asset_type VARCHAR(50),
    asset_price DECIMAL(15, 2),
    currency VARCHAR(3),
    term_months INT,
    down_payment DECIMAL(15, 2),
    application_status VARCHAR(20), -- 'APPROVED', 'REJECTED', 'PENDING'
    score INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Пример запроса: Найти все одобренные заявки на сумму больше 40 000 BYN
SELECT 
    application_id, 
    client_first_name || ' ' || client_last_name AS client_name, 
    asset_price 
FROM 
    leasing_applications 
WHERE 
    application_status = 'APPROVED' 
    AND asset_price > 40000.00;