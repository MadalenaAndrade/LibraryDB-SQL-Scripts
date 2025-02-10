--All books from one category
SELECT Book.Title
FROM LibraryHub.Book AS Book
JOIN LibraryHub.BookCategory AS BookCategory
	ON Book.SerialNumber = BookCategory.SerialNumber
JOIN LibraryHub.Category AS Category
	ON BookCategory.CategoryID = Category.ID
	WHERE Category.Name = N'Fantasy'
ORDER BY Title;