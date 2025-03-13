SELECT RoomID, TypeDescription, PricePerNight, MotelName
FROM Room
JOIN RoomType
	ON Room.TypeID = RoomType.TypeID
JOIN Motel
	ON Room.MotelID = Motel.MotelID
WHERE PricePerNight < 200 AND Motel.MotelID = 1