
WITH
--------------------------------------------------------------------------------
---------- SEED DATA -----------------------------------------------------------
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
    SELECT POSEXPLODE(SPLIT(SPACE(10000-1),' '))
                AS (`position`, `value`)
    ),
---------- SEED DATA -----------------------------------------------------------
--------------------------------------------------------------------------------
    `seedtable` AS (
    SELECT
        TRUNC(`seeddate`.`date_start` - INTERVAL 1 YEAR, 'YEAR')
                AS `date_start`,
        TRUNC(`seeddate`.`date_end`   + INTERVAL 2 YEAR, 'YEAR')
                AS `date_end`,
        `generatortable`.`position`
                AS `days`
    FROM
        `seeddate`, `generatortable`
    )
SELECT
    `date_start`,
    `date_end`,
    `days`,
    `date_start` + INTERVAL (`days`) DAY
            AS `date_column`
FROM
    `seedtable`
ORDER BY
    `days` ASC
;
