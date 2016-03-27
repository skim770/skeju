
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
