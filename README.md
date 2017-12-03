# UBCHacks2017


# Endpoints

## nearby yotes
GET: /api/yotes/?lat=lat&lng=lng&height=height
### Response:
   
## create yote
POST: /api/yote

Body: {
 "YoteId": 0,
 "Data": 'a',
 "X": 0.0,
 "Y": 0.0,
 "Z": 0.0
}

Returns: yote with id
