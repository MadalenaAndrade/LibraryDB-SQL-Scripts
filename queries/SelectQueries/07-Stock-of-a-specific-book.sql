--Stock of a specific book
SELECT Book.Title, BookStock.TotalAmount, BookStock.AvailableAmount
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookStock AS BookStock
	ON Book.SerialNumber = BookStock.SerialNumber
	WHERE Book.Title = N'O Memorial do Convento'