SELECT
  "i"
      AS "id",
  LEFT(MD5("i"::TEXT), 10)
      AS "hash"
FROM
  GENERATE_SERIES(1, 10) "s"("i")
;
