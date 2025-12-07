
WITH
    `seeddata` AS (
    SELECT
        CURRENT_DATE
                AS `date_column`
    )
SELECT
    `date_column`,
    CAST(100 AS DATE)
            AS `date_column_1`,
    CAST(200 AS DATE)
            AS `date_column_2`,
    CAST(300.0 AS DATE)
            AS `date_column_3`,
    CAST(400.0 AS DATE)
            AS `date_column_4`
FROM
    `seeddata`
;
