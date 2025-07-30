DECLARE @Id INT = 3115602;

SELECT
    a.Id,
    SysStart,
    StreetAddress,
    WrongGeoTagReported,
    MappingResolutionStatus,
    BuildingId,
    a.Latitude,
    a.Longitude,
    da.Name AS DeliveryAreaName
FROM dbo.Address FOR SYSTEM_TIME ALL a
LEFT JOIN dbo.DeliveryArea da ON a.DeliveryAreaId = da.Id
WHERE a.Id = @Id
ORDER BY SysStart DESC


SELECT * FROM mapping.Building WHERE Id = 319747;

SELECT * FROM mapping.DeliveryArea WHERE Id = 1534;

SELECT * FROM mapping.Building FOR SYSTEM_TIME ALL WHERE Id = 319747 ORDER BY ValidFrom DESC;