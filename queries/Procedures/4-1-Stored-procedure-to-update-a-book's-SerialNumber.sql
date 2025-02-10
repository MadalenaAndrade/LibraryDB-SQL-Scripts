/* Important Note:  
This stored procedure updates a book's SerialNumber by manually modifying multiple related tables.  
However, this is not the best approach, as it bypasses referential integrity and requires disabling constraints.  

A better alternative:  
If cascade updates are properly defined in the database,  this procedure becomes unnecessary, as the update would automatically propagate.  

This version is kept for reference, but the recommended approach is to use cascading updates. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE UpdateBookSN
	@OldSerialNumber bigint,
	@NewSerialNumber bigint

AS
BEGIN
	SET NOCOUNT ON;
    
	-- commit!
	BEGIN TRANSACTION;

	BEGIN TRY
		--Deactivate relantionships
		ALTER TABLE LibraryHub.BookStock NOCHECK CONSTRAINT FK_BookStock_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookCategory NOCHECK CONSTRAINT FK_BookCategory_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookAuthor NOCHECK CONSTRAINT FK_BookAuthor_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookCopy NOCHECK CONSTRAINT FK_BookCopy_Book_SerialNumber;  

		--Update tables
		UPDATE LibraryHub.Book 
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;
	
		UPDATE LibraryHub.BookStock 
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;

		UPDATE LibraryHub.BookCategory
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;

		UPDATE LibraryHub.BookAuthor
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;

		UPDATE LibraryHub.BookCopy
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;

		--Reactivate relantionships
		ALTER TABLE LibraryHub.BookStock CHECK CONSTRAINT FK_BookStock_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookCategory CHECK CONSTRAINT FK_BookCategory_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookAuthor CHECK CONSTRAINT FK_BookAuthor_Book_SerialNumber;  
		ALTER TABLE LibraryHub.BookCopy CHECK CONSTRAINT FK_BookCopy_Book_SerialNumber; 

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
