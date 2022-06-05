--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:23:38 04/26/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/DECSTAGETEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGETEST IS
END DECSTAGETEST;
 
ARCHITECTURE behavior OF DECSTAGETEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ImmExt : IN  std_logic_vector(1 downto 0);
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ImmExt => ImmExt,
          Clk => Clk,
          Rst => Rst,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		-- there is no need to check the immedext cause there is a testbench for that in the folder with the testbenches
	
		--check the reset stage
		Instr <= "10000000010000100000001010110000";
      RF_WrEn <='1';
      ALU_out <= "10000000010000100000001010110000";
      MEM_out <= "00000000000000100000001010110000";
      RF_WrData_sel <='0';
      RF_B_sel <= '0';
      ImmExt <= "00";
      Rst <='1';
      wait for Clk_period*2;
		
		-- this should not write in the register
		Instr <= "10000000010000100000001010110000";
      RF_WrEn <='0';
      ALU_out <= "10000000010000100000001010110000";
      MEM_out <= "00000000000000100000001010110000";
      RF_WrData_sel <='0';
      RF_B_sel <= '0'; -- rt 
      ImmExt <= "00"; -- zerofill the immediate we take
      Rst <='0';
      wait for Clk_period*2;

		-- this should not write in the register from the memory and get it out
		Instr <= "10000000010000100000001010110000";
      RF_WrEn <='1';
      ALU_out <= "10000000010000100000001010110000";
      MEM_out <= "00000000000000100000001010110000";
      RF_WrData_sel <='1';
      RF_B_sel <= '1'; -- rd
      ImmExt <= "00"; -- zerofill the immediate we take
      Rst <='0';
      wait for Clk_period*2;
		
		-- should write from the alu
		Instr <= "10000000010000100000001010110000";
      RF_WrEn <='1';
      ALU_out <= "10000000010000100000001010110000";
      MEM_out <= "00000000000000100000001010110000";
      RF_WrData_sel <='0';
      RF_B_sel <= '1'; -- rd
      ImmExt <= "00"; -- zerofill the immediate we take
      Rst <='0';
      wait for Clk_period*2;
		
		
		
      wait;
   end process;

END;
