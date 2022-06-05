--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:17:23 04/21/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/RAMTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RAM
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
 
ENTITY RAMTEST IS
END RAMTEST;
 
ARCHITECTURE behavior OF RAMTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         clk : IN  std_logic;
         inst_addr : IN  std_logic_vector(10 downto 0);
         inst_dout : OUT  std_logic_vector(31 downto 0);
         data_we : IN  std_logic;
         data_addr : IN  std_logic_vector(10 downto 0);
         data_din : IN  std_logic_vector(31 downto 0);
         data_dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal inst_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_we : std_logic := '0';
   signal data_addr : std_logic_vector(10 downto 0) := (others => '0');
   signal data_din : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal inst_dout : std_logic_vector(31 downto 0);
   signal data_dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          clk => clk,
          inst_addr => inst_addr,
          inst_dout => inst_dout,
          data_we => data_we,
          data_addr => data_addr,
          data_din => data_din,
          data_dout => data_dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		-- check some instruction address to see that we are ok.
		inst_addr <= "00000000000";
      wait for clk_period*2;
		
		inst_addr <= "00000000001";
      wait for clk_period*2;
		
		inst_addr <= "00000000010";
      wait for clk_period*2;
		
		inst_addr <= "00000000011";
      wait for clk_period*2;
		
		inst_addr <= "00000000100";
      wait for clk_period*2;
		
		inst_addr <= "00000000101";
      wait for clk_period*2;
		
		-- now we check on the data address for the same reason.
		
		data_addr <= "00000010000";
		wait for clk_period*2;
		
		data_addr <= "00000110000";
		wait for clk_period*2;
		
		data_addr <= "00000010010";
		wait for clk_period*2;
		
      wait;
   end process;

END;
