SELECT * FROM mapping.AddressToBeResolved WHERE ClientRequestId = 'd8612e1b-7133-4b11-9b9b-d4de897ca3e7'
SELECT * FROM dbo.Address WHERE ClientRequestId = 'd8612e1b-7133-4b11-9b9b-d4de897ca3e7'
SELECT * FROM dbo.Address WHERE Id = 787759

SELECT * FROM dbo.Address FOR SYSTEM_TIME ALL WHERE Id = 787759 AND SysEnd = '2025-06-02 05:43:06.82' ORDER BY SysStart DESC

SELECT * FROM dbo.Customer WHERE Id = 33181634

SELECT * FROM dbo.Address FOR SYSTEM_TIME ALL WHERE Id = 787759 AND SysEnd = '2025-06-02 05:43:06.82' ORDER BY SysStart DESC

