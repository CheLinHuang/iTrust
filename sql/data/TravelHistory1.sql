INSERT INTO TravelHistories
(patientMID,
startDate,
endDate,
travelledCities
)
VALUES
(
16,
CONCAT(YEAR(NOW())-10, '-06-04 10:30:00'),
CONCAT(YEAR(NOW())-5, '-06-04 10:30:00'),
'Vancouver,Canada, Cancun, Mexico'
);