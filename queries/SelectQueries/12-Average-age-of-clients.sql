-- Average age of clients
SELECT AVG(DATEDIFF(yy, Client.DateOfBirth, GETDATE())) AS AverageAge
FROM LibraryHub.Client;