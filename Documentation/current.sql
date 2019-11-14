use master
drop database bikersportal
go

create database bikersportal
go
use bikersportal
go

create table [User](
UserID      int not null identity(1,1), 
Username    varchar(100) not null unique, 
UserPassword    varchar(16) not null, 
UserType    tinyint not null, 
[Name]    varchar(150) not null, 
Surname     varchar(100) not null, 
Email       varchar(255) not null unique, 
Phone       varchar(20) not null unique, 
[Address]     varchar(400) not null,
BDate       datetime not null, 
IBAN        varchar(32) null,  
UserPicture varchar(255) null, 
Annotation  text null, 
IDNumber varchar(11) NULL,
[IDNumber_UNQ]  AS (CASE WHEN IDNumber IS NULL
				THEN cast(UserID as varchar(12))
				ELSE '~' + IDNumber END),
CONSTRAINT [UQSSN_Unique] UNIQUE  ([IDNumber_UNQ]),
primary key (UserID)
);
go
create table Bike (
BikeID        int not null identity(1,1), 
OwnerID int not null foreign key references [User](UserID),
Brand         varchar(100) null, 
Category      varchar(100) not null, 
Picture       varchar(255) not null, 
[Description]  text not null, 
Transmission  varchar(50) not null, 
AdsHeader     varchar(150) not null, 
Price         float(5) not null, 
Currency      varchar(50) not null,
[AddingDate] datetime not null, 
[Availability]  tinyint not null,
BikeCity varchar(255) not null,
BikeCounty varchar(255) not null,
primary key (BikeID)
);
go
create table [Message] (
MessageID      int not null identity(1,1), 
TargetID int not null foreign key references [User](UserID), 
SenderID int not null foreign key references [User](UserID), 
[Message]       text not null, 
SendDate       datetime null,  
primary key (MessageID)
);
go
create table Manager (
ManagerID   int not null identity(1,1), 
[Name]        varchar(150) not null, 
Surname     varchar(100) not null, 
[Password]    varchar(16) not null, 
ManagerType tinyint not null, 
Email       varchar(255) not null unique, 
Phone       varchar(25) not null unique, 
[Address]     text not null, 
primary key (ManagerID)
);
go
create table Ticket (
TicketID    int not null identity(1,1), 
TManagerID int not null foreign key references Manager(ManagerID),
Email       varchar(255) not null, 
[Subject]     varchar(75) not null, 
[Description] text not null, 
[Date]      datetime not null, 
[Category] varchar(75) not null,
primary key (TicketID)
);
go
create table FeedbackScore (
FeedbackID   int not null identity(1,1), 
UserID int not null references [User](UserID), 
BikeID int not null references Bike(BikeID),
FeedbackText text not null, 
Score        int not null, 
[date]       datetime not null, 
primary key (FeedbackID)
);
go
create table OnRentBike(
BikeID int not null foreign key references Bike(BikeID),
RenterUsername varchar(100) not null foreign key references [User](Username),
HirerUsername  varchar(100) not null foreign key references [User](Username),
RenterCheckIn tinyint not null default(0),
HirerCheckIn tinyint not null default(0)
);
go

CREATE PROC [dbo].[BikeInsert]
  @owner   int,
  @marka   varchar(100), 
  @tur      varchar(100), 
  @image      varchar(255), 
  @aciklama   text, 
  @vites  varchar(50), 
  @baslik     varchar(150), 
  @ucret         float(5), 
  @birim      varchar(50), 
  @datee datetime,
  @ulasik  tinyint, 
  @city varchar(255),
  @county varchar(255)

as
  BEGIN
	INSERT INTO Bike
	VALUES(@owner,@marka,@tur,@image,@aciklama,@vites,@baslik,@ucret,@birim,@datee,@ulasik,@city,@county)
END
GO

CREATE PROC [dbo].[InsertFeedback]
  @userid int,
  @bikeid       int, 
  @fbtext     text, 
  @score       int, 
  @datee datetime
as
  BEGIN
	INSERT INTO FeedbackScore
	VALUES(@userid,@bikeid,@fbtext,@score,@datee)
END
GO


insert into [User](Username,UserPassword,UserType,Surname,Name,Phone,Email,[Address],Annotation,BDate)
values('user1','123','1','sirname','firstname is haaq','05064933822','enes@gmail.com','yol karsisi samsi sokak','merhaba',CURRENT_TIMESTAMP);

insert into [User](Username,UserPassword,UserType,Surname,Name,Phone,Email,[Address],Annotation,BDate)
values('user2','123','1','sirname','firstname is haaq','05064933823','enes2@gmail.com','yol karsisi samsi sokak','merhaba',CURRENT_TIMESTAMP);

