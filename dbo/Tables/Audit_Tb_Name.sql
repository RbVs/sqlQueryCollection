CREATE TABLE [dbo].[Audit_Tb_Name] (
    [ID]              INT           NOT NULL,
    [Name]            NVARCHAR (10) NULL,
    [Aenderungsdatum] DATETIME      NOT NULL,
    [AenderungsArt]   NVARCHAR (50) NOT NULL,
    [Username]        NVARCHAR (50) NOT NULL,
    [Hostaname]       NVARCHAR (50) NOT NULL
);

