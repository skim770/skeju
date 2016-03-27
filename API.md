skejuserver
========

Web Server / REST API

## End Points:

# Specifications
## Authentication
### Authenticate a user
To authenticate a user, send a GET request to /auth
 with the parameter name set to your username.
This request is responded by a unique int : userId. -1
is returned if the username does not exist
#### Request
| Request Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| username            | String	| Username being authenticated. |

```
GET /users/auth?username=<user_name>

GET /users/auth?username=tim

GET /users/auth?username="Tim"
```

#### Response
| Response Variable        | Type          | Description  |
| -------------   | ------------- | ------------ |
| userId          | int	          | The GUID generated. Returns -1 on fail  |
| username | String | A user's name. Returns null on fail|
```
{
	"userId" : 1234		// -1 if user does not exist
	"username": Cruise // NULL if user does not exist
}
```
## Users
### Get all users
To request a list of all existing users, send a GET request to /users with no parameters. This will return a JSON list of user's usernames as Strings
#### Request
```
GET /users/all
```
#### Response
| Response Variable       | Type          | Description  |
| -------------   | ------------- | ------------ |
| username | String | A user's name |
| userId | int | A user's GUID |
```
[
	{ "username" : "Doug", "userId" : 123674 },
	{ "username" : "Bill", "userId" : 61563 },
	{ "username" : "Tom", "userId" : 25333 },
	{...}
]
```

### Get user info
To request information regarding an existing user, send a GET request to /users with the parameter userId.
#### Request

```
GET /users/<user_id>
GET /users/66965
```

#### Response
| Response Variable       | Type          | Description  |
| -------------   | ------------- | ------------ |
| username | String | The username of the user in interest |
| userId   |  int | The GUID for the user |
```
{
   "username":"Bob",
   "userId":66965
}
```

### Get all groups that a user is in
To request information regarding which groups a user is in, send a GET request to /users/<userId>/groups with the parameter userId.
This will return a JSON list of groupnames and groupIds.
#### Request
```
GET /users/<userId>/groups
GET /users/66965/groups
```

#### Response
| Response Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| groupId | int	  | The GUID for the user |
| groupname | String | The username of the user in interest |

```
[
   { "groupId":24328, "groupname":"Water Cooler" },
   { "groupId":93243, "groupname":"CS 3251 Project" },
   { ... }
]
```

### Create a user
To create a user, send a POST request to /users passing the parameter username. The username and userId will be returned.
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| username | String | Name of the user being created |
```
POST /users?username=<username>
POST /users?username=Ted
POST /users?username="Ted"
```

#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| userId | int | The GUID of the user |
| username | String | The name of the user |
```
	{ "username" : "Ted", "userId" : 2345546 }
```

### Update user info - Status Incomplete
To update information of an existing user, send a POST request to /users/<userId>/update with the parameter username.
#### Requests
```
POST /users/<user_id>/update?username=<username>
POST /users/66965/update?username=Tom
POST /users/66965/update?username="Tom"
```
#### Response
| Response Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| userId            | int	  | The GUID for the user |
| username | String | The username of the user in interest |
```
{
	"userId":66965,
	"username":"Bob"
}
```
### Delete a user
To delete a user, send a DELETE request to /users passing the parameter userId. The username and userId will be returned.
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| userId | int | Name of the user being deleted |
```
DELETE /users?userId=<userId>
DELETE /users?userId=123
```

#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| status | boolean | Success/Fail Status of request |
```
Success
	{ "status" : true }
Fail
    { "status" : false }
```

## Group
### Get all groups
To request a list of all existing groups, send a GET request to /groups/all. Note that whenever a message is sent a group is created, so not all groups will have groupnames
#### Request
```
GET /groups/all
```
#### Response
| Response Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| groupId | int | The group's GUID |
| groupname | String | Name of the group |

```
[
	{ "groupname" : "Klaus", "groupId" : 1 },
	{ "groupname" : "SW", "groupId" : 2 },
	{ "groupname" : "Default", "groupId" : 3 } // Default will be String of group member's userIds
]
```
### Get a group's info by groupId
To request a list of all existing groups, send a GET request to /groups/all. Note that whenever a message is sent a group is created, so not all groups will have groupnames
#### Request
```
GET /groups/<groupId>
```
#### Response
| Response Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| groupname | String | Name of the group |
| groupId | int | The group's GUID |

