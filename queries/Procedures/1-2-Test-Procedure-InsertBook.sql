EXEC InsertBook 
    @SerialNumber = 9789720005953,
    @Title = N'A Jangada de Pedra',
    @Year = 2024,
    @FinePerDay = 1.50,
    @PublisherID = 1,
	@TotalAmount = 2,
	@AvailableAmount = 2,
	@CategoryID = 17,
	@AuthorName = N'José Saramago'

SELECT * 
FROM LibraryHub.Book AS B
JOIN LibraryHub.BookStock AS BS
	ON B.SerialNumber = BS.SerialNumber
JOIN LibraryHub.BookCategory AS BC
	ON BS.SerialNumber = BC.SerialNumber
JOIN LibraryHub.BookAuthor AS BA
	ON BC.SerialNumber = BA.SerialNumber
JOIN LibraryHub.BookCopy AS BCopy
	ON BA.SerialNumber = BCopy.SerialNumber
WHERE B.SerialNumber = 9789720005953;