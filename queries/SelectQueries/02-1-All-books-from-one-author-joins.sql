--All books from one author
SELECT Book.Title
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookAuthor AS BookAuthor
	ON Book.SerialNumber = BookAuthor.SerialNumber
JOIN LibraryHub.Author AS Author
	ON BookAuthor.AuthorID = Author.ID
	WHERE Author.Name = N'José Saramago'
ORDER BY Title;
