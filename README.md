# msvsdpim
## week0
### Getting the tools
- open_pdks
- magic 
- ngspice 
- xschem
- Align - 
#### Analog Layout Intelligently generated from netlists
About :
#### ALIGN is an open source automatic layout generator for analog circuits jointly developed under the DARPA IDEA program by the University of Minnesota, Texas A&M University, and Intel Corporation.

![image](https://user-images.githubusercontent.com/50217106/218092464-0208dbd9-ac05-4b9a-9f00-ee752b3f90d3.png)


- The goal of ALIGN (Analog Layout, Intelligently Generated from Netlists) is to automatically translate an unannotated (or partially annotated) SPICE netlist of an analog circuit to a GDSII layout. The repository also releases a set of analog circuit designs.

The ALIGN flow includes the following steps:

Circuit annotation creates a multilevel hierarchical representation of the input netlist. This representation is used to implement the circuit layout in using a hierarchical manner. Design rule abstraction creates a compact JSON-format represetation of the design rules in a PDK. This repository provides a mock PDK based on a FinFET technology (where the parameters are based on published data). These design rules are used to guide the layout and ensure DRC-correctness. Primitive cell generation works with primitives, i.e., blocks at the lowest level of design hierarchy, and generates their layouts. Primitives typically contain a small number of transistor structures (each of which may be implemented using multiple fins and/or fingers). A parameterized instance of a primitive is automatically translated to a GDSII layout in this step. Placement and routing performs block assembly of the hierarchical blocks in the netlist and routes connections between these blocks, while obeying a set of analog layout constraints. At the end of this step, the translation of the input SPICE netlist to a GDSII layout is complete.

### Installing Align:
### 
### Prerequisites:
- gcc >= 6.1.0( for C++14 support) 
- Python >= 3.7 


Using the following command to install the Align tool:

```
export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
git clone https://github.com/ALIGN-analoglayout/ALIGN-public
cd ALIGN-public

#Create a Python virtualenv
python -m venv general
source general/bin/activate
python -m pip install pip --upgrade

### Install ALIGN as a USER
pip install -v .

### Install ALIGN as a DEVELOPER
pip install -e .

pip install setuptools wheel pybind11 scikit-build cmake ninja
pip install -v -e .[test] --no-build-isolation
pip install -v --no-build-isolation -e . --no-deps --install-option='-DBUILD_TESTING=ON'
```
Testing Align tool -
- Non- SKy130 Example:
``` python 
schematic2layout.py ../ALIGN-pdk-sky130/examples/five_transistor_ota -p ../pdks/SKY130_PDK/
```
Install Klayout to view generated GDS files from ALIGN - sudo apt-get install klayout


### create a lab directory to perform experiments
``` bash
$ mkdir Lab1_and
$ cd Lab1_and
$ mkdir mag
$ mkdir netgen
$ mkdir xschem
$ cd xschem
$ cp /usr/local/share/pdk/sky130A/libs.tech/xschem/xschemrc .
$ cp /usr/local/share/pdk/sky130A/libs.tech/ngspice/spinit .spiceinit
$ cd ../mag
$ cp /usr/local/share/pdk/sky130A/libs.tech/magic/sky130A.magicrc .magicrc
$ cd ../netgen
$ cp /usr/local/share/pdk/sky130A/libs.tech/netgen//sky130A_setup.tcl .
```


### Inverter pre-layout experiments


### Creating inverter schematic using xschem

![Screenshot from 2023-02-10 09-42-33](https://user-images.githubusercontent.com/50217106/218092046-625e8fe8-2af5-40c4-b838-cd323d1fce08.png)



### Convert the schematic to a symbol
![Screenshot from 2023-02-10 09-42-36](https://user-images.githubusercontent.com/50217106/218091695-e57995fd-f585-492d-96ef-d046b3b4aed6.png)



### Using the symbol, an independent testbench is created to simulate the circuit

![Screenshot from 2023-02-10 09-59-06](https://user-images.githubusercontent.com/50217106/218091959-d2df3d36-6d16-44cd-bf57-a6d660c0e5f7.png)



### Creating and Simulating testbench Schematic

![Screenshot from 2023-02-10 10-06-28](https://user-images.githubusercontent.com/50217106/218089214-f6946c50-e88c-4d48-8a03-eaa9b9768587.png)

### Calculation of Pre-layout Inverter delay using ngspice and plots
![Screenshot from 2023-02-10 10-06-10](https://user-images.githubusercontent.com/50217106/218088836-ed10f081-b9f8-402e-b847-555a27e54b63.png)

clicking on the Vin and Vout curves give coordinates on the ngspice terminal

![Screenshot from 2023-02-10 10-06-28](https://user-images.githubusercontent.com/50217106/218089214-f6946c50-e88c-4d48-8a03-eaa9b9768587.png)

the difference in corrdinates give the pre-layout inverer delay values
delay = 1.3ps

Multiple iterations of simulations is performed and an average delay value is finalised.

## Creation of Layout using inverter schematic in layout tool MAGIC
Create a working directory with sky130A.tech, .xschemrc and .sky130magicrc files or you can import these files to the MAGIC directory itself. Either way open the working directory and use the following command
```
'MAGIC -T sky130A.tech
```
This opens up the tkcon and layout windows
- the layout and tkcon windows

In the Layout window import the spice netlist of your inverter(one which has pins and fets, and is the bottomost hierarchy of the inverter testbench)

- the option of importing netlist

The metal input and output pins are imported and the nfet and pfet is imported

- the pics


now we hover over the pins/fets and press i and then press m at the location we want to place them

- pics of correct placement


route metal

- pics of routed layout


drc free

- pics of drc free

extract layout

- commands and files
