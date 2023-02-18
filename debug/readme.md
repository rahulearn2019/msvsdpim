## Importing spice netlist to magic tool. 
Note - this spice netlist is generated in .xschem/simulations (.xschem is a hidden folder which can be seen after you enable view hidden files in home gui or using the command 
ls -aslrt in terminal, here option a gives you the hidden files)

![Screenshot from 2023-02-12 14-42-20](https://user-images.githubusercontent.com/50217106/218303736-fea5850f-2e15-4f3c-a75f-7f175ed84eb0.png)

When spice is imported the topmost cell( a black box with all the FETs and PINs inside is seen). 
![Screenshot from 2023-02-12 14-43-03](https://user-images.githubusercontent.com/50217106/218303771-e2d0ca72-7202-48c6-80be-04cd677dbf79.png)



![Screenshot from 2023-02-12 14-43-07](https://user-images.githubusercontent.com/50217106/218303800-070bdde8-d29c-400e-93ed-e15abc1c8a90.png)
You can use two ways to go to the bottom hierarchy to perform layout
1. place user controlled box over the black box(visible top level cell) and go to edit->select area. This selects the topmost cell now go to windows and then down hierarchy. You can see the cells and fets.
2. hover over the topmost cell and press i to select and x to go to bottom hierarchy.

Now, it might happens that only pins are imported and not the fets, this seems to be a magic error. It is recommeneded to close magic. 
![Screenshot from 2023-02-12 14-43-16](https://user-images.githubusercontent.com/50217106/218303802-d378d1b7-a46a-498f-b4b3-2d92544ba38b.png)
Delete the .mag file created in this process as it will interefere when you try to import spice again. In my case inverter.mag is deleted
Now re-import spice, and go to bottom hierarchy.
![Screenshot from 2023-02-12 14-44-06](https://user-images.githubusercontent.com/50217106/218303805-6d20a37f-d925-48db-8824-9561c5578c36.png)
To move the cells, hover over the fets and press i to select and take the cursor where you want to move the fets and press m.
This method might not work instantly, but after zomming in and out and trying it multiple times it works.
To move the pins, try the above method- If it doesn't work, try the following:
- make a user controlled slightly larger than the pins over the pins and select area. Now place the user box to the location where you want to place the pins and press m
![Screenshot from 2023-02-12 14-44-18](https://user-images.githubusercontent.com/50217106/218303808-412cb943-832d-42cf-b38c-dc95358cb18c.png)


### cannot remove topmost cell in the window with pins and fets imported
click on edit->select select area option->click on delete


# Nightmare with ALIGN tool - You are not Alone!




