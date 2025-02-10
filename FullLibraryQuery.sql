--FULL LIBRARYHUB QUERY--
CREATE SCHEMA LibraryHub;
GO


BEGIN TRANSACTION;

BEGIN TRY


--Create tables with PKs
CREATE TABLE LibraryHub.Publisher(
	ID int IDENTITY(1, 1),
	Name nvarchar(30) NOT NULL,
	CONSTRAINT PK_Publisher PRIMARY KEY(ID));

CREATE TABLE LibraryHub.Author(
	ID bigint IDENTITY(1, 1),
	Name nvarchar(30) NOT NULL,
	CONSTRAINT PK_Author PRIMARY KEY(ID));

CREATE TABLE LibraryHub.Category(
	ID tinyint IDENTITY(1, 1),
	Name nvarchar(30) NOT NULL,
	CONSTRAINT PK_Category PRIMARY KEY(ID));

CREATE TABLE LibraryHub.Book(
	SerialNumber bigint,
	Title nvarchar(255) NOT NULL,
	Year smallint NOT NULL,
	FinePerDay decimal(4, 2) NOT NULL,
	PublisherID int NOT NULL,
	CONSTRAINT PK_Book PRIMARY KEY (SerialNumber));

CREATE TABLE LibraryHub.BookAuthor(
	SerialNumber bigint,
	AuthorID bigint,
	CONSTRAINT PK_BookAuthor PRIMARY KEY(SerialNumber, AuthorID));

CREATE TABLE LibraryHub.BookCategory(
	SerialNumber bigint,
	CategoryID tinyint,
	CONSTRAINT PK_BookCategory PRIMARY KEY(SerialNumber, CategoryID));

CREATE TABLE LibraryHub.BookStock(
	SerialNumber bigint,
	TotalAmount tinyint NOT NULL,
	AvailableAmount tinyint NOT NULL,
	CONSTRAINT PK_BookStock PRIMARY KEY(SerialNumber));

CREATE TABLE LibraryHub.BookCondition(
	ID smallint IDENTITY(1,1),
	Condition NVARCHAR(10) NOT NULL,
	FineModifier decimal(3,2) NOT NULL,
	CONSTRAINT PK_BookCondition PRIMARY KEY (ID));

CREATE TABLE LibraryHub.BookCopy(
	ID int IDENTITY(1,1),
	SerialNumber bigint NOT NULL,
	BookConditionID smallint NOT NULL,
	Notes nvarchar(max) NOT NULL DEFAULT N'',
	CONSTRAINT PK_BookCopy PRIMARY KEY (ID));

CREATE TABLE LibraryHub.Client(
	ID int IDENTITY(1, 1),
	Name nvarchar(30) NOT NULL,
	DateOfBirth date NOT NULL,
	NIF int NOT NULL,
	Contact int NOT NULL,
	Address nvarchar(max) NOT NULL,
	CONSTRAINT PK_Client PRIMARY KEY (ID));

CREATE TABLE LibraryHub.Rent(
	ID bigint IDENTITY(1, 1),
	ClientID int NOT NULL,
	BookCopyID int NOT NULL,
	StartDate datetime NOT NULL DEFAULT GETDATE(),
	DueDate datetime NOT NULL DEFAULT DATEADD(dd, 7, GETDATE()),
	CONSTRAINT PK_Rent PRIMARY KEY (ID));

CREATE TABLE LibraryHub.RentReception(
	RentID bigint,
	ReturnDate datetime NOT NULL DEFAULT GETDATE(),
	ReceivedConditionID smallint NOT NULL,
	TotalFine decimal(7, 2) NOT NULL,
	CONSTRAINT PK_DelayedRent PRIMARY KEY (RentID));


--Create relationships among tables altering them
ALTER TABLE LibraryHub.Book
ADD	CONSTRAINT FK_Book_Publisher_PublisherID FOREIGN KEY(PublisherID) REFERENCES LibraryHub.Publisher(ID);

ALTER TABLE LibraryHub.BookAuthor
ADD	CONSTRAINT FK_BookAuthor_Author_AuthorID FOREIGN KEY(AuthorID) REFERENCES LibraryHub.Author(ID),
CONSTRAINT FK_BookAuthor_Book_SerialNumber FOREIGN KEY(SerialNumber) REFERENCES LibraryHub.Book(SerialNumber);

