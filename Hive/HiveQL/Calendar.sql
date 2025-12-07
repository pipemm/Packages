
WITH
    `seeddata` AS (
    SELECT
        CAST(CURRENT_DATE AS INT) 
                AS `int_column`
    )
SELECT
    `int_column`
FROM
    `seeddata`
;
