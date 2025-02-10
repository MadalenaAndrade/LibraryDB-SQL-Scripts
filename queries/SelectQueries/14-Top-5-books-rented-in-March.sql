-- Top 5 books rented in March
SELECT TOP(5) WITH TIES Book.Title, COUNT(Book.SerialNumber) AS TimesRented 
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookCopy AS BookCopy
	ON Book.SerialNumber = BookCopy.SerialNumber
JOIN LibraryHub.Rent AS Rent
	ON BookCopy.ID = Rent.BookCopyID
WHERE MONTH(Rent.StartDate) = 3
GROUP BY Book.Title
ORDER BY COUNT(Book.SerialNumber) DESC;