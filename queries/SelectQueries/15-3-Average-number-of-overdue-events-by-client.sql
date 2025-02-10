-- Average number of overdue events by client
SELECT Client.Name, SUM(CASE WHEN DATEDIFF(dd, Rent.Duedate, RentReception.ReturnDate) > 0 THEN 1 ELSE 0 END) AS DelayedOccurrences
FROM LibraryHub.Client as Client
JOIN LibraryHub.Rent AS Rent
	ON Client.ID = Rent.ClientID
JOIN LibraryHub.RentReception AS RentReception
    ON Rent.ID = RentReception.RentID
GROUP BY Client.Name;