ALTER TABLE LibraryHub.BookCategory
ADD	CONSTRAINT FK_BookCategory_Category_CategoryID FOREIGN KEY(CategoryID) REFERENCES LibraryHub.Category(ID),
CONSTRAINT FK_BookCategory_Book_SerialNumber FOREIGN KEY(SerialNumber) REFERENCES LibraryHub.Book(SerialNumber);

ALTER TABLE LibraryHub.BookStock
ADD CONSTRAINT FK_BookStock_Book_SerialNumber FOREIGN KEY(SerialNumber) REFERENCES LibraryHub.Book(SerialNumber);

ALTER TABLE LibraryHub.BookCopy
ADD CONSTRAINT FK_BookCopy_Book_SerialNumber FOREIGN KEY(SerialNumber) REFERENCES LibraryHub.Book(SerialNumber),
	CONSTRAINT FK_BookCopy_BookCondition_BookConditionID FOREIGN KEY(BookConditionID) REFERENCES LibraryHub.BookCondition(ID);

ALTER TABLE LibraryHub.Rent
ADD	CONSTRAINT FK_Rent_Client_ClientID FOREIGN KEY(ClientID) REFERENCES LibraryHub.Client(ID),
	CONSTRAINT FK_Rent_BookCopy_BookCopyID FOREIGN KEY(BookCopyID) REFERENCES LibraryHub.BookCopy(ID);

ALTER TABLE LibraryHub.RentReception
ADD	CONSTRAINT FK_RentReception_Rent_RentID FOREIGN KEY(RentID) REFERENCES LibraryHub.Rent(ID),
	CONSTRAINT FK_RentReception_BookCondition_ReceivedConditionID FOREIGN KEY(ReceivedConditionID) REFERENCES LibraryHub.BookCondition(ID);


--Populate tables
INSERT INTO LibraryHub.Publisher (Name)
VALUES (N'Porto Editora'), (N'Leya'), (N'Bloomsbury'), (N'Planeta'), (N'Editorial Presença'), (N'Gradiva'), (N'Plátano Editora'), (N'Edições Piaget'), (N'Grupo Lidel'), (N'Penguin'), (N'Bertrand Editora'), (N'Assírio & Alvim'), (N'Harper Collins'), (N'Quetzal Editores');

INSERT INTO LibraryHub.Author (Name)
VALUES (N'José Saramago'), (N'J.K. Rowling'), (N'Antoine de Saint-Exupéry'), (N'Luís de Camões'), (N'Camilo Castelo Branco'), (N'Eça de Queirós'), (N'Almeida Garret'), (N'Fernando Pessoa'), (N'Vergílio Ferreira'), (N'Sophia de Mello Breyner'), (N'Stephen King'), (N'J.R.R. Tolkien'), (N'Bernado Soares');

INSERT INTO LibraryHub.Category (Name)
VALUES (N'Classic'), (N'Romance'), (N'Science fiction'), (N'Fantasy'), (N'Horror'), (N'Thriller'), (N'Crime'), (N'Historical Romance'), (N'Contemporary Romance'), (N'Psychological Fiction'), (N'Dystopian Fiction'), (N'Adventure'), (N'Young Adult'), (N'Humor'), (N'Drama'), (N'Childrens Literature'), (N'Portuguese Literature'), (N'Foreign Literature');

