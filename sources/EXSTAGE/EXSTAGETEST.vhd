--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:38:54 04/21/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/EXSTAGETEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: EXSTAGE
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
 
ENTITY EXSTAGETEST IS
END EXSTAGETEST;
 
ARCHITECTURE behavior OF EXSTAGETEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT EXSTAGE
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RF_A : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_B : std_logic_vector(31 downto 0) := (others => '0');
   signal Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ALU_out : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;


BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: EXSTAGE PORT MAP (
          RF_A => RF_A,
          RF_B => RF_B,
          Immed => Immed,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ALU_out => ALU_out,
          ALU_zero => ALU_zero
        );

   -- Stimulus process
   stim_proc: process
   begin	
		-- case we take RF B
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "01000000000011111000000001000010";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0000"; -- add 
		wait for 100 ns;
		
		
		
		-- case we take immed
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "01000000000000111110000001000010";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0000"; -- add 
		wait for 100 ns;
		
		-- as long us we have tested the alu there is no need to test it again. The only thing we need to test is that we take the right number each time 
		
		
		-- a few cases in cases more  
		-- check the alu zero 
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "11000000000000000000000001000000";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '0';
		ALU_func <= "0001"; -- sub
		wait for 100 ns;
		
		-- check the alu zero (should not be enabled)
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "11000000000000000000000001000000";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '1';
		ALU_func <= "0001"; -- sub
		wait for 100 ns;
		
		
		-- check the case that we just want to take the registerB 
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "11000000000000000000000001000000";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '1'; -- means that we take the immediate
		ALU_func <= "1111"; -- RFb
		wait for 100 ns;
	
		RF_A  <= "11000000000000000000000001000000";
		RF_B  <= "11000000000000000000000001000000";
		Immed <= "01000000000000000000000001000010";
		ALU_Bin_Sel <= '0'; -- means that we take the immediate
		ALU_func <= "1111"; -- RFb
		wait for 100 ns;
	
      wait;
   end process;

END;
