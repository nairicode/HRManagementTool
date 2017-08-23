﻿CREATE TABLE dbo.Candidate
(
	Id INT IDENTITY (1,1) PRIMARY KEY,
	FirstName VARCHAR(255) NOT NULL,
	LastName VARCHAR(255) NOT NULL,
	PhoneNumber VARCHAR(20) NOT NULL,
	Email VARCHAR(254) NOT NULL,
	[Address] VARCHAR(254) NOT NULL,
	CV VARCHAR(MAX) NOT NULL,
	PositionId INT REFERENCES dbo.PositionTypes(Id) NOT NULL,
	RoleId INT REFERENCES dbo.RoleTypes(Id) NOT NULL,
	StatusId INT REFERENCES dbo.CandidateStatusTypes(Id) NOT NULL,
	CreatedBy INT REFERENCES dbo.Employee(Id) NOT NULL,
	CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT CK_CANDIDATE_ValidEmail CHECK (dbo.fnValidateEmail(Email) = 1)
);