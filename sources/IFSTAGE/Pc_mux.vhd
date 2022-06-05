----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:29:46 04/05/2020 
-- Design Name: 
-- Module Name:    Pc_mux - Behavioral 
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

entity Pc_mux is
	port 
		( 
			--inputs 
			inputplusI : in std_logic_vector(31 downto 0);
			input : in std_logic_vector (31 downto 0);
			-------
			sel : in std_logic; -- selection of the right input
			output : out std_logic_vector(31 downto 0)
		);
end Pc_mux;


architecture Behavioral of Pc_mux is


--temp signals
signal temp : std_logic_vector(31 downto 0 );

begin

	process(sel, inputplusI, input) 
		begin 
			if (sel = '1') then 
				temp <= inputplusI;
			else 
				temp<= input;
			end if ;
	end process;
	
output <= temp;
end Behavioral;

