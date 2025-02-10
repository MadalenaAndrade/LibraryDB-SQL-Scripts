EXEC UpdateBookSN
	@OldSerialNumber = 9780261102355,
	@NewSerialNumber = 9780261102354

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
WHERE B.SerialNumber = 9780261102355;