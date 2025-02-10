EXEC UpdateBookCondition
	@ID = 26,
	@BookConditionID = 2,
	@Notes = N'Minor shelf wear'

SELECT * 
FROM LibraryHub.BookCopy
WHERE ID = 26;