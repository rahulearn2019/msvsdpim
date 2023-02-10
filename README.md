# msvsdpim
## week0
### Getting the tools
Note: open_pdk has to be installed last so it can correctly associate the xschem and magic directories. Note: if the configure step fails during any process, its most likely due to missing additional packages, and they need to be installed (preferably from source) to complete the installation
![image](https://user-images.githubusercontent.com/50217106/218158061-a319ea61-f115-48f8-8694-172a138004ba.png)


## Magic 
- Install steps
```
$  git clone git://opencircuitdesign.com/magic
$  cd magic
$	 ./configure
$  make
$  sudo make install
```
More info can be found at http://opencircuitdesign.com/magic/index.html
## Ngspice 
ngspice is the open-source spice simulator for electric and electronic circuits.
- Install steps
After downloading the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory, unpack it using:
```
 $ tar -zxvf ngspice-37.tar.gz
 $ cd ngspice-37
 $ mkdir release
 $ cd release
 $ ../configure  --with-x --with-readline=yes --disable-debug
 $ make
 $ sudo make install
 ```
## xschem
Xschem is a schematic capture program
- Install steps
```
$  git clone https://github.com/StefanSchippers/xschem.git xschem_git
$	./configure
$  make
$  sudo make install
```
More info can be found at http://repo.hu/projects/xschem/index.html

## open_pdks
Open_PDKs is distributed with files that support the Google/SkyWater sky130 open process description https://github.com/google/skywater-pdk. Open_PDKs will set up an environment for using the SkyWater sky130 process with open-source EDA tools and tool flows such as magic, qflow, openlane, netgen, klayout, etc.
- Install steps
```
$  git clone git://opencircuitdesign.com/open_pdks
$  open_pdks
$	./configure --enable-sky130-pdk
$  make
$  sudo make install
```
## Align - 
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

### Inverter DC analysis
![Screenshot from 2023-02-09 14-25-28](https://user-images.githubusercontent.com/50217106/218139861-b6a31207-693a-44c2-92c8-487d8d567a62.png)
![Screenshot from 2023-02-09 14-25-22](https://user-images.githubusercontent.com/50217106/218139881-58da4097-beca-4045-a07e-d97ca350870f.png)



![Screenshot from 2023-02-09 14-25-11](https://user-images.githubusercontent.com/50217106/218139230-5c07698e-fdc8-4ec4-9fe6-370c84e85f2b.png)


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


In the Layout window import the spice netlist of your inverter(one which has pins and fets, and is the bottomost hierarchy of the inverter testbench)
The metal input and output pins are imported and the nfet and pfet is imported
![Screenshot from 2023-02-10 18-53-02](https://user-images.githubusercontent.com/50217106/218151916-737d2d97-53e8-4296-b2db-5f9b57072e7d.png)

Now we hover over the pins/fets and press i and then press m at the location we want to place them

Now route the metal1 layer such that the layout is DRC free
![Screenshot from 2023-02-10 21-34-39](https://user-images.githubusercontent.com/50217106/218149482-81fb02bd-7be3-4285-8536-787aa9b295f9.png)
Now, go to File --> save and select autowrite. We're not done yet. Go to the command window and type the following:
```
extract do local
extract all
```
Extract do local is an instruction to perform all extractions to the local directory and extract all does the actual extraction. We want our extraction for lvs to be in the spice format, so run the following commands.
```
ext2spice lvs
ext2spice
```
Now, we can close magic.

If we run an ls in this directory we should see our .ext files and .mag files for the 
circuit - inverter.mag inverter.ext
We can also see a .spice netlist. This inverter.spice netlist generated post layout contains the parasitics that were absent in pre-layout netlist.
![Screenshot from 2023-02-10 21-50-00](https://user-images.githubusercontent.com/50217106/218151584-66d05733-377c-4f2b-8a13-4b265daf8527.png)

Now we need to use our pre-layout spice witht he post-layout parasitics netlist and perform spice simulations.



* Beta Version released on 2/22/06

* PTM 130nm NMOS 
 
.model  nmos  nmos  level = 54

+version = 4.0          binunit = 1            paramchk= 1            mobmod  = 0          
+capmod  = 2            igcmod  = 1            igbmod  = 1            geomod  = 1          
+diomod  = 1            rdsmod  = 0            rbodymod= 1            rgatemod= 1          
+permod  = 1            acnqsmod= 0            trnqsmod= 0          

+tnom    = 27           toxe    = 2.25e-9      toxp    = 1.6e-9       toxm    = 2.25e-9   
+dtox    = 0.65e-9      epsrox  = 3.9          wint    = 5e-009       lint    = 10.5e-009   
+ll      = 0            wl      = 0            lln     = 1            wln     = 1          
+lw      = 0            ww      = 0            lwn     = 1            wwn     = 1          
+lwl     = 0            wwl     = 0            xpart   = 0            toxref  = 2.25e-9   
+xl      = -60e-9
+vth0    = 0.3782       k1      = 0.4          k2      = 0.01         k3      = 0          
+k3b     = 0            w0      = 2.5e-006     dvt0    = 1            dvt1    = 2       
+dvt2    = -0.032       dvt0w   = 0            dvt1w   = 0            dvt2w   = 0          
+dsub    = 0.1          minv    = 0.05         voffl   = 0            dvtp0   = 1.2e-010     
+dvtp1   = 0.1          lpe0    = 0            lpeb    = 0            xj      = 3.92e-008   
+ngate   = 2e+020       ndep    = 1.54e+018    nsd     = 2e+020       phin    = 0          
+cdsc    = 0.0002       cdscb   = 0            cdscd   = 0            cit     = 0          
+voff    = -0.13        nfactor = 1.5          eta0    = 0.0092       etab    = 0          
+vfb     = -0.55        u0      = 0.05928      ua      = 6e-010       ub      = 1.2e-018     
+uc      = 0            vsat    = 100370       a0      = 1            ags     = 1e-020     
+a1      = 0            a2      = 1            b0      = 0            b1      = 0          
+keta    = 0.04         dwg     = 0            dwb     = 0            pclm    = 0.06       
+pdiblc1 = 0.001        pdiblc2 = 0.001        pdiblcb = -0.005       drout   = 0.5        
+pvag    = 1e-020       delta   = 0.01         pscbe1  = 8.14e+008    pscbe2  = 1e-007     
+fprout  = 0.2          pdits   = 0.08         pditsd  = 0.23         pditsl  = 2.3e+006   
+rsh     = 5            rdsw    = 200          rsw     = 100          rdw     = 100        
+rdswmin = 0            rdwmin  = 0            rswmin  = 0            prwg    = 0          
+prwb    = 6.8e-011     wr      = 1            alpha0  = 0.074        alpha1  = 0.005      
+beta0   = 30           agidl   = 0.0002       bgidl   = 2.1e+009     cgidl   = 0.0002     
+egidl   = 0.8          

+aigbacc = 0.012        bigbacc = 0.0028       cigbacc = 0.002     
+nigbacc = 1            aigbinv = 0.014        bigbinv = 0.004        cigbinv = 0.004      
+eigbinv = 1.1          nigbinv = 3            aigc    = 0.012        bigc    = 0.0028     
+cigc    = 0.002        aigsd   = 0.012        bigsd   = 0.0028       cigsd   = 0.002     
+nigc    = 1            poxedge = 1            pigcd   = 1            ntox    = 1          

+xrcrg1  = 12           xrcrg2  = 5          
+cgso    = 2.4e-010     cgdo    = 2.4e-010     cgbo    = 2.56e-011    cgdl    = 2.653e-10     
+cgsl    = 2.653e-10    ckappas = 0.03         ckappad = 0.03         acde    = 1          
+moin    = 15           noff    = 0.9          voffcv  = 0.02       

+kt1     = -0.11        kt1l    = 0            kt2     = 0.022        ute     = -1.5       
+ua1     = 4.31e-009    ub1     = 7.61e-018    uc1     = -5.6e-011    prt     = 0          
+at      = 33000      

+fnoimod = 1            tnoimod = 0          

+jss     = 0.0001       jsws    = 1e-011       jswgs   = 1e-010       njs     = 1          
+ijthsfwd= 0.01         ijthsrev= 0.001        bvs     = 10           xjbvs   = 1          
+jsd     = 0.0001       jswd    = 1e-011       jswgd   = 1e-010       njd     = 1          
+ijthdfwd= 0.01         ijthdrev= 0.001        bvd     = 10           xjbvd   = 1          
+pbs     = 1            cjs     = 0.0005       mjs     = 0.5          pbsws   = 1          
+cjsws   = 5e-010       mjsws   = 0.33         pbswgs  = 1            cjswgs  = 3e-010     
+mjswgs  = 0.33         pbd     = 1            cjd     = 0.0005       mjd     = 0.5        
+pbswd   = 1            cjswd   = 5e-010       mjswd   = 0.33         pbswgd  = 1          
+cjswgd  = 5e-010       mjswgd  = 0.33         tpb     = 0.005        tcj     = 0.001      
+tpbsw   = 0.005        tcjsw   = 0.001        tpbswg  = 0.005        tcjswg  = 0.001      
+xtis    = 3            xtid    = 3          

+dmcg    = 0e-006       dmci    = 0e-006       dmdg    = 0e-006       dmcgt   = 0e-007     
+dwj     = 0.0e-008     xgw     = 0e-007       xgl     = 0e-008     

+rshg    = 0.4          gbmin   = 1e-010       rbpb    = 5            rbpd    = 15         
+rbps    = 15           rbdb    = 15           rbsb    = 15           ngcon   = 1          

* PTM 130nm PMOS
 
.model  pmos  pmos  level = 54

+version = 4.0          binunit = 1            paramchk= 1            mobmod  = 0          
+capmod  = 2            igcmod  = 1            igbmod  = 1            geomod  = 1          
+diomod  = 1            rdsmod  = 0            rbodymod= 1            rgatemod= 1          
+permod  = 1            acnqsmod= 0            trnqsmod= 0          

+tnom    = 27           toxe    = 2.35e-009    toxp    = 1.6e-009     toxm    = 2.35e-009   
+dtox    = 0.75e-9      epsrox  = 3.9          wint    = 5e-009       lint    = 10.5e-009   
+ll      = 0            wl      = 0            lln     = 1            wln     = 1          
+lw      = 0            ww      = 0            lwn     = 1            wwn     = 1          
+lwl     = 0            wwl     = 0            xpart   = 0            toxref  = 2.35e-009   
+xl      = -60e-9
+vth0    = -0.321       k1      = 0.4          k2      = -0.01        k3      = 0          
+k3b     = 0            w0      = 2.5e-006     dvt0    = 1            dvt1    = 2       
+dvt2    = -0.032       dvt0w   = 0            dvt1w   = 0            dvt2w   = 0          
+dsub    = 0.1          minv    = 0.05         voffl   = 0            dvtp0   = 1e-009     
+dvtp1   = 0.05         lpe0    = 0            lpeb    = 0            xj      = 3.92e-008   
+ngate   = 2e+020       ndep    = 1.14e+018    nsd     = 2e+020       phin    = 0          
+cdsc    = 0.000258     cdscb   = 0            cdscd   = 6.1e-008     cit     = 0          
+voff    = -0.126       nfactor = 1.5          eta0    = 0.0092       etab    = 0          
+vfb     = 0.55         u0      = 0.00835      ua      = 2.0e-009     ub      = 0.5e-018     
+uc      = -3e-011      vsat    = 70000        a0      = 1.0          ags     = 1e-020     
+a1      = 0            a2      = 1            b0      = -1e-020      b1      = 0          
+keta    = -0.047       dwg     = 0            dwb     = 0            pclm    = 0.12       
+pdiblc1 = 0.001        pdiblc2 = 0.001        pdiblcb = 3.4e-008     drout   = 0.56       
+pvag    = 1e-020       delta   = 0.01         pscbe1  = 8.14e+008    pscbe2  = 9.58e-007  
+fprout  = 0.2          pdits   = 0.08         pditsd  = 0.23         pditsl  = 2.3e+006   
+rsh     = 5            rdsw    = 240          rsw     = 120          rdw     = 120        
+rdswmin = 0            rdwmin  = 0            rswmin  = 0            prwg    = 3.22e-008  
+prwb    = 6.8e-011     wr      = 1            alpha0  = 0.074        alpha1  = 0.005      
+beta0   = 30           agidl   = 0.0002       bgidl   = 2.1e+009     cgidl   = 0.0002     
+egidl   = 0.8          

+aigbacc = 0.012        bigbacc = 0.0028       cigbacc = 0.002     
+nigbacc = 1            aigbinv = 0.014        bigbinv = 0.004        cigbinv = 0.004      
+eigbinv = 1.1          nigbinv = 3            aigc    = 0.69         bigc    = 0.0012     
+cigc    = 0.0008       aigsd   = 0.0087       bigsd   = 0.0012       cigsd   = 0.0008     
+nigc    = 1            poxedge = 1            pigcd   = 1            ntox    = 1 
         
+xrcrg1  = 12           xrcrg2  = 5          
+cgso    = 2.4e-010     cgdo    = 2.4e-010     cgbo    = 2.56e-011    cgdl    = 2.653e-10
+cgsl    = 2.653e-10    ckappas = 0.03         ckappad = 0.03         acde    = 1
+moin    = 15           noff    = 0.9          voffcv  = 0.02

+kt1     = -0.11        kt1l    = 0            kt2     = 0.022        ute     = -1.5       
+ua1     = 4.31e-009    ub1     = 7.61e-018    uc1     = -5.6e-011    prt     = 0          
+at      = 33000      

+fnoimod = 1            tnoimod = 0          

+jss     = 0.0001       jsws    = 1e-011       jswgs   = 1e-010       njs     = 1          
+ijthsfwd= 0.01         ijthsrev= 0.001        bvs     = 10           xjbvs   = 1          
+jsd     = 0.0001       jswd    = 1e-011       jswgd   = 1e-010       njd     = 1          
+ijthdfwd= 0.01         ijthdrev= 0.001        bvd     = 10           xjbvd   = 1          
+pbs     = 1            cjs     = 0.0005       mjs     = 0.5          pbsws   = 1          
+cjsws   = 5e-010       mjsws   = 0.33         pbswgs  = 1            cjswgs  = 3e-010     
+mjswgs  = 0.33         pbd     = 1            cjd     = 0.0005       mjd     = 0.5        
+pbswd   = 1            cjswd   = 5e-010       mjswd   = 0.33         pbswgd  = 1          
+cjswgd  = 5e-010       mjswgd  = 0.33         tpb     = 0.005        tcj     = 0.001      
+tpbsw   = 0.005        tcjsw   = 0.001        tpbswg  = 0.005        tcjswg  = 0.001      
+xtis    = 3            xtid    = 3          

+dmcg    = 0e-006       dmci    = 0e-006       dmdg    = 0e-006       dmcgt   = 0e-007     
+dwj     = 0.0e-008     xgw     = 0e-007       xgl     = 0e-008     

+rshg    = 0.4          gbmin   = 1e-010       rbpb    = 5            rbpd    = 15         
+rbps    = 15           rbdb    = 15           rbsb    = 15           ngcon   = 1  
