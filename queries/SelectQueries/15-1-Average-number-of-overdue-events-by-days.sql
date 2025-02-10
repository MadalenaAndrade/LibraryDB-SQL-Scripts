-- Average number of overdue events (I calculated average days of books overdue)
SELECT AVG(DATEDIFF(dd, Rent.Duedate, GETDATE())) AS AverageOcurrencesDays
FROM LibraryHub.Rent AS Rent
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;