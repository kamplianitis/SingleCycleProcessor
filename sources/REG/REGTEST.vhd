--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:27:26 04/20/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/REGTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Reg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
 
 
-- working 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY REGTEST IS
END REGTEST;
 
ARCHITECTURE behavior OF REGTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Reg
    PORT(
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         WE : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         Dataout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';
   signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Reg PORT MAP (
          Clk => Clk,
          Rst => Rst,
          WE => WE,
          Datain => Datain,
          Dataout => Dataout
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	
		-- first we reset with write enable to zero so that we see that we get our device initiated.
		Rst <= '1'; 
		WE <= '0';
		Datain <= "11000010000000010000000000000000"; 
      wait for Clk_period*5;
		
		-- now reset with write enable to 1 so that we see that it ignores it.
		Rst <= '1'; 
		WE <= '1';
		Datain <= "11000010000000010000000000000000"; 
      wait for Clk_period*5;
		
		-- should still do nothing cause write enable now is on 0.
		Rst <= '0'; 
		WE <= '0';
		Datain <= "11000010000000010000000000000000"; 
      wait for Clk_period*5;
		
		-- it has to pass the value to dataout cause rst is on 0 and we is on 1. 
		Rst <= '0'; 
		WE <= '1';
		Datain <= "11000010000000010000000000000000"; 
      wait for Clk_period*5;
		-- check about keeping the value
		Rst <= '0'; 
		WE <= '0';
		Datain <= "11000010000000010000000000110000"; 
      wait for Clk_period*5;
		
		
		
      wait;
   end process;

END;
