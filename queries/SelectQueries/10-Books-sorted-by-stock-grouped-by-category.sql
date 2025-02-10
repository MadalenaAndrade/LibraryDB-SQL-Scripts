-- Books sorted by stock grouped by category
SELECT Category.Name, SUM(BookStock.TotalAmount) AS TotalAmount, SUM(BookStock.AvailableAmount) AS AvailableAmount
FROM LibraryHub.Category AS Category
JOIN LibraryHub.BookCategory AS BookCategory
	ON Category.ID = BookCategory.CategoryID
JOIN LibraryHub.Book AS Book
	ON BookCategory.SerialNumber = Book.SerialNumber
JOIN LibraryHub.BookStock AS BookStock
	ON Book.SerialNumber = BookStock.SerialNumber
GROUP BY Category.Name
ORDER BY AvailableAmount DESC;
