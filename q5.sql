SELECT FirstName, LastName, RoomID, StartDate, EndDate, MAX(TotalCharge) AS TotalCharge
FROM Booking 
 JOIN Guest
 	ON Guest.GuestID = Booking.GuestID
 GROUP BY BookingID
 ORDER BY TotalCharge DESC