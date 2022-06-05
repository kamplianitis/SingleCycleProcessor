--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:58:31 04/27/2020
-- Design Name:   
-- Module Name:   D:/ggwp/ggwp/ifstagetest.vhd
-- Project Name:  ggwp
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: If_stage
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
 
ENTITY ifstagetest IS
END ifstagetest;
 
ARCHITECTURE behavior OF ifstagetest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT If_stage
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Pc : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Pc : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: If_stage PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          Pc => Pc
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
     --check the reset state again.
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '0';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '0'; -- write on the pc or not
         Reset <= '1'; -- reset state
      wait for Clk_period*2;
		
			--check the reset state with lden on and pcsel on .
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '1';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '1'; -- write on the pc or not
         Reset <= '1'; -- reset state
      wait for Clk_period*2;
		
			--check the reset state with lden on pcsel of.
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '0';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '1'; -- write on the pc or not
         Reset <= '1'; -- reset state
      wait for Clk_period*2;
		
		
			--check the lden off again.
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '0';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '0'; -- write on the pc or not
         Reset <= '0'; -- reset state
      wait for Clk_period*2;
		
			-- we write on the pc for the first time  
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '0';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '1'; -- write on the pc or not
         Reset <= '0'; -- reset state
      wait for Clk_period*6; -- it supposed to go + 4 each time so we check it on a fair amount of cycles
		
		-- last we check that the pc goes to the +4 + Immed which is used in a jump  
			PC_Immed <= "11000000110000101011110000110110";
         PC_sel <= '1';  -- PC+4 or(PC+4) + SignExt(Immed) 
         PC_LdEn <= '1'; -- write on the pc or not
         Reset <= '0'; -- reset state
      wait for Clk_period; -- it supposed to go + 4 each time so we check it on a fair amount of cycles
		
		

      wait;
   end process;

END;
