import pika, json, tempfile, os
from bson.objectid import ObjectId

import moviepy.editor

def start(message, fs_videos, fs_mp3s, channel):
    message = json.loads(message)

    # Empty temp file
    tf = tempfile.NamedTemporaryFile()

    # Video Contents
    out = fs_videos.get(ObjectId(message["video_fid"]))

    #Add video content to empty file
    tf.write(out.read())

    #Create Audio from Temp Video file
    audio = moviepy.editor.VideoFileClip(tf.name).audio
    tf.close

    #Write Audio to the File
    tf_path = tempfile.gettempdir()+ f"/{message['video_fid']}.mp3"
    audio.write_audiofile(tf_path)

    #Save File to MongoDB
    f = open(tf_path, "rb")
    data = f.read()
    fid = fs_mp3s.put(data)
    f.close()
    os.remove(tf_path)

    message["mp3_fid"] = str(fid)
    
    # Publish Message to Queue Service When Mp3 file is Finished
    try:
        channel.basic_publish(
            exchange="",
            routing_key= os.environ.get("MP3_QUEUE"),
            body=json.dumps(message),
            properties = pika.BasicProperties(
                delivery_mode= pika.spec.PERSISTENT_DELIVERY_MODE
            ),
        )
    except Exception as err:
        fs_mp3s.delete(fid)
        return ("Ooops! failed to publish message", err)
