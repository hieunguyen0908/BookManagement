USE master; 
GO
 
CREATE DATABASE BookManagement;
GO 

USE BookManagement;
GO 

CREATE TABLE [users]
    (
      [id] VARCHAR(30) PRIMARY KEY ,
      [password] VARCHAR(30) NOT NULL ,
      [fullname] NVARCHAR(30) NOT NULL ,
      [idRole] INT NOT NULL ,
      [status] VARCHAR(10) NOT NULL
    );
GO

CREATE TABLE [roles]
    (
      [id] INT PRIMARY KEY ,
      [name] VARCHAR(6) NOT NULL
    );
GO  

CREATE TABLE [books]
    (
      [id] VARCHAR(50) PRIMARY KEY ,
      [title] NVARCHAR(100) NOT NULL ,
      [image] VARCHAR(255) ,
      [describe] NVARCHAR(300) ,
      [price] FLOAT NOT NULL ,
      [author] NVARCHAR(50) NOT NULL ,
      [cateID] INT NOT NULL,
      [importDate] DATE NOT NULL ,
      [quantity] INT NOT NULL ,
      [status] VARCHAR(10) NOT NULL
    );
GO 

CREATE TABLE [categorys]
    (
      [id] INT IDENTITY
               PRIMARY KEY ,
      [name] NVARCHAR(50) NOT NULL
    );
GO 

CREATE TABLE [discounts]
    (
      [code] VARCHAR(100) PRIMARY KEY ,
      [percent] INT NOT NULL,
	  [describe] NVARCHAR(300),
	  [date] DATE NOT NULL,
	  [status] VARCHAR(10) NOT NULL
    );
GO 
CREATE TABLE [userDiscount]
(
	[userID] VARCHAR(30),
	[discountCode] VARCHAR(100),
	[times] INT,
	PRIMARY KEY(userID, discountCode)
)
GO 
CREATE TABLE [orders]
(
	[id] INT IDENTITY PRIMARY KEY,
	[userID] VARCHAR(30) NOT NULL,
	[buyAt] DATETIME NOT NULL,
	[discountCode] VARCHAR(100),
	[discountPrice] FLOAT,
	[totalPrice] FLOAT NOT NULL,
	[status] VARCHAR(10) NOT NULL
)
GO 
CREATE TABLE [orderDetails]
(
	[orderID] INT, 
	[bookID] VARCHAR(50),
	[quantity] INT, 
	[price] FLOAT,
	PRIMARY KEY(orderID, bookID)
)
GO 

ALTER TABLE [dbo].[users] 
ADD FOREIGN KEY (idRole) REFERENCES [dbo].[roles](id);

ALTER TABLE [dbo].[books]
ADD FOREIGN KEY (cateID) REFERENCES [dbo].[categorys](id)

ALTER TABLE [dbo].[orders]
ADD FOREIGN KEY (userID) REFERENCES [dbo].[users](id)

ALTER TABLE [dbo].[orders]
ADD FOREIGN KEY (discountCode) REFERENCES dbo.discounts(code)
	
ALTER TABLE [dbo].[orderDetails]
ADD FOREIGN KEY (orderID) REFERENCES [dbo].[orders](id)

ALTER TABLE [dbo].[orderDetails]
ADD FOREIGN KEY (bookID) REFERENCES [dbo].[books](id)

ALTER TABLE [dbo].[userDiscount]
ADD FOREIGN KEY (userID) REFERENCES [dbo].[users](id)

ALTER TABLE [dbo].[userDiscount]
ADD FOREIGN KEY (discountCode) REFERENCES [dbo].[discounts](code)

INSERT  dbo.roles
        ( id, name )
VALUES  ( 1, -- id - int
          'admin'  -- name - varchar(6)
          );
INSERT  INTO dbo.roles
        ( id, name )
VALUES  ( 2, -- id - int
          'user'  -- name - varchar(6)
          );

INSERT  INTO dbo.users
        ( id ,
          password ,
          fullname ,
          idRole ,
          status
        )
VALUES  ( 'hieu' , -- id - varchar(30)
          '1' , -- password - varchar(30)
          N'Nguyen Hieu' , -- fullname - nvarchar(30)
          1 , -- idRole - int
          'active'  -- status - varchar(8)
        );
INSERT  INTO dbo.users
        ( id ,
          password ,
          fullname ,
          idRole ,
          status
        )
VALUES  ( 'hoa' , -- id - varchar(30)
          '1' , -- password - varchar(30)
          N'HoaDNT' , -- fullname - nvarchar(30)
          2 , -- idRole - int
          'active'  -- status - varchar(8)
        );

INSERT INTO dbo.categorys
        ( name )
