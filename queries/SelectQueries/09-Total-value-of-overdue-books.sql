-- Total value of overdue books
SELECT SUM(DATEDIFF(dd, Rent.duedate, GETDATE())*Book.FinePerDay) AS TotalOverdueFine
FROM LibraryHub.Rent AS Rent
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
JOIN LibraryHub.BookCopy AS BookCopy
	ON Rent.BookCopyID = BookCopy.ID
JOIN LibraryHub.Book AS Book
	ON BookCopy.SerialNumber = Book.SerialNumber
WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;