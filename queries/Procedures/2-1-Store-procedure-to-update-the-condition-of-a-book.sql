-- Store procedure to update the condition of a book
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
CREATE PROCEDURE UpdateBookCondition
	@ID int,
	@BookConditionID smallint,
	@Notes nvarchar(max)

AS
BEGIN
	SET NOCOUNT ON;
    
	UPDATE LibraryHub.BookCopy
    SET BookConditionID = @BookConditionID,
		Notes = @Notes
    WHERE ID = @ID;

END
GO
