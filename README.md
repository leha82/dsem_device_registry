# DSEM Device Registry
DSEM Device Registry (DR) is a web-based system to register and manage device information for DSEM Semantic IoT Platform. IoT devices have various specifications and versions, and DR registers and manages the specifications of these devices as metadata. DR can register the specifications of the device itself and the information of the sensors and actuators of the device.

First, DR itemizes devices considering that multiple devices of the same specification will be deployed. DR manages information of items by dividing them into global metadata and specific metadata. Global metadata refers to metadata that all items have in common, such as general information such as the model name and manufacturer of the item, and specific metadata refers to the type of sensor and actuator that each item can have differently.

The DR can register the device after registering the item.If an item has the same meaning as a kind of IoT device product information, the device can be referred to as things that the user purchases and installs.

## Configuration File Setting
1. open folder in src/main/webapp
2. copy and rename config_templete.json to config.json
3. fill the contents of json file
4. save config file

## Eclipse Project Setting
1. Clone this repository and make dynamic web project in eclipse.
2. Make sure that all libraries in lib folder are added in build path configuration.
3. Due to perform smoothly the tomcat, copy mysql-connector-java-8.0.22.jar file into Tomcat lib folder in tomcat's source folder.
