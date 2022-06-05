--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:32:33 04/20/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/DECODERTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
 
ENTITY DECODERTEST IS
END DECODERTEST;
 
ARCHITECTURE behavior OF DECODERTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         registerdestination : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal registerdestination : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          Awr => Awr,
          registerdestination => registerdestination
        );


   -- Stimulus process
   stim_proc: process
   begin		
    

		Awr  <= "00101";
      wait for 100 ns;	
		
		Awr  <= "00001";
		wait for 100 ns;
		
		Awr  <= "11101";
		wait for 100 ns;
		
		Awr  <= "00000";
		wait for 100 ns;
      wait;
   end process;

END;
