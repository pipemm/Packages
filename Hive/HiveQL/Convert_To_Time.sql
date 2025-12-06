
WITH
    `seeddata` AS (
    SELECT
        CAST(1704067200001 AS BIGINT)
                AS `bigint_column`
    UNION ALL
    SELECT
        CAST(1709164800001 AS BIGINT)
                AS `bigint_column`
    ),
    `datecolumns` AS (
    SELECT 
        --CAST(`bigint_column` AS TIMESTAMP)
        --        AS `date_column_1`,
        --CAST(`bigint_column` / 1000.0 AS TIMESTAMP)
        --        AS `date_column_2`,
        CAST(FROM_UNIXTIME(`bigint_column` DIV 1000) AS TIMESTAMP)
                AS `date_column_3`,
        CAST(FROM_UNIXTIME(`bigint_column` DIV 1000) AS DATE)
                AS `date_column_4`,
        TO_UTC_TIMESTAMP(`bigint_column`,'UTC')
                AS `date_column_5`
    FROM 
        `seeddata`
    )
SELECT 
    --`date_column_1`,
    --`date_column_2`,
    `date_column_3`,
    `date_column_4`,
    `date_column_5`
FROM 
    `datecolumns`
;
