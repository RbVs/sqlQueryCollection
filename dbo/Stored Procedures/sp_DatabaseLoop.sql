CREATE PROCEDURE sp_DatabaseLoop

AS

if object_id('tempdb.dbo.#database') is not null
    drop TABLE #database

--go

create TABLE #database
(
    id   INT identity primary key,
    name sysname
)

--go
insert into #database(name)

select name

FROM (
         SELECT name
         FROM master.dbo.sysdatabases
         WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')) as db

declare
    @id INT, @count INT, @sql NVARCHAR(max), @currentDb sysname;

select @id = 1, @count = max(id)
from #database

while @id <= @count

BEGIN

    select @currentDb = name
    from #database
    where id = @id

	insert into Tb_Name (Name)  VALUES(@currentDb)

    --print @currentDB
    set @id = @id + 1;

END

--go