# Example SQL Queries

## Temporal Table Queries

### Address History with Smart Date Formatting

This query shows the history of an address with a smart date formatting approach that:
- Shows full datetime (yyyy-MM-dd HH:mm:ss) for the first occurrence of a date
- Shows only time (HH:mm:ss) for subsequent rows with the same date
- Aligns all times by padding with spaces for consistent formatting

```sql
WITH AddressChanges AS (    SELECT 
        Id,
        MappingResolutionStatus,
        BuildingId,
        SysStart,
        SysEnd
    FROM egg1.dbo.Address FOR SYSTEM_TIME ALL
    WHERE SysStart <> SysEnd
)
SELECT
    Id,
    SysStart,
    CASE MappingResolutionStatus
        WHEN 0 THEN 'NotSent'
        WHEN 1 THEN 'Pending'
        WHEN 2 THEN 'Resolved'
        WHEN 3 THEN 'AlreadyResolved'
        WHEN 4 THEN 'UnableToResolve'
        WHEN 5 THEN 'ResolvedFromAdmin'
        WHEN 6 THEN 'EditedAndResolvedFromAdmin'
        WHEN 7 THEN 'EditedAndUnresolvedFromAdmin'
        WHEN 8 THEN 'ResolvedByCustomer'
        WHEN 9 THEN 'ReportedAsWrongMappingAndPending'
    END AS [Status],
    BuildingId,SysEnd
FROM AddressChanges
WHERE Id = 5662116
ORDER BY SysEnd DESC;
```

#### How it works:
1. Uses a CTE to get previous row's dates using LAG function
2. Compares current row's date with previous row's date
3. If the date is the same as previous row, shows only time with padding
4. If the date is different, shows full datetime
5. Uses ORDER BY SysEnd ASC in LAG to ensure first occurrence of a date shows the full datetime
6. Final results are ordered by SysEnd DESC for most recent changes first

## Subject History Table Queries

### Subject History with Decoded Operations

This query retrieves the history of subject operations, decoding both the operation type and subject for readability. It also displays construction status, transition timestamps, the next scheduled timer run, and the next side effect sequence number.

- Uses `dbname.schemaname.decode` to translate ctor or action and subject bodies into descriptive text
- Shows whether the state is the initial constructed state
- Displays when the subject was last updated and when the next timer is set to run
- Orders results by the most recent subject update first

```sql
SELECT
    logistics.logistics.decode(Operation) AS CtorOrAction,
    logistics.logistics.decode(Subject) AS Subject,
    IsConstruction,
    SubjectlastUpdatedOn AS TransitionedOn,
    NextTickOn AS NextTimerRunOn,
    NextSideEffectSeqNumber
FROM logistics.Logistics.Work_HistoryWithCurrent
WHERE Id = '5662116'
ORDER BY SubjectLastUpdatedOn DESC;
```

## Snowflake Access Management

### Give Access To Roles
```sql
/*-----------------------------------------------------------------
  1) Let ENGINEERS “walk in the door” of the database & schema
------------------------------------------------------------------*/
GRANT USAGE ON DATABASE UNIVERSE            TO ROLE ENGINEERS;
GRANT USAGE ON SCHEMA   UNIVERSE.PK         TO ROLE ENGINEERS;
 
/*-----------------------------------------------------------------
  2) Read-only access to every object that exists *right now*
------------------------------------------------------------------*/
GRANT SELECT ON ALL TABLES        IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT SELECT ON ALL VIEWS         IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON ALL FUNCTIONS     IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON ALL PROCEDURES    IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON ALL SEQUENCES     IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
/* Add more object types if you use them (TASKS, STREAMS, FILE FORMATS …) */
 
/*-----------------------------------------------------------------
  3) Future-proof it—anything created later is granted automatically
------------------------------------------------------------------*/

GRANT SELECT ON FUTURE TABLES     IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT SELECT ON FUTURE VIEWS      IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON FUTURE FUNCTIONS  IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON FUTURE PROCEDURES IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
GRANT USAGE  ON FUTURE SEQUENCES  IN SCHEMA UNIVERSE.PK TO ROLE ENGINEERS;
```