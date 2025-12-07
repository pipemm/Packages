
WITH
    `seeddata` AS (
    SELECT
        CURRENT_DATE
                AS `date_column`
    )
SELECT
    `date_column`,
    CAST(`date_column` AS INT)
            AS `int_column`,
    CAST(`date_column` AS BIGINT)
            AS `bigint_column`
FROM
    `seeddata`
;
