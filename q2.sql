SELECT MotelName, COUNT(Room.MotelID) AS NumOfRoomsManaged
FROM Room
JOIN Motel
	ON Room.MotelID = Motel.MotelID
GROUP BY Room.MotelID
ORDER BY COUNT(Room.MotelID) DESC
