CREATE PROCEDURE dbo.uspGetEvaluationFormByScheduleId
	@scheduleId INT
AS
BEGIN
	SELECT eval.Id AS id,
		   eval.Notes AS notes,
		   eval.CreatedDate AS createdDate,
		   eval.JSONData AS jsonData,
		   e.FirstName AS EmployeeName,
		   e.LastName AS EmployeeSurname,
		   sIe.MeetingDate AS meetingDate
		   FROM dbo.EvaluationForm eval 
		   INNER JOIN dbo.Employee e
		   ON eval.EmployeeId = e.Id
		   INNER JOIN dbo.ScheduleInterview sIe
		   ON eval.ScheduleIntervieweId = sIe.Id
		   WHERE eval.ScheduleIntervieweId = @scheduleId
END;