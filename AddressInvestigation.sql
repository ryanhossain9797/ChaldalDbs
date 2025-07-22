WITH MostRecentUnableToResolve AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY ClientAddressId
            ORDER BY RequestedOn DESC
        ) AS rn
    FROM mapping.AddressToBeResolved
    WHERE Status = 'UnableToResolve'
)
SELECT TOP 10 *
FROM MostRecentUnableToResolve
WHERE rn = 1;