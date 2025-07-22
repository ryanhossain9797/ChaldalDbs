                    WITH AddressBatch AS (
                        SELECT
                            A.Id,
                            A.Latitude,
                            A.Longitude
                        FROM
                            dbo.Address A
                        WHERE
                            A.Latitude IS NOT NULL
                            AND A.Longitude IS NOT NULL
                            AND A.BuildingId IS NULL
                            AND A.MappingResolutionStatus IN (2,3,5,6,8)
                    ),
                    BuildingCandidate AS (
                        SELECT
                            ab.Id AS AddressID,
                            b.Id AS BuildingId,
                            b.CentroidLocation.STDistance(geography::Point(ab.Latitude, ab.Longitude, 4326)) AS Dist
                        FROM AddressBatch ab
                        JOIN mapping.Building b ON
                            b.CenterLatitude > ab.Latitude - 0.000450
                            AND b.CenterLatitude < ab.Latitude + 0.000450
                            AND b.CenterLongitude > ab.Longitude - 0.000450
                            AND b.CenterLongitude < ab.Longitude + 0.000450
                            AND b.CentroidLocation IS NOT NULL
                    ),
                    BuildingCandidateMatch AS (
                        SELECT *
                        FROM (
                            SELECT *, ROW_NUMBER() OVER (PARTITION BY AddressID ORDER BY Dist ASC) AS rn
                            FROM BuildingCandidate
                        ) t
                        WHERE rn = 1
                    )
                    SELECT a.Id, cm.BuildingId
                    FROM BuildingCandidateMatch cm
                    JOIN dbo.Address a ON a.Id = cm.AddressID
                    WHERE a.BuildingId IS NULL