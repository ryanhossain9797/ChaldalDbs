WITH MostRecentUnableToResolve AS (
    SELECT * FROM (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY ClientAddressId
                ORDER BY RequestedOn DESC
            ) AS rn
        FROM mapping.AddressToBeResolved
        WHERE Status = 'UnableToResolve'
    ) AS utr
    WHERE utr.rn = 1
)
SELECT TOP 1000 a.Id, ar.Status, a.MappingResolutionStatus
FROM MostRecentUnableToResolve ar
JOIN dbo.Address a ON ar.ClientAddressId = a.Id
AND a.MappingResolutionStatus = 2