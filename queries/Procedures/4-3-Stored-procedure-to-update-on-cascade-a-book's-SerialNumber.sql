/* Stored procedure to update on cascade a book's SerialNumber
This procedure relies on cascade updates being enabled on foreign key constraints.  Make sure that ON UPDATE CASCADE is set in the database relationships,  
otherwise, related tables will not update automatically. */

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
	
		UPDATE LibraryHub.Book
		SET SerialNumber = @NewSerialNumber
		WHERE SerialNumber = @OldSerialNumber;

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
