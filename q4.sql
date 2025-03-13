SELECT FirstName, LastName, MobilePhone, COUNT(Guest.GuestID) AS NumOfBooking
FROM Guest 
JOIN Booking
	ON Guest.GuestID = Booking.GuestID
GROUP BY Guest.Guestid
HAVING COUNT(Guest.GuestID) > 1