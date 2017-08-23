﻿CREATE TABLE dbo.ScheduleInterview (
	Id INT IDENTITY(1,1) PRIMARY KEY,	
	MeetingDate DATETIME NOT NULL,
	IsCancelled TINYINT DEFAULT 0,
	CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
	CandidateId INT REFERENCES dbo.Candidate(Id) NOT NULL,
	Document VARCHAR(8000) DEFAULT NULL,
	HrId  INT REFERENCES dbo.Employee(Id) NOT NULL,
	ModifedDate DATETIME DEFAULT NULL,
	ModifedBy INT REFERENCES dbo.Employee(Id) DEFAULT NULL
);