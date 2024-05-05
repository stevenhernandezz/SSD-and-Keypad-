# SSD-and-Keypad-
 This project implements a seven-segment control, keypad controller, using the Zybo-Z7 development board to gain experience using FPGA development tools. 
 
## Description
For this project I made a module for a debounce as well as a module for the pulse width modulation (PWM). The debounce will help with inputs of the keypad when pressing one at a time while the PWM will help with frequency and duty cycle parameters. Once the PWM and debounce modules were made I constructed a display module for the seven-segment which will go through each state of the seven-segment to display the right number and letter. 

I also constructed a module for the decoder for the keypad and a top file which instantiates all the modules and first displays one digit or letter for the first part. For the second part, I used the top file to display two digits simultaneously on the SSD.

## Demo Video
https://www.youtube.com/watch?v=Ct8HYRn14Ho

## Dependencies
## Hardware
* https://digilent.com/reference/programmable-logic/zybo-z7/start
* https://digilent.com/reference/pmod/pmodssd/reference-manual

### Software
* https://www.xilinx.com/products/design-tools/vivado.html

### Author
* Steven Hernandez
  - www.linkedin.com/in/steven-hernandez-a55a11300
  - https://github.com/stevenhernandezz
