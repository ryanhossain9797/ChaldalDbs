# Common Info
All tables that have History tables can be queried using the FOR SYSTEM_TIME ALL syntax of msssql server, or only history excluding current state can be retrieved from the TableName_HISTORY table

# Address
- Inside the dbo.Address table
- Has a history table with Address_HISTORY
- History table columns are SysStart and SysEnd
- Has a HexagonId which is a foreign key to dbo.Hexagon.Id. Hexagon can be used to find the warehouse of the address
- Has a DeliveryAreaId which is a foreign key to dbo.DeliveryArea.Id. DeliveryArea can be used to find the Warehouse of the address as a fallback if the Hexagon is not present
- Has columns that denote it's actual location like MappingResolutionStatus, BuildingId, Latitude, Longitude
- The statuses are as follows
  0 = NotSent
  1 = Pending
  2 = Resolved
  3 = AlreadyResolved
  4 = UnableToResolve
  5 = ResolvedFromAdmin
  6 = EditedAndResolvedFromAdmin
  7 = EditedAndUnresolvedFromAdmin
  8 = ResolvedByCustomer
  9 = ReportedAsWrongMappingAndPending //deprecated

# Customer
- Inside the dbo.Customer table
- Has a history table with Customer_HISTORY
- Id the same as dbo.Employee.Id
- Has CustomerGuid as another unique identifier

# Employee
- Inside the dbo.Employee table
- Has a history table with Employee_HISTORY
- Id is the same as dbo.Customer.Id
- Has BadgeId as employee identifier
- A common use case is to Get CustomerGuid from BadgeId by joining dbo.Employee and dbo.Customer on their Id

# AddressToBeResolved
- Inside the mapping.AddressToBeResolved table
- Has a final resolution status in the Status column, This one is a string value unlike the dbo.Address table's Status column
- Has ClientAddressId -> String but Points to the dbo.Address table's Id
- Has a RequestedOn parameter that says when this was created

# Building
- Inside the mapping.Building table
- Has a Latitude and Longitude
- Is a History table with columns ValidFrom and ValidTo

# Hexagon
- We use Hexagons to figure out which Warehouse should deliver to the customer
- Inside the dbo.Hexagon table
- Has an Id
- Hexagons are a way to represent a small location on the map
- Each Hexagon Optionally belongs to a Warheouse via WarehouseId
- Has a HexagonRef that's a lat long represented as an offset
- Has a history table with Hexagon_HISTORY
- History table columns are SysStart and SysEnd

# DeliveryArea
- Inside the dbo.DeliveryArea table