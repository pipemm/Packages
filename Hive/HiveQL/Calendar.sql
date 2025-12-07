
WITH
    `seeddata` AS (
    SELECT
        CURRENT_DATE
                AS `date_column`
    ),
    `seedspaces` AS (
    SELECT
        SPACE(10000-1)
                AS `spaces`
    ),
    `generatortable` AS (
    SELECT
        `ts`.`spaces`,
        `ta`.`aposition`, 
        `ta`.`avalue`
    FROM
        `seedspaces` `ts` -- table spaces
        LATERAL VIEW
        POSEXPLODE(SPLIT(`ts`.`spaces`,' ')) `ta`   -- table array
                AS `aposition`, `avalue`
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
