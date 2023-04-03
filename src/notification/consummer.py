import pika, sys, os, time
from send import email

def main():

    #RABBITMQ CONNECTION
    connection = pika.BlockingConnection(
        pika.ConnectionParameters(host="rabbitmq")# Service name in Kubernetes resolves to the Host
        )
    channel = connection.channel()

    def callback(ch, method, properties, body):
        err = email.notification(body)

        if err:
            ch.basic_nack(delivery_tag=method.delivery_tag)
        else:
            ch.basic_ack(delivery_tag=method.delivery_tag)

    channel.basic_consume(
        queue= os.environ.get("MP3_QUEUE"), on_message_callback=callback
    )


    print("Waititing for messages. Press CTRL+C to Exit")
    channel.start_consuming()

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(" Message Consummer Interrupted")

        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)


