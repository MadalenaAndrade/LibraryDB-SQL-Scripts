-- Rented books sorted by stock grouped by category
-- obs. I created a temporary table instead of using views that already exist to try out this functionality

SELECT DISTINCT BookCopy.SerialNumber
INTO LibraryHub.#RentedBook
FROM LibraryHub.BookCopy AS BookCopy
JOIN LibraryHub.Rent AS Rent
	ON BookCopy.ID = Rent.BookCopyID
LEFT JOIN LibraryHub.RentReception AS RentReception
	ON Rent.ID = RentReception.RentID
	WHERE RentReception.RentID IS NULL AND DATEDIFF(dd, Rent.DueDate, GETDATE()) > 0;
GO

SELECT Category.Name, SUM(BookStock.TotalAmount) AS TotalAmount, SUM(BookStock.AvailableAmount) AS AvailableAmount
FROM LibraryHub.Category AS Category
JOIN LibraryHub.BookCategory AS BookCategory
	ON Category.ID = BookCategory.CategoryID
JOIN LibraryHub.#RentedBook AS RentedBook
	ON BookCategory.SerialNumber = RentedBook.SerialNumber
JOIN LibraryHub.BookStock AS BookStock
	ON RentedBook.SerialNumber = BookStock.SerialNumber
GROUP BY Category.Name
ORDER BY AvailableAmount DESC;
GO

DROP TABLE LibraryHub.#RentedBook