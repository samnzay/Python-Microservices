import os, requests
#Note that the above requests is different from flask request
def login(request):
    auth = request.authorization
    if not auth:
        return None, ("Ooops, missing credentials!", 401)
    
    basicAuth =(auth.username, auth.password)
    print("Received you credentials")

    response = requests.post(
        f"http://{os.environ.get('AUTH_SVC_ADDRESS')}/login", auth=basicAuth
    )
    print("Response Recieved from Auth-services")

    if response.status_code == 200:
        return response.text, None
    else:
        return None, (response.text, response.status_code)