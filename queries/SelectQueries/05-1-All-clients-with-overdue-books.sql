--All clients with overdue books
SELECT *
FROM LibraryHub.Client AS Client
WHERE Client.ID in (
	SELECT Rent.ClientID
	FROM LibraryHub.Rent AS Rent
	LEFT JOIN LibraryHub.RentReception AS RentReception
		ON Rent.ID = RentReception.RentID
	WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0
	);