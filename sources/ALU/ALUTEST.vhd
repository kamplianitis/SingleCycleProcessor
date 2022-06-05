--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:12:36 04/20/2020
-- Design Name:   
-- Module Name:   D:/zeta/hopeitsfinal/ALUTEST.vhd
-- Project Name:  hopeitsfinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALUTEST IS
END ALUTEST;
 
ARCHITECTURE behavior OF ALUTEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         ZeroOut : OUT  std_logic;
         Outp : OUT  std_logic_vector(31 downto 0);
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal ZeroOut : std_logic;
   signal Outp : std_logic_vector(31 downto 0);
   signal Cout : std_logic;
   signal Ovf : std_logic;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          ZeroOut => ZeroOut,
          Outp => Outp,
          Cout => Cout,
          Ovf => Ovf
        );
		  
   -- Stimulus process
   stim_proc: process
   begin		
     -- normal case.
		A  <= "01111111111111111111111111111111";
		B  <=	"00000000000000000000000000000001";
		Op<= "0000";
      wait for 100 ns;
		-- check overflow with the msbs to 1.
		A  <= "10111111111111111111111111111111";
		B  <=	"10111111111111111111111111111111";
		Op <= "0000";
		wait for 100 ns;
		A  <= "11111111111111111111111111111110";
		B  <=	"11111111111111111111111111111111";
		Op <= "0000";
      wait for 100 ns;
		--testing substract.
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0001";
      wait for 100 ns;
		-- testing the zero signal.
		A  <= "00000000000000110000000000000000";
		B  <=	"00000000000000110000000000000000";
		Op <= "0001";
		wait for 100 ns;
		-- now we're testing the gates.
		-- we start with the and gate.
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0010";
		wait for 100 ns;
		-- now the or gate
		-- from now on there is not real point to change the A,B numbers.
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0011";
		wait for 100 ns;
		-- not gate. We have the B input as well so that we will see that it doesn't matter.
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0100";
		wait for 100 ns;
		-- nand gate
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0101";
		wait for 100 ns;
		--nor gate
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "0110";
		wait for 100 ns;		
		-- now all we have to check is the shifts.
		
		-- first the shift right arithmetic. we keep the same A. no need to use B.
		A  <= "11000010000000010000000000000000";
		Op <= "1000";
		wait for 100 ns;		
		
		-- now the shift right logical. Same procedure
		A  <= "11000010000000010000000000000000";
		Op <= "1001";
		wait for 100 ns;	
		
		-- same procedure for all of the next operations.
		
		-- shift left logical.
		A  <= "11000010000000010000000000000000";
		Op <= "1010";
		wait for 100 ns;	
		
		--left rotation.
		A  <= "11000010000000010000000000000000";
		Op <= "1100";
		wait for 100 ns;	
		
		-- right rotation.
		A  <= "11000010000000010000000000000000";
		Op <= "1101";
		wait for 100 ns;	
		-- in the end we test that if for some reason we find ourselves in a situation that we should not be, that we get a result that indicates we are wrong.
		A  <= "11000010000000010000000000000000";
		B  <=	"00000010000000010000000000000000";
		Op <= "1111";
		wait;
   end process;

END;
