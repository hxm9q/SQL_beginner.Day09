DROP FUNCTION IF EXISTS func_minimum (VARIADIC arr NUMERIC[]);

DROP FUNCTION IF EXISTS func_minimum_SQL (VARIADIC arr NUMERIC[]);

CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr NUMERIC[])
RETURNS NUMERIC AS $$
DECLARE 
    min_val NUMERIC;
BEGIN
    min_val := arr[1];

    FOR i IN 2..array_length(arr, 1) LOOP
        IF arr[i] < min_val THEN
            min_val := arr[i];
        END IF;
    END LOOP;

    RETURN min_val;    
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION func_minimum_SQL(VARIADIC arr NUMERIC[])
RETURNS NUMERIC AS $$
    SELECT MIN(x)
    FROM unnest(arr) AS x;
$$ LANGUAGE SQL;

SELECT func_minimum ( VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4] );

SELECT func_minimum_SQL (
        VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]
    );

SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, -5.0, 5.0, 4.4]);





