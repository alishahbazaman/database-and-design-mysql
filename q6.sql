-- SELECT MotelName, COUNT(Motel.motelID)
-- FROM Booking
-- JOIN Motel
-- 	ON Booking.MotelID = Motel.MotelID
-- GROUP BY Motel.motelID
-- ORDER BY COUNT(Motel.motelID) DESC

SELECT MotelName, COUNT(Booking.motelID) AS MostBooking
FROM Motel
JOIN Booking
	ON Booking.MotelID = Motel.MotelID
GROUP BY Booking.motelID
ORDER BY COUNT(Motel.motelID) DESC