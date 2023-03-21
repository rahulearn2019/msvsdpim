# RTL2GDS of the Analog design using openROAD( invoked by openFASOC)

With the necessary input files - gds of analog blocks and their dummy verilog we can proceed with the openFASOC flow to generate the complete analog block GDS.
A directory - avsd4bituc, is created in the generators directory of openfasoc
![Screenshot from 2023-03-21 21-58-23](https://user-images.githubusercontent.com/50217106/226677270-e1751ed4-8883-4d6b-a6fb-809adadde9a7.png)

The necessary sub-directories for avsd4bituc are created.

![Screenshot from 2023-03-21 03-45-24](https://user-images.githubusercontent.com/50217106/226679150-da9f3152-0875-4fb8-bbee-5d908d267302.png)

contents of the test.json file
![Screenshot from 2023-03-21 21-55-28](https://user-images.githubusercontent.com/50217106/226679622-c338be0f-15bc-4068-bf26-8f03b4304bc7.png)

modifications in toplevel makefile - edit the commands that will be used for different purposes - verilog generation, rtl2gds etc.
![Screenshot from 2023-03-21 03-45-33](https://user-images.githubusercontent.com/50217106/226678613-44fdf5ba-1ee5-41a2-8268-d09fc99f936d.png)

contebts of the tools directory 

![Screenshot from 2023-03-21 21-58-33](https://user-images.githubusercontent.com/50217106/226680028-e45414a2-0a3d-48de-8699-02d96ee274ef.png)

avsd4bituc-gen.py file is created and modifed as shown
![Screenshot from 2023-03-21 20-17-21](https://user-images.githubusercontent.com/50217106/226677709-4fb05f65-b7c4-4a53-a69d-0b7e68b4f9c4.png)

avs
