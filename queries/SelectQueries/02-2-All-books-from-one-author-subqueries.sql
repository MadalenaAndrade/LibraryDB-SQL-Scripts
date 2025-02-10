--All books from one author
SELECT Title
FROM LibraryHub.Book
WHERE SerialNumber IN (
	SELECT SerialNumber
	FROM LibraryHub.BookAuthor
	WHERE AuthorID = (
		SELECT ID
		FROM LibraryHub.Author
		WHERE Name = N'José Saramago'
		)
	);