insert into [User](Username,UserPassword,UserType,Surname,Name,Phone,Email,[Address],Annotation,BDate)
values('user3','123','1','sirname','firstname is haaq','05064933824','enes3@gmail.com','yol karsisi samsi sokak','merhaba',CURRENT_TIMESTAMP);

INSERT INTO [dbo].[Manager]([Name],[Surname],[Password],[ManagerType],[Email],[Phone],[Address])
     VALUES('manager1','managersur1','123','0','hakaci@gmail.com','05366983645','ev')
GO

INSERT INTO [dbo].[Bike]([OwnerID],[Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[AddingDate],[Availability],[BikeCity],[BikeCounty])
     VALUES('1','GMC','3','~/BikePic/1.jpg','Ucux, güvenilir','12','Iþýklý falan',99.99,'0',CURRENT_TIMESTAMP,1,'2','6')
GO
INSERT INTO [dbo].[Bike]([OwnerID],[Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[AddingDate],[Availability],[BikeCity],[BikeCounty])
     VALUES('1','Salcano','2','~/BikePic/2.jpeg','Ucux, güvenilir','11','Sahibinden hasarlý',15,'0',CURRENT_TIMESTAMP,1,'1','4')
GO
INSERT INTO [dbo].[Bike]([OwnerID],[Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[AddingDate],[Availability],[BikeCity],[BikeCounty])
     VALUES('2','Salcano','2','~/BikePic/3.jpeg','Ucux, güvenilir','9','Temiz Doktordan',89,'0',CURRENT_TIMESTAMP,1,'1','4')
GO
INSERT INTO [dbo].[Bike]([OwnerID],[Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[AddingDate],[Availability],[BikeCity],[BikeCounty])
     VALUES('2','Söylemem','2','~/BikePic/4.jpeg','Ucux, güvenilir','19','Þehir canavarý',14,'0',CURRENT_TIMESTAMP,1,'2','2')
GO
INSERT INTO [dbo].[Bike]([OwnerID],[Brand],[Category],[Picture],[Description],[Transmission],[AdsHeader],[Price],[Currency],[AddingDate],[Availability],[BikeCity],[BikeCounty])
     VALUES('3','Scott','3','~/BikePic/5.jpeg','Ucux, güvenilir','5','Kardeþimin bisikleti',11,'0',CURRENT_TIMESTAMP,1,'2','1')
GO

INSERT INTO [dbo].[FeedbackScore]([UserID],[BikeID],[FeedbackText],[Score],[date])
     VALUES('1','1','Para almadý, iyi adammýþ',1,CURRENT_TIMESTAMP)
GO
INSERT INTO [dbo].[FeedbackScore]([UserID],[BikeID],[FeedbackText],[Score],[date])
     VALUES('1','2','Pedalý bozuk, zinciri ses çýkarýyordu',2,CURRENT_TIMESTAMP)
GO
INSERT INTO [dbo].[FeedbackScore]([UserID],[BikeID],[FeedbackText],[Score],[date])
     VALUES('1','3','Doktorum tavsiye etti',5,CURRENT_TIMESTAMP)
GO
INSERT INTO [dbo].[FeedbackScore]([UserID],[BikeID],[FeedbackText],[Score],[date])
     VALUES('2','4','2 hafta sorunsuz kullandým',3,CURRENT_TIMESTAMP)
GO
INSERT INTO [dbo].[FeedbackScore]([UserID],[BikeID],[FeedbackText],[Score],[date])
     VALUES('2','5','Tatildeydim, biraz tatoo yapýþtýrdým, sahibi kýzmadý->5/5',4,CURRENT_TIMESTAMP)
GO





--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('1','2','BISIKLET COK GUZEL ABIICM 2 GUN SONRA BULUSALIM BAGCILAR MEYDAN GERISI YALAN','5/1/2008 8:30:52 AM');

--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('2','3','bu bir mesajdirAJSDNBGJHKADB YILAN SERDAR','5/1/2008 8:30:52 AM');

--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('1','2','BIASDFASDGADSGFYALAN','5/1/2008 8:30:52 AM');

--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('2','4','bu bir ASDGFASDG YILAN SERDAR','5/1/2008 8:30:52 AM');

--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('4','3','BISIKLET COK GUZEL ABIICM 2 GUN SONRA BULUSALIM BAGCILAR MEYDAN GERISI YALAN','5/1/2008 8:30:52 AM');

--insert into [Message](SenderID,TargetID,[Message],SendDate)
--values('3','1','bu bir mesajdirAJSDNBGJHKADB YILAN SERDAR','5/1/2008 8:30:52 AM');
--GO

