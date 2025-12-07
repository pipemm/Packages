
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
        SPACE(100000-1)
                AS `spaces`
    ),
    `generatortable` AS (
    SELECT POSEXPLODE(SPLIT(SPACE(100000-1),' '))
                AS (`position`, `value`)
    ),
---------- SEED DATA -----------------------------------------------------------
--------------------------------------------------------------------------------
    `seedtable` AS (
    SELECT
        CAST(TRUNC(`seeddate`.`date_start` - INTERVAL 1 YEAR, 'YEAR') AS DATE)
                AS `date_start`,
        CAST(TRUNC(`seeddate`.`date_end`   + INTERVAL 2 YEAR, 'YEAR') AS DATE)
                AS `date_end`,
        `generatortable`.`position`
                AS `days`
    FROM
        `seeddate`, `generatortable`
    ),
    `datetable` AS (
    SELECT
        `date_start`,
        `date_end`,
        `date_start` + INTERVAL (`days`) DAY
                AS `date_column`
    FROM
        `seedtable`
    ),
    `calendartable` AS (
    SELECT
        `date_start`,
        `date_end`,
        CAST(`date_column` AS DATE)
                AS `date_column`,
        WEEKOFYEAR(`date_column`)
                AS `week_of_year`,
        EXTRACT(DAYOFWEEK from `date_column`)   
                AS `day_of_week`
    FROM
        `datetable`
    WHERE
        `date_column` BETWEEN `date_start` AND `date_end`
    )
SELECT
    `date_column`,
    `week_of_year`,
    `day_of_week`
FROM
    `calendartable`
ORDER BY
    `date_column` ASC
;
