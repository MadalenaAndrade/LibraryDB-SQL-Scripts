-- Occurrences of books delivered late by clients
SELECT Client.ID, Client.Name, COUNT(*) AS OverdueOcurrences
FROM LibraryHub.Client AS Client
JOIN LibraryHub.Rent AS Rent
	ON Client.ID = Rent.ClientID
JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
WHERE RentReception.ReturnDate > Rent.DueDate
GROUP BY Client.ID, Client.Name
ORDER BY Client.ID;