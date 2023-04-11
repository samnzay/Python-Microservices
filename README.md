# PYTHON BASED MICROSERVICES

## VIDEO TO MP3 CONVERSION MICROSERVICES

### Basic Application Architecture

- [System Architecture](architecture/python-Microservices.jpeg)

![System Architecture](architecture/python-Microservices.jpeg)

#### Video To MP3 Conversion Flow:

1. User Submit Video upload Request with Credentials through The ```API Gateway```.

2. The User Get Authenticated by the ```Auth Service``` .

3. Once Submitted Credentials are valid, the Auth Service resturn a JWT Token to the user to Access Services.

4. Video File is stored into ```Dynamo DB``` .

5. A Message is `produced` and stored into ```Message Queue Service``` [in the queue named `video` for example] containing the ID of the Video File.

- When storing messages fails, the video file will be deleted as it will never be consumed, and return the Error.

6. The ```MP3 Converter Service``` consume the message from the Queue identified by Unique ID.

7. The ```MP3 Converter Service``` checks and retrieves a video to be converted into mp3, from Dynamo DB, identified by same ID of the Message.

8. The finished `MP3 file` is stored into Dynamo DB. 

9. A Message is `produced` and stored into Message Queue Service, [ In the queue named `mp3` for example ].

    - When storing messages fails, the mp3 file will be deleted as it will never be consumed, and notify for the Error.

10. ```Notification Service``` Consumes the message from the `mp3` queue. To Notify User (`Client`) the MP3 file is available for Download.

    - When storing messages fails, the mp3 file will be deleted as it will never be consumed, and return the Error.

11. The ```Notification Service``` sends email message tho the user (`Client`) including the ID of the MP3 file ready to be downloaded.

12. The User (`Client`) Finally makes MP3 download request.


### A. Dependencies

#### A.1. Python
[Download and install the python](https://www.python.org/downloads/).

#### A.2. Docker Desktop
You would require you to install Docker Desktop to create containers for individual microservices. Refer the following links for instructions 
* [macOS](https://docs.docker.com/docker-for-mac/install/), 
* [Windows 10 64-bit: Pro, Enterprise, or Education](https://docs.docker.com/docker-for-windows/install/), 
* [Windows  10 64-bit Home](https://docs.docker.com/toolbox/toolbox_install_windows/). 
* You can find installation instructions for other operating systems at:  https://docs.docker.com/install/

#### A.3. Kubernetes 
You would need to install any one tool for creating a Kubernetes cluster - KubeOne / Minikube / kubectl on top of Docker Desktop:
1. [Install and Set Up kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) directly on top of Docker desktop - For Windows/macOS
2. [Install Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) - For Linux/macOS

#### A.4. Make
1. [Install Make on Windows](https://linuxhint.com/install-use-make-windows/)
2. [Install Make on Linux](https://linuxhint.com/install-use-make-ubuntu/)

#### Project Setup Instructions (`coming soon`)
