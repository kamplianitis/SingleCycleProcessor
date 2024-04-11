# SingleCycleProcessor

## Overview
Single cycle processor Design for the purposes of the course Computer Structure at **T**echnical **U**niversity of **C**rete (**TUC**). 

The architecture of the core is strictly defined by the project's specification (an **I**nstruction **S**et **A**rchitecture named CHARIS). 

The implementation was made in VHDL. The tool used to implement the project was Xilinx ISE (v. 14.3).


## Project Structure
The repository consists of the following 3 folders:
  - `report`
  - `sources`
  - `waveform`

The `report` folder contains a pdf file describing the process followed to design each module, the schematics of the CPU from every layer and the results in forms of waveforms. **

The `sources` folder contais the .vhd files in order for the processor to be assembled. The folder is categorized in 
sections besed on the designed module. Each folder contains both the design files and their testing. A TESTING folder is
also contained in order to provide an overall test of the whole system combined. 

The `waveform` folder contains .wcfg files, snapshots of the waveforms that each unit testing file provides.

## CPU Specification

The designed CPU consists of the following parts:

  - the **ALU** block.
  - the **REGISTER FILE (RF)**
  - the **Main Memory** block
  - the **Instruction Fetch (IF) stage** block
  - the **Decode (DEC) stage** block
  - the **Memory (MEM) stage** block
  - the **Control stage**

All the parts existing in the sources folder contain their respective tests. The testing, although it is not exhaustive, it contains all the cases needed to ensure the correct functionality of each block.

Analytical review and screenshots of the implementation can be found in the pdf file located in the `report` folder. It is important to mention that the pdf file is written in **_Greek_**. 