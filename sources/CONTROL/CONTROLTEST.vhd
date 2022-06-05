--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:16:00 04/23/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/CONTROLTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Control
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
 
ENTITY CONTROLTEST IS
END CONTROLTEST;
 
ARCHITECTURE behavior OF CONTROLTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Control
    PORT(
         Rst : IN  std_logic;
         Clk : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         ALU_zero : IN  std_logic;
         PC_sel : OUT  std_logic;
         PC_LdEn : OUT  std_logic;
         ImmExt : OUT  std_logic_vector(1 downto 0);
         RF_WrEn : OUT  std_logic;
         RF_WrData_sel : OUT  std_logic;
         RF_B_sel : OUT  std_logic;
         ALU_Bin_sel : OUT  std_logic;
         ALU_func : OUT  std_logic_vector(3 downto 0);
         ByteOp : OUT  std_logic;
         Mem_WrEn : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Rst : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ALU_zero : std_logic := '0';

 	--Outputs
   signal PC_sel : std_logic;
   signal PC_LdEn : std_logic;
   signal ImmExt : std_logic_vector(1 downto 0);
   signal RF_WrEn : std_logic;
   signal RF_WrData_sel : std_logic;
   signal RF_B_sel : std_logic;
   signal ALU_Bin_sel : std_logic;
   signal ALU_func : std_logic_vector(3 downto 0);
   signal ByteOp : std_logic;
   signal Mem_WrEn : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Control PORT MAP (
          Rst => Rst,
          Clk => Clk,
          Instr => Instr,
          ALU_zero => ALU_zero,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          ImmExt => ImmExt,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn
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
		Rst <= '1';
      wait for Clk_period*2;
		
		--ALU
		Rst <= '0';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110000";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		--ALU
		Rst <= '0';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		
		-- li
		--Instr <= "111001 00001 00010 00000 01010 110000";
		Instr <= "11100000001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		
		--lui
		--Instr <= "111001 00001 00010 00000 01010 110000";
		Instr <= "11100100001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		--addi, nandi, ori are basically the same
		--Instr <= "111001 00001 00010 00000 01010 110000";
		Instr <= "11000000001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		-- beq when the regs are not equal (bne is the opposite result but the same procedure, b same procedure without the ifs so no need for check)
		Instr <= "00000000001000100000001010110001";
      ALU_zero <= '0';
      wait for Clk_period*2;
		
		-- beq when the regs are equal
		Instr <= "00000000001000100000001010110001";
      ALU_zero <= '1';
      wait for Clk_period*2;
		
		-- load word (check the ByteOp)
		Instr <= "00111100001000100000001010110001";
      ALU_zero <= '1';
      wait for Clk_period*2;
		
		
		-- store byte (check the ByteOp)
		Instr <= "00011100001000100000001010110001";
      ALU_zero <= '1';
      wait for Clk_period*2;
		
		
		
      wait;
   end process;

END;