INSERT INTO LibraryHub.Book (SerialNumber, Title, Year,  FinePerDay, PublisherID)
VALUES (9789720049568, N'Os Lusíadas', 2009, 0.5, 1),
	(9789722521376, N'A Cidade e as Serras', 2010, 0.5, 11),
	(9789722325332, N'Harry Potter e a Pedra Filosofal', 2002, 1, 5),
	(9781408855652, N'Harry Potter and the philosopher''s stone', 2014, 1.5, 3),
	(9789720046710, N'O Memorial do Convento', 2014, 0.5, 1),
	(9789720727275, N'Amor de Perdição', 2016, 0.75, 1),
	(9789720727268, N'Viagens na Minha Terra', 2016, 0.75, 1),
	(9789722328296, N'O Principezinho', 2001, 0.55, 5),
	(9789723723410, N'O Livro do Desassossego', 2023, 1.2, 12),
	(9789720046833, N'Ensaio sobre a Cegueira ', 2015, 0.75, 1),
	(9789897773921, N'O Senhor dos Anéis - Parte 1: A Irmandade do Anel', 2020, 1, 4),
	(9780261102354, N'The Fellowship of the Ring - Book 1: The Lord of the Rings', 2006, 1.5, 13),
	(9789897221453, N'A Aparição', 2014, 0.6, 14),
	(9789720049575, N'Os Maias ', 2009, 0.5, 1),
	(9789720726216, N'A Menina do Mar', 2012, 0.55, 1);

INSERT INTO LibraryHub.BookAuthor (SerialNumber, AuthorID)
VALUES (9789720049568, 4), (9789722521376, 6), (9789722325332, 2), (9781408855652, 2),
	(9789720046710, 1), (9789720727275, 5), (9789720727268, 7), (9789722328296, 3),
	(9789723723410, 8), (9789723723410, 13), (9789720046833, 1), (9789897773921, 12),
	(9780261102354, 13), (9789897221453, 9), (9789720049575, 6), (9789720726216, 10);

INSERT INTO LibraryHub.BookCategory (SerialNumber, CategoryID)
VALUES (9789720049568, 1), (9789720049568, 17), (9789722521376, 1), (9789722521376, 9),
	(9789722521376, 17), (9789722325332, 4), (9789722325332, 13), (9781408855652, 4),
	(9781408855652, 13), (9781408855652, 18), (9789720046710, 2), (9789720046710, 17),
	(9789720727275, 2),	(9789720727275, 13), (9789720727268, 2), (9789720727268, 17),
	(9789722328296, 16), (9789723723410, 1), (9789723723410, 17), (9789720046833, 2),
	(9789720046833, 17), (9789897773921, 4), (9780261102354, 4), (9780261102354, 18),
	(9789897221453, 2),	(9789720049575, 2),	(9789720049575, 9),	(9789720049575, 10),
	(9789720726216, 16);

INSERT INTO LibraryHub.BookStock (SerialNumber, TotalAmount, AvailableAmount)
VALUES (9789720049568, 6, 5), (9789722521376, 3, 3), (9789722325332, 3, 2), 
	(9781408855652, 1, 0), (9789720046710, 6, 6), (9789720727275, 3, 3), 
	(9789720727268, 2, 2), (9789722328296, 5, 5), (9789723723410, 4, 4), 
	(9789720046833, 2, 2), (9789897773921, 4, 4), (9780261102354, 1, 1), 
	(9789897221453, 4, 4), (9789720049575, 7, 6), (9789720726216, 5, 5); 

INSERT INTO LibraryHub.BookCondition (Condition, FineModifier)
VALUES (N'As new', 1), (N'Good', 0.75), (N'Used', 0.5), (N'Bad', 0.25); 

