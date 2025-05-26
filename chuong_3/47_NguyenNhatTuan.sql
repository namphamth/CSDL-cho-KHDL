SELECT 
    (COUNT(*) * SUM(A * B) - SUM(A) * SUM(B)) / 
    (SQRT(COUNT(*) * SUM(A * A) - SUM(A) * SUM(A)) * 
    SQRT(COUNT(*) * SUM(B * B) - SUM(B) * SUM(B))) AS correlation_coefficient
FROM 
    your_table_name;