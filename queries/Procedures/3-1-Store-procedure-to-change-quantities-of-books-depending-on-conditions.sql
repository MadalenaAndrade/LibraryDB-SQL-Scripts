-- Store procedure to change quantities of books depending on conditions
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE AlterBookStock
	@SerialNumber bigint,          
    @OldConditionID smallint,         
    @NewConditionID smallint,            
    @Quantity int, -- Quantity of books being changed
	@Notes nvarchar(max)

AS
BEGIN
	SET NOCOUNT ON;
    
	-- commit!
	BEGIN TRANSACTION;

	BEGIN TRY

		--Verify if it's possible to delete the amount choosen taking in account the number of total number of copys in the wanted condition
		DECLARE @CurrentAmount INT;
    
		SELECT @CurrentAmount = COUNT(*)
		FROM LibraryHub.BookCopy
		WHERE BookCopy.SerialNumber = @SerialNumber AND BookCopy.BookConditionID = @OldConditionID;

		IF @CurrentAmount < @Quantity
		BEGIN
			RAISERROR(N'Total quantity is lower than required for update', 16, 1); 
		END

		-- Verify if the quantity that exists is available (as it can be with a client)
		DECLARE @AvailableAmount int;
		SELECT @AvailableAmount = @CurrentAmount-COUNT(*)
		FROM LibraryHub.BookCopy AS BookCopy
		JOIN LibraryHub.Rent AS Rent 
			ON BookCopy.ID = Rent.BookCopyID
		LEFT JOIN LibraryHub.RentReception AS RentReception
			ON Rent.ID = RentReception.RentID
		WHERE BookCopy.SerialNumber = @SerialNumber AND BookCopy.BookConditionID = @OldConditionID AND RentReception.RentID IS NULL;

		IF @AvailableAmount < @Quantity
		BEGIN
			RAISERROR(N'Total quantity is lower than required for update', 16, 1);
		END
		
  
		--Update table just for the wanted quantity with correlated subquery
		UPDATE BookCopy
		SET BookConditionID = @NewConditionID, Notes = @Notes
		FROM LibraryHub.BookCopy AS BookCopy
		WHERE BookCopy.ID IN (
			SELECT TOP (@Quantity) ID
			FROM LibraryHub.BookCopy
			WHERE SerialNumber = @SerialNumber AND BookConditionID = @OldConditionID
			ORDER BY ID
			);
		
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
