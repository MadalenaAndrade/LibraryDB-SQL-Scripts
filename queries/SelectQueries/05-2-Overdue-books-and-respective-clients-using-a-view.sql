--Overdue books and respective clients using a "view"
--In this case OverdueClients is a view with all the clients information that have overdue books 

SELECT Book.Title AS OverdueBook, OverdueClients.Name AS ClientName, OverdueClients.NIF AS ClientNIF, OverdueClients.Contact AS ClientContact, OverdueClients.Address AS ClientAddress
FROM dbo.OverdueClients AS OverdueClients
JOIN libraryhub.Rent AS Rent
	ON OverdueClients.ID = Rent.ClientID 
JOIN LibraryHub.BookCopy AS BookCopy
	ON Rent.BookCopyID = BookCopy.ID
JOIN LibraryHub.Book AS Book
	ON BookCopy.SerialNumber = Book.SerialNumber;