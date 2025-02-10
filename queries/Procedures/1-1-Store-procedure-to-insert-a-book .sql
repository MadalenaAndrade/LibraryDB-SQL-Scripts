/* This procedure inserts a book into multiple tables in a straightforward way.

Limitations:
- It only supports one author and one category per book.  
  This could be improved using **Table-Valued Parameters (TVPs)** to insert multiple authors/categories at once.  
- The publisher must already exist in the database.  
  A similar check to the one used for the author could be added to handle this case. */


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE InsertBook
	@SerialNumber bigint,
	@Title nvarchar(255),
	@Year smallint,
	@FinePerDay decimal(4, 2),
	@PublisherID int,
	@TotalAmount tinyint,
	@AvailableAmount tinyint,
	@CategoryID tinyint,
	@AuthorName nvarchar(30)
	
AS
BEGIN
	SET NOCOUNT ON;
    
	-- commit!
	BEGIN TRANSACTION;

	BEGIN TRY
	
	--Insert new info
	INSERT INTO LibraryHub.Book (SerialNumber, Title, Year, FinePerDay, PublisherID)
    VALUES (@SerialNumber, @Title, @Year, @FinePerDay, @PublisherID);
	
	INSERT INTO LibraryHub.BookStock (SerialNumber, TotalAmount, AvailableAmount)
	VALUES (@SerialNumber, @TotalAmount, @AvailableAmount);

	INSERT INTO LibraryHub.BookCategory
	VALUES(@SerialNumber, @CategoryID);	 

	--Check if author exists and add if not
	DECLARE @AuthorID int

	SELECT @AuthorID = ID
    FROM LibraryHub.Author
    WHERE Name = @AuthorName;

	IF @AuthorID IS NULL
    BEGIN
        INSERT INTO LibraryHub.Author(Name)
        VALUES (@AuthorName);

        -- Put the new ID in the AuthorID variable
        SELECT @AuthorID = SCOPE_IDENTITY();
    END

		-- Insert new info in BookAuthor table
    INSERT INTO LibraryHub.BookAuthor (SerialNumber, AuthorID)
    VALUES (@SerialNumber, @AuthorID);

	--assuming that new books are new, add bookcopys with "as new" condition
	DECLARE @n INT
	SET @n = @TotalAmount

	WHILE @n > 0
	BEGIN
		INSERT INTO LibraryHub.BookCopy (SerialNumber, BookConditionID, Notes)
		VALUES (@SerialNumber, 1, N'');
		SET @n -= 1;
	END;
	COMMIT;
	END TRY

	BEGIN CATCH
	SELECT       
		ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
	ROLLBACK
	END CATCH;
END
GO
