--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:34:14 04/21/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/LITTLECLOUDTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Littlecloud
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LITTLECLOUDTEST IS
END LITTLECLOUDTEST;
 
ARCHITECTURE behavior OF LITTLECLOUDTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Littlecloud
    PORT(
         Din : IN  std_logic_vector(15 downto 0);
         Immed : OUT  std_logic_vector(31 downto 0);
         OpCode : IN  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Din : std_logic_vector(15 downto 0) := (others => '0');
   signal OpCode : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Littlecloud PORT MAP (
          Din => Din,
          Immed => Immed,
          OpCode => OpCode
        );

 
   -- Stimulus process
   stim_proc: process
   begin		
			        -- zero fill
        Din <= "1100000100000111";
        Opcode <="00";
        wait for 100 ns;

        --shift left and zero fill
        Din <= "1100000100000111";
        Opcode <="01";
        wait for 100 ns;

        --sign extend with sign bit 0
        Din <= "0100000100000111";
        Opcode <="10";
        wait for 100 ns;

        --sign extend with sign bit 1
        Din <= "1100000100000111";
        Opcode <="10";
        wait for 100 ns;

        -- shift left 2 bit and sign extend with sign bit 0
        Din <= "0100000100000111";
        Opcode <="11";
        wait for 100 ns;

        -- shift left 2 bit and sign extend with sign bit 1
        Din <= "1100000100000111";
        Opcode <="11";
        wait for 100 ns;
      wait;
   end process;

END;
