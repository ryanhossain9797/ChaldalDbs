DECLARE @Id INT = 5571832;

SELECT
    Id,
    SysStart,
    StreetAddress,
    WrongGeoTagReported,
    MappingResolutionStatus,
    BuildingId,
    Latitude,
    Longitude
FROM dbo.Address
FOR SYSTEM_TIME ALL 
WHERE Id = @Id
ORDER BY SysStart DESC