-- MySQL
-- DROP FUNCTION IF EXISTS NUMERIC_ONLY;

-- DELIMITER //
-- CREATE FUNCTION NUMERIC_ONLY (val VARCHAR(255))
--   RETURNS VARCHAR(255)
--   BEGIN
--     DECLARE idx, len INT DEFAULT 1;
--     DECLARE res VARCHAR(255) DEFAULT "";
--     DECLARE c VARCHAR(1) DEFAULT "";
--     IF ISNULL(val) THEN RETURN NULL; END IF;
--     IF LENGTH(val) = 0 THEN RETURN ""; END IF;
--
--     SET len = LENGTH(val);
--     WHILE idx <= len DO
--       SET c = SUBSTRING(val,idx,1);
--       IF IS_NUMERIC(c) = 1 THEN
--         SET res = CONCAT(res, c);
--       END IF;
--       SET idx = idx + 1;
--     END WHILE;
--   RETURN res;
-- END//
-- DELIMITER ;

-- Postgres
CREATE OR REPLACE FUNCTION numeric_only (val VARCHAR(255))
  RETURNS VARCHAR(255) AS $$
    DECLARE
      idx INT := 1;
      len INT := 1;
      res VARCHAR(255) := '';
      c VARCHAR(1) := '';
    BEGIN
     IF val IS NULL THEN RETURN NULL; END IF;
     IF LENGTH(val) = 0 THEN RETURN ''; END IF;

     len := LENGTH(val);
     WHILE idx <= len LOOP
       c := SUBSTRING(val FROM idx FOR 1);
       IF IS_NUMERIC(c) = 1 THEN
         res := CONCAT(res, c);
       END IF;
       idx := idx + 1;
     END LOOP;
   RETURN res;
 END $$ LANGUAGE 'plpgsql';