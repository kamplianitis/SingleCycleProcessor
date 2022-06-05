--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:12:48 04/27/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/DATAPATHTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DATAPATH
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
 
ENTITY DATAPATHTEST IS
END DATAPATHTEST;
 
ARCHITECTURE behavior OF DATAPATHTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DATAPATH
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Instr : IN  std_logic_vector(31 downto 0);
         ImmExt : IN  std_logic_vector(1 downto 0);
         RF_WrEn : IN  std_logic;
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_func : IN  std_logic_vector(3 downto 0);
         ByteOp : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         MM_RdData : IN  std_logic_vector(31 downto 0);
         Pc_Instr : OUT  std_logic_vector(31 downto 0);
         MM_Addr : OUT  std_logic_vector(31 downto 0);
         ALU_zero : OUT  std_logic;
         MM_WrData : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal ImmExt : std_logic_vector(1 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_func : std_logic_vector(3 downto 0) := (others => '0');
   signal ByteOp : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal MM_RdData : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Pc_Instr : std_logic_vector(31 downto 0);
   signal MM_Addr : std_logic_vector(31 downto 0);
   signal ALU_zero : std_logic;
   signal MM_WrData : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DATAPATH PORT MAP (
          Clk => Clk,
          Reset => Reset,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Instr => Instr,
          ImmExt => ImmExt,
          RF_WrEn => RF_WrEn,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_func => ALU_func,
          ByteOp => ByteOp,
          Mem_WrEn => Mem_WrEn,
          MM_RdData => MM_RdData,
          Pc_Instr => Pc_Instr,
          MM_Addr => MM_Addr,
          ALU_zero => ALU_zero,
          MM_WrData => MM_WrData
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
      		Reset <= '1';
      wait for Clk_period*2;
		
		
		Reset <= '0';
      PC_sel <= '0';
      PC_LdEn <='1';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000010000100000001010110000";
      ImmExt <= "00";
      RF_WrEn <= '1';
      RF_WrData_sel <= '1';
      RF_B_sel <= '0';
      ALU_Bin_sel <= '0';
      ALU_func <= "0000";
      ByteOp <= '0';
      Mem_WrEn <='0';
      MM_RdData <= "10000000001000100000001010110000";
      wait for Clk_period;
		
		
		
		Reset <= '0';
      PC_sel <= '0';
      PC_LdEn <='1';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110000";
      ImmExt <= "00";
      RF_WrEn <= '1';
      RF_WrData_sel <= '0';
      RF_B_sel <= '0';
      ALU_Bin_sel <= '0';
      ALU_func <= "0000";
      ByteOp <= '0';
      Mem_WrEn <='0';
      MM_RdData <= "10000000001000100000001010110000";
      wait for Clk_period;


		Reset <= '0';
      PC_sel <= '0';
      PC_LdEn <='1';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110000";
      ImmExt <= "00";
      RF_WrEn <= '0';
      RF_WrData_sel <= '1'; -- writes from memory
      RF_B_sel <= '1'; -- rd
      ALU_Bin_sel <= '0'; 
      ALU_func <= "0000"; -- addition
      ByteOp <= '0'; 
      Mem_WrEn <='0';
      MM_RdData <= "10000000001000100000001010110000";
      wait for Clk_period;
      -- insert stimulus here  
		
		Reset <= '0';
      PC_sel <= '0';
      PC_LdEn <='1';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "10000000001000100000001010110000";
      ImmExt <= "00";
      RF_WrEn <= '0';
      RF_WrData_sel <= '1'; -- writes from memory
      RF_B_sel <= '1'; -- rd
      ALU_Bin_sel <= '0'; 
      ALU_func <= "0000"; -- addition
      ByteOp <= '0'; 
      Mem_WrEn <='0';
      MM_RdData <= "10000000001000100000001010110000";
      wait for Clk_period;
		
		Reset <= '0';
      PC_sel <= '1'; --plus immed
      PC_LdEn <='1';
      --Instr <= "100000 00001 00010 00000 01010 110000";
		Instr <= "00000000001000100000001010110000";
      ImmExt <= "00";
      RF_WrEn <= '0';
      RF_WrData_sel <= '1'; -- writes from memory
      RF_B_sel <= '1'; -- rd
      ALU_Bin_sel <= '0'; 
      ALU_func <= "0000"; -- addition
      ByteOp <= '0'; 
      Mem_WrEn <='0';
      MM_RdData <= "10000000001000100000001010110000";
      wait for Clk_period;
		
		
      wait;
   end process;

END;
