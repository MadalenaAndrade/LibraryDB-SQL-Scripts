-- Stock of overdue books
-- Used the view OverdueBookCopyID with only the overdue books
SELECT DISTINCT Book.Title, BookStock.TotalAmount, BookStock.AvailableAmount
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookStock AS BookStock
	ON Book.SerialNumber = BookStock.SerialNumber
JOIN LibraryHub.BookCopy AS BookCopy
	ON BookStock.SerialNumber = BookCopy.SerialNumber
WHERE BookCopy.Id IN (SELECT BookCopyID FROM dbo.OverdueBookCopyID);