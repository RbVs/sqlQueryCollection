CREATE PROCEDURE [dbo].[sp_BackUp]
AS
    if object_id('tempdb.dbo.#database') is not null
        drop TABLE #database
    create TABLE #database
    (
        id   INT identity primary key,
        name sysname
    )

insert into #database(name)
select name
FROM (
         SELECT name
         FROM master.dbo.sysdatabases
         WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb')) as db

declare
    @id INT, @count INT, @sql NVARCHAR(max), @currentDb nvarchar(255);

select @id = 1, @count = max(id)
from #database
    while @id <= @count
    BEGIN
        SET @currentDb = (
            select name
            from #database
            where id = @id)

        DECLARE
            @BackUp nvarchar(max)
        SET @BackUp = 'BACKUP DATABASE ' + @currentDb + '
	TO  DISK = N''\\path goes here\' + @currentDb + '.bak''
	WITH RETAINDAYS = 5, NOFORMAT, NOINIT, NAME = N''name for your backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10'

        EXEC (@BackUp)

        INSERT INTO [dbo].[TB_BackUp]
        ( [DatabaseName]
        , [BackUpDate])
        VALUES ( @currentDb
               , CURRENT_TIMESTAMP)

        set @id = @id + 1;
    END
