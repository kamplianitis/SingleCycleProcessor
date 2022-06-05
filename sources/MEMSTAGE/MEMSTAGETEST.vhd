--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:14:07 04/26/2020
-- Design Name:   
-- Module Name:   D:/ggwp/testingforeverything/MEMSTAGETEST.vhd
-- Project Name:  testingforeverything
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MEMSTAGE
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
 
ENTITY MEMSTAGETEST IS
END MEMSTAGETEST;
 
ARCHITECTURE behavior OF MEMSTAGETEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         Clk : IN  std_logic;
         ByteOp : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal ByteOp : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');
   signal data_we : std_logic := '0';

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          Clk => Clk,
          ByteOp => ByteOp,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          data_we => data_we,
          MEM_DataOut => MEM_DataOut
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
			ByteOp <= '0'; -- take the whole word but do not write in the memory (we can see it by seeing if the data in comes to the dataout) 
			ALU_MEM_Addr <= "00000000000000000000000000000000";
			MEM_DataIn <= "11001100000000111010101111001101";
			data_we <='0';
      wait for Clk_period* 5;


			ByteOp <= '0'; -- take the whole word and write in the memory
			ALU_MEM_Addr <= "00000000000000000000000000000000";
			MEM_DataIn <= "11001100000000111010101111001101";
			data_we <='1';
      wait for Clk_period*5;
			
			ByteOp <= '1'; -- take the byte but we dont write in the memory 
			ALU_MEM_Addr <= "00000000000000000000000000000000";
			MEM_DataIn <= "11001100000000111010101111001101";
			data_we <='0';
      wait for Clk_period* 5;


			ByteOp <= '1'; -- take the byte and we write in the memory 
			ALU_MEM_Addr <= "00000000000000000000000000000000";
			MEM_DataIn <= "11001100000000111010101111001101";
			data_we <='1';
      wait for Clk_period* 5;


      -- insert stimulus here 

      wait;
   end process;

END;
