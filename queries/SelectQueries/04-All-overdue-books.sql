--All overdue books
SELECT BookCopy.ID AS BookCopyID, Book.Title
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookCopy AS BookCopy
	ON Book.SerialNumber = BookCopy.SerialNumber
	WHERE BookCopy.ID IN (
		SELECT Rent.BookCopyID
		FROM LibraryHub.Rent AS Rent
		LEFT JOIN LibraryHub.RentReception AS RentReception
			ON Rent.ID = RentReception.RentID
			WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0
		);