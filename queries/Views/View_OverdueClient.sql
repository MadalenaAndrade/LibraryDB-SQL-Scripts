--View with full information of clients with a book overdue
CREATE VIEW dbo.OverdueClients AS
SELECT Client.ID, Client.Name, Client.DateOfBirth, Client.NIF, Client.Contact, Client.Address
FROM     LibraryHub.Client AS Client
JOIN LibraryHub.Rent AS Rent
	ON Client.ID = Rent.ClientID 
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;