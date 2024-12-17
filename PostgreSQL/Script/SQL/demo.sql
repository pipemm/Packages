WITH 
  "datalist" AS (
  SELECT
    "i"
        AS "id",
    LEFT(MD5("i"::TEXT), 30)
        AS "hash",
    DATE '1999-06-09' + "i"
        AS "date"
  FROM
    GENERATE_SERIES(1, 10) "s"("i")
  )
SELECT
  "id",
  "hash",
  "date"
FROM 
  "datalist"
ORDER BY
  "id"
;
