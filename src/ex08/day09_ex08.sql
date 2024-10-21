DROP FUNCTION IF EXISTS fnc_fibonacci ();

DROP FUNCTION IF EXISTS fnc_fibonacci_SQL();

CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop INTEGER DEFAULT 10)
RETURNS TABLE (fibonacci BIGINT) AS $$
DECLARE 
    a BIGINT := 0;
    b BIGINT := 1;
BEGIN
    WHILE a < pstop LOOP
        RETURN QUERY SELECT a;
        b := a + b;
        a := b - a;
    END LOOP;

    RETURN;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fnc_fibonacci_SQL(pstop INTEGER DEFAULT 10)
RETURNS TABLE (fibonacci BIGINT) AS $$
WITH RECURSIVE fib(n, a, b) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n + 1, b, a + b
    FROM fib
    WHERE a + b < pstop
)
SELECT a AS fibonacci
FROM fib
$$ LANGUAGE SQL;

SELECT * FROM fnc_fibonacci(20000);
SELECT * FROM fnc_fibonacci();

SELECT * FROM fnc_fibonacci_SQL(100);
SELECT * FROM fnc_fibonacci_SQL();