# SingleCycleProcessor

## Overview
Single cycle processor Design for the purposes of the course Computer Organisation at Technical University of Crete (TUC). 
The architecture of the core is strictly define by the project's specification (named CHARIS). The implementation was made in Xilinx ISE (version 14.3) 
and in VHDL.

## Project Structure
The repository consists of the following folders:
  - report
  - sources
  - waveform

The **report** folder contains a pdf file describing the process followed to design each module, the schematics of the 
CPU from every layer and the results in forms of waveforms.

The **sources** folder contais the .vhd files in order for the processor to be assembled. The folder is categorized in 
sections besed on the designed module. Each folder contains both the design files and their testing. A TESTING folder is
also contained in order to provide an overall test of the whole system combined. 

The **waveform** folder contains .wcfg files, snapshots of the waveforms that each unit testing file provides.

##CPU Specification
