--View only with overdue book ids
CREATE VIEW dbo.OverdueBookCopyID AS
SELECT Rent.BookCopyID
FROM LibraryHub.Rent AS Rent
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;