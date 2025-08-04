SELECT
    'TRUNCATE TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + ';' AS TruncateStatement
FROM gis.INFORMATION_SCHEMA.TABLES
WHERE
    TABLE_SCHEMA = 'Gis'
    AND TABLE_NAME LIKE 'Building[_]%'
    AND TABLE_TYPE = 'BASE TABLE'  -- This ensures we only get actual tables, not views
ORDER BY TABLE_NAME;


SELECT TOP 10 * FROM gis.Gis.ChangeSuggestion