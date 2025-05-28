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
