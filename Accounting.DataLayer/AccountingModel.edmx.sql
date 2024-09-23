
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/23/2024 23:51:06
-- Generated from EDMX file: C:\Users\Lenovo\source\repos\Accounting\Accounting.DataLayer\AccountingModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Accounting_DB];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[Accounting_DBModelStoreContainer].[FK_Accounting_AccountingTypes]', 'F') IS NOT NULL
    ALTER TABLE [Accounting_DBModelStoreContainer].[Accounting] DROP CONSTRAINT [FK_Accounting_AccountingTypes];
GO
IF OBJECT_ID(N'[Accounting_DBModelStoreContainer].[FK_Accounting_Customers]', 'F') IS NOT NULL
    ALTER TABLE [Accounting_DBModelStoreContainer].[Accounting] DROP CONSTRAINT [FK_Accounting_Customers];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[AccountingTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AccountingTypes];
GO
IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customers];
GO
IF OBJECT_ID(N'[Accounting_DBModelStoreContainer].[Accounting]', 'U') IS NOT NULL
    DROP TABLE [Accounting_DBModelStoreContainer].[Accounting];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [CustomerID] int IDENTITY(1,1) NOT NULL,
    [FullName] nvarchar(300)  NOT NULL,
    [Mobile] nvarchar(150)  NOT NULL,
    [Email] varchar(50)  NULL,
    [Address] nvarchar(300)  NOT NULL,
    [CustomerImage] varchar(50)  NULL
);
GO

-- Creating table 'Accounting'
CREATE TABLE [dbo].[Accounting] (
    [ID] int IDENTITY(1,1) NOT NULL,
    [CostomerID] int  NOT NULL,
    [TypeID] int  NOT NULL,
    [Amount] int  NOT NULL,
    [Description] nvarchar(800)  NULL,
    [DateTitle] datetime  NOT NULL,
    [CustomerID] int  NOT NULL,
    [Account] int  NOT NULL,
    [DateTime] datetime  NOT NULL
);
GO

-- Creating table 'AccountingTypes'
CREATE TABLE [dbo].[AccountingTypes] (
    [TypeID] int  NOT NULL,
    [TypeTitle] nvarchar(150)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [CustomerID] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([CustomerID] ASC);
GO

-- Creating primary key on [ID], [CustomerID], [Account], [DateTime] in table 'Accounting'
ALTER TABLE [dbo].[Accounting]
ADD CONSTRAINT [PK_Accounting]
    PRIMARY KEY CLUSTERED ([ID], [CustomerID], [Account], [DateTime] ASC);
GO

-- Creating primary key on [TypeID] in table 'AccountingTypes'
ALTER TABLE [dbo].[AccountingTypes]
ADD CONSTRAINT [PK_AccountingTypes]
    PRIMARY KEY CLUSTERED ([TypeID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [TypeID] in table 'Accounting'
ALTER TABLE [dbo].[Accounting]
ADD CONSTRAINT [FK_Accounting_AccountingTypes]
    FOREIGN KEY ([TypeID])
    REFERENCES [dbo].[AccountingTypes]
        ([TypeID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Accounting_AccountingTypes'
CREATE INDEX [IX_FK_Accounting_AccountingTypes]
ON [dbo].[Accounting]
    ([TypeID]);
GO

-- Creating foreign key on [CostomerID] in table 'Accounting'
ALTER TABLE [dbo].[Accounting]
ADD CONSTRAINT [FK_Accounting_Customers]
    FOREIGN KEY ([CostomerID])
    REFERENCES [dbo].[Customers]
        ([CustomerID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Accounting_Customers'
CREATE INDEX [IX_FK_Accounting_Customers]
ON [dbo].[Accounting]
    ([CostomerID]);
GO

-- Creating foreign key on [CustomerID] in table 'Accounting'
ALTER TABLE [dbo].[Accounting]
ADD CONSTRAINT [FK_Accounting_Customers1]
    FOREIGN KEY ([CustomerID])
    REFERENCES [dbo].[Customers]
        ([CustomerID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Accounting_Customers1'
CREATE INDEX [IX_FK_Accounting_Customers1]
ON [dbo].[Accounting]
    ([CustomerID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------