```
{ "groupname":"Klaus", "groupId":1 }
```
### Get all users in a group
#### Request
```
GET /groups/{groupId}/users
```
#### Response
```
[
	{"userId" : 1234, "username" : "Ted"},
	{"userId" : 1235, "username" : "Bill"},
	{...}
]
```
### Get all messages in a group - Status Incomplete
#### Request
```
GET /groups/{groupId}/messages
```
#### Response
```
[
	{ "messageId": 100, "senderId" : 1000, "dateCreated" : 34623754762354, "content" : "Hey Doug." },
	{ "messageId": 101, "senderId" : 3295, "dateCreated" : 34623754762378, "content" : "Hey Ted, what is up." },
	{ ... }
]
```

### Create a group
To create a group, send a POST request to /groups with the parameter groupname
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| groupName | String | The desired name of the group |
```
POST /groups/create?groupname="Chatroom"
```
#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| groupName | String | The desired name of the group |
| groupId | int | The GUID for the group |
```
{ "groupname":"Chatroom", "groupId":1502940243 }
```

### Add a User to a group
To add a user to a group, send a POST request to /groups with the parameter groupname
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| groupId | int | The GUID for the group |
| userId | int | The GUID for the user |
```
POST /groups/add?groupId=<groupId>&userId=<userId>
```
#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| groupId | String | The desired name of the group |
| participantIds | int[] | The GUID for the users |
```
Success
{
	"groupId" : 100
}
Failure
{
	-1
}
```

## Messages
### Send a message - Status Incomplete
To send a message, send a POST request to /message as a JSON object containing the parameters: senderId, recipientIds, and content.
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| senderId | int | The userId of the user sending the message  |
| recipientIds | String[] | The userIds for the users the message is being sent to. Note it is a String array |
| content | String | The contents of the message being sent |
```
POST /messages?senderId=<senderId>&recipientIds=<recipientIds>&content=<content>
POST /messages?senderId=4&recipientIds=6,5,9,10&content="Hello-844"
```
#### Response
| Response Variables | Type | Description  |
| ------------- | ------------- | ------------ |
| success | boolean | Returns true if the message was delivered  |
| messageId | int | The generated GUID for the message |
| dateCreated | long | Time in milliseconds that the message was sent |
| groupId | int | If it is a unqiue combination of sender and recipients a new groupId is created, otherwise it will use the groupId that already exists |
| content | String | The contents of the message |

```
Message
{
	"messageId": 19
	"senderId": 123
	"dateCreated":"1435121073000"
	"content": "Woof"
	"groupId": 12
}
```
## Notifications
### Get a user's notifications - Status Incomplete
The client should periodically send GET requests to  /notifications/{userId} to retrieve notifications on messages sent to that user.
#### Request
```
GET /notifications/{userId}
```
#### Response
```
[
	{ "messageId": 100, "senderId" : 1234, "dateCreated" : 34623754762354, "content" : "Hey Doug", },
	{ "messageId": 101, "senderId" : 1235, "dateCreated" : 34623754762378, "content" : "Hey Ted, thanks for the text",  }
]
```

### Create an event ("calendar event") - Conversion TBD
To create an event, send a POST request to /events passing the parameter eventname. The username and userId will be returned.
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| eventname | String | Name of the event being created |
```
POST /events?eventname=<eventname>
POST /events?eventname=Lunch
POST /events?eventname="Lunch"
```

#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| eventId | int | The GUID of the event |
| eventname | String | The name of the event |
```
	{ "eventname" : "Lunch", "eventId" : 2345546 }
```

### Update event info - Status Incomplete
To update information of an existing event, send a POST request to /events/<eventId>/update with the parameter eventname.
#### Requests
```
POST /events/<event_id>/update?eventname=<eventname>
POST /events/66965/update?eventname=Office Hour
POST /events/66965/update?eventname="Office Hour"
```
#### Response
| Response Parameter       | Type          | Description  |
| -------------   | ------------- | ------------ |
| eventId            | int	  | The GUID for the event |
| eventname | String | The eventname of the event in interest |
```
{
	"eventId":66965,
	"eventname":"Bob"
}
```
### Delete an event
To delete a event, send a DELETE request to /events passing the parameter eventId. The eventname and eventId will be returned.
#### Request
| Request Parameter | Type | Description  |
| ------------- | ------------- | ------------ |
| eventId | int | Name of the event being deleted |
```
DELETE /events?eventId=<eventId>
DELETE /events?eventId=123
```

#### Response
| Response Variable | Type | Description  |
| ------------- | ------------- | ------------ |
| status | boolean | Success/Fail Status of request |
```
Success
	{ "status" : true }
Fail
    { "status" : false }
```
