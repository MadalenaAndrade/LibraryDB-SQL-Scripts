
EXEC AlterBookStock
	@SerialNumber = 9789720049568,          
    @OldConditionID = 4,         
    @NewConditionID = 1,            
    @Quantity = 1,
	@Notes = N''

SELECT * 
FROM LibraryHub.BookCopy
WHERE SerialNumber = 9789720049568
ORDER BY ID;