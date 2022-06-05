--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:01:48 04/20/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/RFTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY RFTEST IS
END RFTEST;
 
ARCHITECTURE behavior OF RFTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RF
    PORT(
         Adr1 : IN  std_logic_vector(4 downto 0);
         Adr2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Adr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Adr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RF PORT MAP (
          Adr1 => Adr1,
          Adr2 => Adr2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk,
          Rst => Rst
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
		-- resest state. Does not matter what are the values of the inputs we have to get 0s on the outputs.
      Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "00101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '0';
		Rst <= '1';
      wait for Clk_period*2;
		
		
		-- should still do nothing cause the reset is still enabled.
		Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "00101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '1';
		Rst <= '1';
      wait for Clk_period*2;
	
		-- check the R0 cannot be read.
		Adr1 <= "00000";
		Awr  <= "00000";
		Din  <= "11111111110001010101100000000111";
		WrEn <= '1';
      wait for Clk_period*2;
		
		--now it should write to the register(1)
		Adr1 <= "00001";
		Adr2 <= "00001";
		Awr  <= "00001";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '1';
		Rst <= '0';
      wait for Clk_period*2;
		
		Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "10101";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '1';
		Rst <= '0';
      wait for Clk_period*2;
		
		Adr1 <= "01000";
		Adr2 <= "00010";
		Awr  <= "00111";
		Din  <= "00000011110001010101100000000000";
		WrEn <= '1';
		Rst <= '0';
      wait for Clk_period*2;
		
		wait;
   end process;

END;
