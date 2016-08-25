
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 08/25/2016 18:11:09
-- Generated from EDMX file: D:\OneDrive\SoftUni\Technologies Module\GitHub\Team_Project\Team_Project\Blog\Blog\Models\BlogModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [D:\ONEDRIVE\SOFTUNI\TECHNOLOGIES MODULE\GITHUB\TEAM_PROJECT\TEAM_PROJECT\BLOG\BLOG\APP_DATA\BLOGDATA.MDF];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_Post_ToUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK_Post_ToUser];
GO
IF OBJECT_ID(N'[dbo].[FK_PostComments]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[CommentsSet] DROP CONSTRAINT [FK_PostComments];
GO
IF OBJECT_ID(N'[dbo].[FK_TagPosts]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK_TagPosts];
GO
IF OBJECT_ID(N'[dbo].[FK_PostCategory]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Post] DROP CONSTRAINT [FK_PostCategory];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[User]', 'U') IS NOT NULL
    DROP TABLE [dbo].[User];
GO
IF OBJECT_ID(N'[dbo].[Post]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Post];
GO
IF OBJECT_ID(N'[dbo].[CommentsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CommentsSet];
GO
IF OBJECT_ID(N'[dbo].[TagsSet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[TagsSet];
GO
IF OBJECT_ID(N'[dbo].[CategorySet]', 'U') IS NOT NULL
    DROP TABLE [dbo].[CategorySet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'User'
CREATE TABLE [dbo].[User] (
    [UserId] int IDENTITY(1,1) NOT NULL,
    [Username] nvarchar(50)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL,
    [PasswordSalt] nvarchar(max)  NOT NULL,
    [FirstName] nvarchar(30)  NOT NULL,
    [LastName] nvarchar(30)  NOT NULL,
    [DateCreated] datetime  NOT NULL
);
GO

-- Creating table 'Post'
CREATE TABLE [dbo].[Post] (
    [PostId] int IDENTITY(1,1) NOT NULL,
    [UserId] int  NULL,
    [Title] nvarchar(80)  NOT NULL,
    [About] nvarchar(150)  NULL,
    [Content] nvarchar(max)  NOT NULL,
    [DatePosted] datetime  NOT NULL,
    [TagId] int  NOT NULL,
    [CategoryId] int  NOT NULL
);
GO

-- Creating table 'CommentsSet'
CREATE TABLE [dbo].[CommentsSet] (
    [CommentId] int IDENTITY(1,1) NOT NULL,
    [UserId] nvarchar(max)  NOT NULL,
    [Content] nvarchar(max)  NOT NULL,
    [DateCommented] nvarchar(max)  NOT NULL,
    [PostId] int  NOT NULL
);
GO

-- Creating table 'TagsSet'
CREATE TABLE [dbo].[TagsSet] (
    [TagId] int IDENTITY(1,1) NOT NULL,
    [TagName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'CategorySet'
CREATE TABLE [dbo].[CategorySet] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CategoryType] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [UserId] in table 'User'
ALTER TABLE [dbo].[User]
ADD CONSTRAINT [PK_User]
    PRIMARY KEY CLUSTERED ([UserId] ASC);
GO

-- Creating primary key on [PostId] in table 'Post'
ALTER TABLE [dbo].[Post]
ADD CONSTRAINT [PK_Post]
    PRIMARY KEY CLUSTERED ([PostId] ASC);
GO

-- Creating primary key on [CommentId] in table 'CommentsSet'
ALTER TABLE [dbo].[CommentsSet]
ADD CONSTRAINT [PK_CommentsSet]
    PRIMARY KEY CLUSTERED ([CommentId] ASC);
GO

-- Creating primary key on [TagId] in table 'TagsSet'
ALTER TABLE [dbo].[TagsSet]
ADD CONSTRAINT [PK_TagsSet]
    PRIMARY KEY CLUSTERED ([TagId] ASC);
GO

-- Creating primary key on [Id] in table 'CategorySet'
ALTER TABLE [dbo].[CategorySet]
ADD CONSTRAINT [PK_CategorySet]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [UserId] in table 'Post'
ALTER TABLE [dbo].[Post]
ADD CONSTRAINT [FK_Post_ToUser]
    FOREIGN KEY ([UserId])
    REFERENCES [dbo].[User]
        ([UserId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Post_ToUser'
CREATE INDEX [IX_FK_Post_ToUser]
ON [dbo].[Post]
    ([UserId]);
GO

-- Creating foreign key on [PostId] in table 'CommentsSet'
ALTER TABLE [dbo].[CommentsSet]
ADD CONSTRAINT [FK_PostComments]
    FOREIGN KEY ([PostId])
    REFERENCES [dbo].[Post]
        ([PostId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PostComments'
CREATE INDEX [IX_FK_PostComments]
ON [dbo].[CommentsSet]
    ([PostId]);
GO

-- Creating foreign key on [TagId] in table 'Post'
ALTER TABLE [dbo].[Post]
ADD CONSTRAINT [FK_TagPosts]
    FOREIGN KEY ([TagId])
    REFERENCES [dbo].[TagsSet]
        ([TagId])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_TagPosts'
CREATE INDEX [IX_FK_TagPosts]
ON [dbo].[Post]
    ([TagId]);
GO

-- Creating foreign key on [CategoryId] in table 'Post'
ALTER TABLE [dbo].[Post]
ADD CONSTRAINT [FK_PostCategory]
    FOREIGN KEY ([CategoryId])
    REFERENCES [dbo].[CategorySet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PostCategory'
CREATE INDEX [IX_FK_PostCategory]
ON [dbo].[Post]
    ([CategoryId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------