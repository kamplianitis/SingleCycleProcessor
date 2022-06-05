----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:56 04/05/2020 
-- Design Name: 
-- Module Name:    Mux5bit2to1 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux5bit2to1 is
    port 
			( 
				A : in  STD_LOGIC_VECTOR (4 downto 0);
				B : in  STD_LOGIC_VECTOR (4 downto 0);
				SEL : in  STD_LOGIC;
				X : out  STD_LOGIC_VECTOR (4 downto 0)
			);
end Mux5bit2to1;

architecture Behavioral of Mux5bit2to1 is
begin

	process(SEL, A, B)
		begin  -- the if that decides what the result will be 
			if SEL = '0' then
				X <= A;
			else 
				X <= B;
			end if;
	end process;

end Behavioral;