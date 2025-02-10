--All books in one condition
SELECT BookCopy.ID AS BookCopyID, Book.Title
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookCopy AS BookCopy
	ON Book.SerialNumber = BookCopy.SerialNumber
JOIN LibraryHub.BookCondition AS BookCondition
	ON BookCopy.BookConditionID = BookCondition.ID
	WHERE BookCondition.Condition = N'Bad';