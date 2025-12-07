
WITH
    `seeddate` AS (
    SELECT
        DATE '1994-04-19'
                AS `date_start`,
        CURRENT_DATE()
                AS `date_end`
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
    TRUNC(`date_start` INTERVAL -1 YEAR,'YEAR')
            AS `date_start`,
    TRUNC(`date_end`   INTERVAL  2 YEAR,'YEAR')
            AS `date_end`
FROM
    `seeddate`
;
