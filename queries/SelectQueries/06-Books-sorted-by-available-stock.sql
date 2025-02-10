--Books sorted by available stock
SELECT Book.Title, BookStock.AvailableAmount, BookStock.TotalAmount
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookStock AS BookStock
	ON Book.SerialNumber = BookStock.SerialNumber
ORDER BY BookStock.AvailableAmount DESC;