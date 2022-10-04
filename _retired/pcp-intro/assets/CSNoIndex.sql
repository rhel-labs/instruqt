DROP DATABASE IF EXISTS [SampleDB];
GO

CREATE DATABASE [SampleDB];
GO

USE SampleDB;
GO

SET NOCOUNT ON
GO

DBCC DROPCLEANBUFFERS;
GO

WITH a AS (SELECT * FROM (VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10)) AS a(a)) 
SELECT TOP(500000000) ROW_NUMBER() OVER (ORDER BY a.a) AS OrderItemId, 
a.a + b.a + c.a + d.a + e.a + f.a + g.a + h.a AS OrderId,
a.a * 10 AS Price,
CONCAT(a.a, N' ', b.a, N' ', c.a, N' ', d.a, N' ', e.a, N' ', f.a, N' ', g.a, N' ', h.a) AS ProductName
INTO Orders 
FROM a, a AS b, a AS c, a AS d, a AS e, a AS f, a AS g, a AS h; 
GO
                                                                               
DECLARE @StartingTime datetime2(7) = SYSDATETIME();
                                                                               
SELECT SUM(Price), AVG(Price) FROM Orders 
OPTION (maxdop 0)

PRINT 'Not using columnstore index: ' + CAST(DATEDIFF(millisecond, @StartingTime, SYSDATETIME()) AS varchar(20)) + ' ms';

GO 10
