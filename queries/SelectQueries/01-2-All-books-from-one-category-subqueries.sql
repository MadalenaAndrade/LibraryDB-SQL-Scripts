--All books from one category
SELECT Title
FROM LibraryHub.Book
WHERE SerialNumber IN (
	SELECT SerialNumber
	FROM LibraryHub.BookCategory
	WHERE CategoryID = (
		SELECT ID
		FROM LibraryHub.Category
		WHERE Name = N'Fantasy'
		)
	);