VALUES  ( N'tieu thuyet'  -- name - nvarchar(50)
          )
INSERT INTO dbo.categorys
        ( name )
VALUES  ( N'hepl sefl'  -- name - nvarchar(50)
          )

INSERT  dbo.books
        ( id ,
          title ,
          image ,
          describe ,
          price ,
          author ,
          cateID ,
          importDate ,
          quantity ,
          status
        )
VALUES  ( 'b1' , -- id - varchar(50)
          N'toi thay hoa vang tren co xanh' , -- title - nvarchar(100)
          'book' , -- image - varchar(255)
          N'sach nay cua 1 tac gia noi tieng' , -- describe - nvarchar(300)
          150 , -- price - float
          N'nguyen ngoc anh' , -- author - nvarchar(50)
          1 , -- cateID - int
          GETDATE() , -- importDate - date
          10 , -- quantity - int
          'active'  -- status - varchar(8)
        );
INSERT dbo.books
        ( id ,
          title ,
          image ,
          describe ,
          price ,
          author ,
          cateID ,
          importDate ,
          quantity ,
          status
        )
VALUES  ( 'b2' , -- id - varchar(50)
          N'toto' , -- title - nvarchar(100)
          'book' , -- image - varchar(255)
          N'sach cua nguyen ngoc anh' , -- describe - nvarchar(300)
          130 , -- price - float
          N'Nguyen Ngoc Anh' , -- author - nvarchar(50)
          2 , -- cateID - int
          GETDATE() , -- importDate - date
          10 , -- quantity - int
          'active'  -- status - varchar(8)
        )
INSERT INTO dbo.books
        ( id ,
          title ,
          image ,
          describe ,
          price ,
          author ,
          cateID ,
          importDate ,
          quantity ,
          status
        )
VALUES  ( 'b3' , -- id - varchar(50)
          N'alibaba' , -- title - nvarchar(100)
          '123' , -- image - varchar(255)
          N'asdasd' , -- describe - nvarchar(300)
          200 , -- price - float
          N'alexenda' , -- author - nvarchar(50)
          2 , -- cateID - int
          GETDATE() , -- importDate - datetime
          100 , -- quantity - int
          'active'  -- status - varchar(10)
        )
		--checkLogin----
		--SELECT u.id, u.fullname, r.name AS roleName FROM dbo.users AS u INNER JOIN dbo.roles AS r ON r.id = u.idRole WHERE u.id = 'u1' AND u.password = 1 AND u.status = 'active'
		--SELECT u.id, u.fullname, r.name AS roleName FROM dbo.users AS u INNER JOIN dbo.roles AS r ON r.id = u.idRole WHERE u.id = 'u1' AND u.password = 1 AND u.status='active'
		
		--get all category--
		--SELECT id, name FROM dbo.categorys

		--getAllBookWithCategory
		--search title
		--SELECT id, title, image, describe, price, author, cateID, importDate, quantity, status FROM dbo.books WHERE title LIKE ? status = 'active'
		--search title + category
		SELECT * FROM dbo.books
		--	
		--AND c.name = 'tieu thuyet' AND b.status = 'active'

		--SELECT b.id, b.title, b.image, b.describe, b.price, b.author, c.name AS categoryName, importDate, quantity, status FROM dbo.books AS b JOIN dbo.categorys AS c ON c.id = b.cateID WHERE b.title LIKE N'%t%' AND c.name = 'tieu thuyet' AND  b.price > 100 AND b.price <= 150 AND b.status = 'active'
		--SELECT b.id , b.title ,b.image ,b.describe ,b.price ,b.author ,b.importDate ,b.quantity ,c.name AS categoryName FROM dbo.books AS b JOIN dbo.categorys AS c ON c.id = b.cateID WHERE (b.title LIKE ? COLLATE Latin1_General_CI_AI) AND b.status = 'active' AND (? IS NULL OR c.name = ?) AND (? IS NULL OR b.price >= ?) AND (? IS NULL OR b.price <= ?) 
		--UPDATE dbo.books SET status = 'active'
		--UPDATE dbo.books SET title = ?, image = ?, describe = ?, price = ?, author = ?, importDate = ?, quantity = ?, cateID = ? WHERE id = ? AND status ='active' 

		-- INSERT INTO dbo.orderDetails ( orderID, bookID, quantity, price ) VALUES  ( ?, ?, ?, ?)

		-- INSERT INTO dbo.orders ( userID ,buyAt ,discountCode ,discountPrice ,totalPrice ,status)VALUES  ( ? , GETDATE() , null , null , ? , 'not pay' )
		
		-- SELECT quantity FROM dbo.books WHERE id = ? 

		-- UPDATE dbo.books SET quantity = ? WHERE id = ?