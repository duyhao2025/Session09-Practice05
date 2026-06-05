CREATE DATABASE procedure_sales_practice;

CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    sale_date DATE NOT NULL
);

INSERT INTO Sales (customer_id, amount, sale_date)
VALUES
(1, 500, '2025-01-05'),
(2, 700, '2025-01-10'),
(3, 1200, '2025-01-15'),
(1, 800, '2025-01-20'),
(2, 600, '2025-01-25');

CREATE OR REPLACE PROCEDURE calculate_total_sales(
    IN start_date DATE,
    IN end_date DATE,
    INOUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT COALESCE(SUM(amount), 0)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

CALL calculate_total_sales(
    '2025-01-01',
    '2025-01-31',
    0
);