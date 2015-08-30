# opencv-raspberry

OpenCV container for running on Raspberry Pi. 

Use Hypriot SD boot images (http://blog.hypriot.com/downloads/) in order to get a good ready to go OS for Docker containers on Raspberry.

This container will run a SSH server inside it so that you can export the screen to a X Window server on your machine. Perform the following steps:
  * Start Raspberry Pi and type "docker run -p 2222:22 flaviostutz/opencv-raspberry"
  * On another machine (with X Window server installed), type "ssh -X root@[RaspberryPi IP]:2222" (password is "root")
  * Using SSH sessions, upload files and run OpenCV programs. 
  * If any software launches a screen, it will be shown on your X Window server
