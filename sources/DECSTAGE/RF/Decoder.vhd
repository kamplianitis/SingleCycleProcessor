----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:42:23 03/27/2020 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
	port
		(
			Awr: in std_logic_vector(4 downto 0);
			registerdestination : out std_logic_vector(31 downto 0)
		);
end Decoder;

architecture Behavioral of Decoder is

signal temp : std_logic_vector(31 downto 0);
begin

-- the decoder basicaly puts '1' in the position that is getting by the Awr.
-- so all we have to do is to put zeros to the positions that does not come with
-- Awr. we can do this with a for loop

decodeprocess:
	for i in 0 to 31 generate
		temp(i) <= '1' when Awr = i
						else '0';
	end generate;

-- we add the delay	
registerdestination<= temp after 10 ns; --delayed signal
end Behavioral;

