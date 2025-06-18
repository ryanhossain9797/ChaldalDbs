# Address
- Inside the dbo.Address table
- Has a history table with Address_HISTORY
- History table columns are SysStart and SysEnd
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
  9 = ReportedAsWrongMappingAndPending

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