INSERT INTO LibraryHub.BookCopy (SerialNumber, BookConditionID, Notes)
VALUES (9789720049568, 1, N''), 
	(9789720049568, 2, N'Minor shelf wear'), 
	(9789720049568, 2, N'Minor scratches on cover'), 
	(9789720049568, 2, N'Slight corner creases'), 
	(9789720049568, 3, N'Annotations on some pages'), 
	(9789720049568, 4, N'Torn cover'), 
	(9789722521376, 1, N''), 
	(9789722521376, 2, N'Light edge wear'), 
	(9789722521376, 2, N'Minimal wear on spine'), 
	(9789722325332, 1, N''), 
	(9789722325332, 3, N'Highlighting in text'), 
	(9789722325332, 3, N'Worn corners'), 
	(9781408855652, 1, N''), 
	(9789720046710, 1, N''), 
	(9789720046710, 1, N''), 
	(9789720046710, 3, N'Some folded pages'), 
	(9789720046710, 4, N'Water damage on cover'), 
	(9789720046710, 2, N'Slightly faded cover'), 
	(9789720046710, 3, N'Highlighting in text'), 
	(9789720727275, 1, N''), 
	(9789720727275, 2, N'No major damage'), 
	(9789720727275, 2, N'Minor scratches on cover'), 
	(9789720727268, 3, N'Discolored pages'), 
	(9789720727268, 2, N'Minor shelf wear'), 
	(9789722328296, 1, N''), 
	(9789722328296, 1, N''), 
	(9789722328296, 3, N'Worn edges'), 
	(9789722328296, 4, N'Torn cover'), 
	(9789722328296, 2, N'Slightly faded cover'), 
	(9789723723410, 1, N''), 
	(9789723723410, 1, N''), 
	(9789723723410, 1, N''), 
	(9789723723410, 2, N'Small pen marks'), 
	(9789720046833, 2, N'Minor dust stains'), 
	(9789720046833, 2, N'Previous owner''s signature'), 
	(9789897773921, 2, N'No major damage'), 
	(9789897773921, 2, N'Slightly bent cover'), 
	(9789897773921, 3, N'Underlining in pencil'), 
	(9789897773921, 3, N'Moderate wear'), 
	(9780261102354, 2, N'Light edge wear'), 
	(9789897221453, 1, N''), 
	(9789897221453, 2, N'Minor scuffs'), 
	(9789897221453, 2, N'Small pen marks'), 
	(9789897221453, 3, N'Creases on cover'), 
	(9789720049575, 3, N'Dog-eared pages'), 
	(9789720049575, 3, N'Faded spine text'), 
	(9789720049575, 4, N'Significant damage to pages'), 
	(9789720049575, 2, N'Minor dust stains'), 
	(9789720049575, 3, N'Cover worn'), 
	(9789720049575, 2, N'Minor shelf wear'), 
	(9789720049575, 1, N''), 
	(9789720726216, 1, N'Heavy annotations'), 
	(9789720726216, 3, N'Light edge wear'), 
	(9789720726216, 2, N'Minor dust stains'), 
	(9789720726216, 3, N'Dog-eared pages'), 
	(9789720726216, 2, N'Minor scuffs');

INSERT INTO LibraryHub.Client (Name, DateOfBirth, NIF, Contact, Address)
VALUES (N'Mafalda Andrade', CONVERT(date, '23/03/1993', 103), 233547574, 915869242, N'Rua de não sei, 21, 2ºD Aveiro'), 
	(N'Rui Sousa', CONVERT(date, '08/10/1993', 103), 893542174, 926548762, N'Rua das Flores, 10, 1º Esq, Aveiro'), 
	(N'Clara Castro', CONVERT(date, '12/07/1993', 103), 657451900, 935672313, N'Avenida da Liberdade, 45, 3º Dir, Aveiro'), 
	(N'Rute Almeida', CONVERT(date, '21/11/1991', 103), 964201831, 918239482, N'Travessa do Sol, 12, R/C, Aveiro'), 
	(N'Lara Andrade', CONVERT(date, '22/03/1997', 103), 234123532, 916384927, N'Rua da Esperança, 33, 2º Esq, Aveiro'), 
	(N'Sofia Ribeiro', CONVERT(date, '15/06/1995', 103), 291847362, 912345678, N'Rua do Norte, 28, 1º Andar, Aveiro'), 
	(N'Pedro Martins', CONVERT(date, '02/01/1990', 103), 845612379, 917654321, N'Largo da Estrela, 14, 2º Dir, Aveiro'), 
	(N'Carla Ferreira', CONVERT(date, '19/09/1988', 103), 756493812, 963258147, N'Rua da Saudade, 5, R/C, Aveiro'), 
	(N'Tiago Santos', CONVERT(date, '30/04/1992', 103), 678941253, 925431678, N'Avenida Central, 99, 1º Esq, Aveiro'), 
	(N'Ana Costa', CONVERT(date, '11/12/1994', 103), 549731862, 910987654, N'Rua Nova, 20, 2º Andar, Aveiro'), 
	(N'Luís Oliveira', CONVERT(date, '05/08/1993', 103), 831274659, 938726415, N'Praça do Comércio, 7, 1º Dir, Aveiro'), 
	(N'Joana Correia', CONVERT(date, '24/02/1991', 103), 764583921, 921345678, N'Rua dos Pescadores, 22, 3º Esq, Aveiro'), 
	(N'Ricardo Mendes', CONVERT(date, '07/07/1990', 103), 951783426, 919876543, N'Rua da Alegria, 15, R/C Esq, Aveiro'), 
	(N'Catarina Lopes', CONVERT(date, '14/05/1996', 103), 629584173, 932178945, N'Rua das Oliveiras, 40, 1º Dir, Aveiro'), 
	(N'Bruno Moreira', CONVERT(date, '28/11/1989', 103), 837291645, 911123456, N'Avenida do Mar, 18, R/C, Aveiro'); 

