-- Average number of overdue events (books delivered after the deadline/total number of books delivered)
SELECT CAST(SUM(CASE WHEN DATEDIFF(dd, Rent.Duedate, RentReception.ReturnDate) > 0 THEN 1 ELSE 0 END) AS FLOAT)/COUNT(*) AS DelayedOcurrencesMean
FROM LibraryHub.Rent AS Rent
JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID;