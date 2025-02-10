-- Average (days) of late occurrences per month
SELECT YEAR(Rent.DueDate) AS Year,
    MONTH(Rent.DueDate) AS Month,
    AVG(DATEDIFF(dd, Rent.DueDate, RentReception.ReturnDate)) AS OverdueOcurrencesPerMonth
FROM LibraryHub.Rent AS Rent
JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
WHERE RentReception.ReturnDate > Rent.DueDate
GROUP BY YEAR(Rent.DueDate), MONTH(Rent.DueDate)
ORDER BY Year, Month;