INSERT INTO LibraryHub.Rent (ClientID, BookCopyID, StartDate, DueDate)
VALUES (1, 13, CONVERT(date, '18/05/2024', 103), CONVERT(date, '25/05/2024', 103)), 
	(2, 5, CONVERT(date, '16/08/2024', 103), CONVERT(date, '23/08/2024', 103)), 
	(1, 8, CONVERT(date, '27/10/2024', 103), CONVERT(date, '03/11/2024', 103)), 
	(3, 16, CONVERT(date, '18/03/2024', 103), CONVERT(date, '25/03/2024', 103)), 
	(4, 17, CONVERT(date, '01/07/2024', 103), CONVERT(date, '08/07/2024', 103)), 
	(5, 33, CONVERT(date, '27/01/2024', 103), CONVERT(date, '03/02/2024', 103)), 
	(6, 43, CONVERT(date, '11/05/2024', 103), CONVERT(date, '18/05/2024', 103)), 
	(7, 56, CONVERT(date, '21/02/2024', 103), CONVERT(date, '28/02/2024', 103)), 
	(5, 47, CONVERT(date, '12/03/2024', 103), CONVERT(date, '19/03/2024', 103)), 
	(8, 6, CONVERT(date, '25/07/2024', 103), CONVERT(date, '01/08/2024', 103)), 
	(9, 49, CONVERT(date, '17/10/2024', 103), CONVERT(date, '24/10/2024', 103)), 
	(10, 27, CONVERT(date, '22/06/2024', 103), CONVERT(date, '29/06/2024', 103)), 
	(11, 45, CONVERT(date, '01/08/2024', 103), CONVERT(date, '08/08/2024', 103)), 
	(12, 28, CONVERT(date, '27/07/2024', 103), CONVERT(date, '03/08/2024', 103)), 
	(13, 12, CONVERT(date, '05/03/2024', 103), CONVERT(date, '12/03/2024', 103)), 
	(14, 11, DEFAULT, DEFAULT); 

INSERT INTO LibraryHub.RentReception (RentID, ReturnDate, ReceivedConditionID, TotalFine)
VALUES (3, CONVERT(date, '04/11/2024', 103), 2, 0.375),
	(4, CONVERT(date, '25/03/2024', 103), 3, 0),
	(5, CONVERT(date, '12/07/2024', 103), 4, 0.5),
	(6, CONVERT(date, '06/02/2024', 103), 2, 2.7),
	(7, CONVERT(date, '20/05/2024', 103), 2, 0.9),
	(8, CONVERT(date, '28/02/2024', 103), 2, 0),
	(10, CONVERT(date, '01/08/2024', 103), 4, 0.125),
	(11, CONVERT(date, '27/10/2024', 103), 3, 0.75),
	(12, CONVERT(date, '29/06/2024', 103), 3, 0),
	(13, CONVERT(date, '08/08/2024', 103), 3, 0),
	(14, CONVERT(date, '04/08/2024', 103), 4, 0.4125),
	(15, CONVERT(date, '12/03/2024', 103), 3, 0);

COMMIT;
END TRY

BEGIN CATCH
SELECT
            ERROR_NUMBER() AS ErrorNumber
            ,ERROR_SEVERITY() AS ErrorSeverity
            ,ERROR_STATE() AS ErrorState
            ,ERROR_PROCEDURE() AS ErrorProcedure
            ,ERROR_LINE() AS ErrorLine
            ,ERROR_MESSAGE() AS ErrorMessage;
ROLLBACK
END CATCH