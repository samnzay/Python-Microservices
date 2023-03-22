import pika, json

def upload(f, fs, channel, access):
    
    try:
        #Fist, Upload file into Mongo DB and trturn the file ID (fid).
        fid = fs.put(f)
    except Exception as err:
        #Return err if uplaod into db failed.
        print(err)
        return "internal server error", 500
    
    message = {
        "video_fid": str(fid),
        "mp3_fid": None,
        "username": access["username"],
    }
    
    # If file uploaded, put to rabbitmq message queue 
    try:
        channel.basic_publish(
            exchange="",
            routing_key="video",
            body= json.dumps(message),
            properties= pika.BasicProperties(
                delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE
        ),
        )
    #If message queuing is failed delete the file from mongo DB. as it wil never be processed.
    except Exception as err:
        print(err)
        fs.delete(fid)

        return "Internal server Error", 500