-- Top 5 rented books
SELECT TOP(5) WITH TIES Book.Title, COUNT(Book.SerialNumber) AS TimesRented 
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookCopy AS BookCopy
	ON Book.SerialNumber = BookCopy.SerialNumber
JOIN LibraryHub.Rent AS Rent
	ON BookCopy.ID = Rent.BookCopyID
GROUP BY Book.Title
ORDER BY COUNT(Book.SerialNumber) DESC