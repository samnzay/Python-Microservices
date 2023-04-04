#import smtplib, os,json
#from email.message import EmailMessage

import sendgrid
import os
from sendgrid.helpers.mail import *

def notification(message): #message from our Queue
    try:
        
        message = json.loads(message)
        mp3_fid = message["mp3_fid"]
        sender_address = os.environ.get("GMAIL_ADDRESS")
        sender_password = os.environ.get("GMAIL_PASSWORD")
        receiver_address = message["username"]

        # GMAIL SMTP
        '''
        msg = EmailMessage()
        msg.set_content(f"mp3 file_id: {mp3_fid} is ready for download")
        msg["Subject"] = "MP3 Download"
        msg["From"] = sender_address
        msg["To"] = receiver_address

        session = smtplib.SMTP("smtp.gmail.com", 465) #587
        #session.ehlo()
        session.starttls
        session.login(sender_address, sender_password)
        session.send_message(msg, sender_address, receiver_address)
        session.quit()

        print("Mail Sent")
        '''

        # SENDGRID

        sg = sendgrid.SendGridAPIClient(api_key=os.environ.get('SENDGRID_API_KEY'))
        from_email = Email(sender_address)
        to_email = To(receiver_address)
        subject = "MP3 Download"
        content = Content("text/plain", f"mp3 file_id: {mp3_fid} is ready for download")
        mail = Mail(from_email, to_email, subject, content)
        response = sg.client.mail.send.post(request_body=mail.get())
        print(response.status_code)
        print(response.body)
        print(response.headers)

    except Exception as err:
        print(err)
        return err
