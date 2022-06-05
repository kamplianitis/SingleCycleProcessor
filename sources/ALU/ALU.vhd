----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:18:58 03/27/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all; 


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
	port 
		(
			A : in  STD_LOGIC_VECTOR(31 downto 0);
         B : in  STD_LOGIC_VECTOR(31 downto 0);
         Op : in  STD_LOGIC_VECTOR(3 downto 0);
         ZeroOut : out  STD_LOGIC;
         Outp : out  STD_LOGIC_VECTOR(31 downto 0);
         Cout : out  STD_LOGIC;
         Ovf : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

signal tempoutput: std_logic_vector(31 downto 0); -- we use that to add the delay
signal tempzero: std_logic; -- temp signal that indicates if we have zero
signal ovftemp: std_logic;
signal couttemp : std_logic;
-- all these are for the praxis
signal temp: std_logic_vector(32 downto 0);
signal A33: std_logic_vector(32 downto 0);
signal B33: std_logic_vector(32 downto 0);


begin

	A33(32) <= '0'; -- the bit that will help us with the overflow 
	B33(32) <= '0'; -- the bit that will help us with the overflow 
	-- we pass the values of A and B to temp signals so we can make the addition and the substract
	A33(31 downto 0) <= A;
	B33(31 downto 0) <= B;
	
	process(Op,temp,tempoutput, A33, A, B33 , B) -- taking cases there based on the Op  
		begin 
			
			if (Op = "0000") then  
				temp <= A33 + B33;
				if (temp(32)= '1') then -- temp 32 is practicaly the extention bit
					ovftemp <= '1';
					couttemp <= '1';
				else
					ovftemp <= '0';
					couttemp <= '0';
				end if;
				tempoutput <= temp(31 downto 0);
			elsif(Op = "0001") then 
				temp <= A33 - B33;
				if (temp(32)= '1') then -- same as the addition
					ovftemp <= '1';
					couttemp <= '1';
				else
					ovftemp <= '0';
					couttemp <= '0';
				end if;
				tempoutput <= temp(31 downto 0);
			elsif(Op = "0010") then 
				tempoutput <= A AND B;
				ovftemp <='0';
				couttemp <='0';
			elsif(Op = "0011") then
				tempoutput <= A OR B;
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "0100") then 
				tempoutput <= NOT (A);
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "0101") then 
				tempoutput <= A NAND B;
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "0110") then
				tempoutput <= A NOR B;
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "1000") then 
				tempoutput <= std_logic_vector(shift_right(signed(A), 1));
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "1001") then 
				tempoutput <= std_logic_vector(shift_right(unsigned(A), 1));
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "1010") then 
				tempoutput <= std_logic_vector(shift_left(unsigned(A), 1));
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "1100") then 
				tempoutput <= std_logic_vector(rotate_left(unsigned(A), 1));
				ovftemp <='0';
				couttemp <='0';
			elsif (Op = "1101") then 
				tempoutput <= std_logic_vector(rotate_right(unsigned(A), 1));
				ovftemp <='0';
				couttemp <='0';
			else -- case something goes bad
				tempoutput <= B;
            ovftemp <= '0';
            couttemp <='0';
			end if;
			
			
			-- if statement for the zero.
			-- we check the temp out cause its the signal that is taking care of the results in every other case except the addition and the substract.
			if(tempoutput = "00000000000000000000000000000000" and temp(32) = '0') then 
				tempzero <= '1';
			else 
				tempzero <= '0';
			end if ;
	end process;
	-- now i pass the values in the exits i have with the proper delay.
		ZeroOut <= tempzero after 10 ns;
		Outp <= tempoutput after 10 ns;
		Cout <= couttemp after 10 ns;
		Ovf <= ovftemp after 10 ns;
end Behavioral;

