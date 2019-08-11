CREATE TABLE [dbo].[Tb_Name] (
    [ID]   INT           IDENTITY (1, 1) NOT NULL,
    [Name] NVARCHAR (50) NOT NULL,
    CONSTRAINT [Tb_Name_pk] PRIMARY KEY NONCLUSTERED ([ID] ASC)
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER Tb_Name_InsertTrigger
    ON dbo.Tb_Name
    AFTER INSERT
    AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    --SET IDENTITY_INSERT dbo.Tb_Name ON;


    DECLARE
        @Id int, @Name nvarchar(10), @Aenderungsdatum datetime, @Aenderungsart nvarchar(50), @Username nvarchar(50), @Hostname nvarchar(50)
    SET @Id = (SELECT Id from inserted)
    SET @Name = (SELECT Name from inserted)
    SET @Aenderungsdatum = CURRENT_TIMESTAMP
    SET @Aenderungsart = 'insert'
    SET @Username = SUSER_NAME()
    SET @Hostname = HOST_NAME()


    INSERT INTO [dbo].[Audit_Tb_Name]
    ( [ID]
    , [Name]
    , [Aenderungsdatum]
    , [AenderungsArt]
    , [Username]
    , [Hostaname])
    VALUES (@Id, @Name, @Aenderungsdatum, @Aenderungsart, @Username, @Hostname)
    --SET IDENTITY_INSERT dbo.Tb_Name OFF;
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[Tb_Name_UpdateTrigger]
    ON [dbo].[Tb_Name]
    AFTER UPDATE
    AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    --SET IDENTITY_INSERT dbo.Tb_Name ON;


    DECLARE
        @Id int, @Name nvarchar(10), @Aenderungsdatum datetime, @Aenderungsart nvarchar(50), @Username nvarchar(50), @Hostname nvarchar(50)
    SET @Id = (select d.id
               from deleted d
                        join inserted i on (i.ID = d.ID))

    SET @Name = (SELECT Name from inserted)
    SET @Aenderungsdatum = CURRENT_TIMESTAMP
    SET @Aenderungsart = 'update'
    SET @Username = SUSER_NAME()
    SET @Hostname = HOST_NAME()


    INSERT INTO [dbo].[Audit_Tb_Name]
    ( [ID]
    , [Name]
    , [Aenderungsdatum]
    , [AenderungsArt]
    , [Username]
    , [Hostaname])
    VALUES (@Id, @Name, @Aenderungsdatum, @Aenderungsart, @Username, @Hostname)
    --SET IDENTITY_INSERT dbo.Tb_Name OFF;
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[Tb_Name_DeleteTrigger]
    ON [dbo].[Tb_Name]
    AFTER DELETE
    AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    --SET IDENTITY_INSERT dbo.Tb_Name ON;


    DECLARE
        @Id int, @Name nvarchar(10), @Aenderungsdatum datetime, @Aenderungsart nvarchar(50), @Username nvarchar(50), @Hostname nvarchar(50)
    SET @Id = (SELECT Id from deleted)
    SET @Name = (SELECT Name from deleted)
    SET @Aenderungsdatum = CURRENT_TIMESTAMP
    SET @Aenderungsart = 'delete'
    SET @Username = SUSER_NAME()
    SET @Hostname = HOST_NAME()


    INSERT INTO [dbo].[Audit_Tb_Name]
    ( [ID]
    , [Name]
    , [Aenderungsdatum]
    , [AenderungsArt]
    , [Username]
    , [Hostaname])
    VALUES (@Id, @Name, @Aenderungsdatum, @Aenderungsart, @Username, @Hostname)
    --SET IDENTITY_INSERT dbo.Tb_Name OFF;
END