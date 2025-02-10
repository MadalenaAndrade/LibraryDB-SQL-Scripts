--View with clients with overdue books and their information such as DueDate, original BookCondition and this FinePerDay

CREATE VIEW dbo.OverdueClientsInfo AS
SELECT Client.Name, Rent.DueDate, BookCopy.BookConditionID, Book.FinePerDay
FROM LibraryHub.Client AS Client 
JOIN LibraryHub.Rent AS Rent
	ON Client.ID = Rent.ClientID 
JOIN LibraryHub.BookCopy AS BookCopy 
	ON Rent.BookCopyID = BookCopy.ID 
JOIN LibraryHub.Book AS Book
	ON BookCopy.SerialNumber = Book.SerialNumber 
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
	WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;