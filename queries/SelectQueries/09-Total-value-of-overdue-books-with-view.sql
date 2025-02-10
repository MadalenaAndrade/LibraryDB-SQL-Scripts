-- Total value of overdue books (used the view OverdueClientsInfo!)
SELECT SUM(DATEDIFF(dd, OverdueInfo.duedate, GETDATE())*OverdueInfo.FinePerDay) AS TotalOverdueFine
FROM dbo.OverdueClientsInfo AS OverdueInfo;