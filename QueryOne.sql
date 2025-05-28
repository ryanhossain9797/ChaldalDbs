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
AND SysEnd > '2025-05-13 16:18:51.77'
ORDER BY SysEnd DESC;


SELECT
    logistics.logistics.decode(Operation) AS CtorOrAction,
    logistics.logistics.decode(Subject) AS Subject,
    SubjectlastUpdatedOn AS TransitionedOn
FROM logistics.Logistics.Work_HistoryWithCurrent
WHERE Id = '27739528'
ORDER BY SubjectLastUpdatedOn DESC;