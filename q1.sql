SELECT RoomID, TypeDescription, MotelName, PricePerNight
FROM Room
JOIN RoomType
 ON Room.TypeID = RoomType.TypeID
JOIN Motel
ON Room.MotelID = Motel.MotelID
WHERE RoomID NOT IN
(SELECT RoomID
 FROM Booking);
