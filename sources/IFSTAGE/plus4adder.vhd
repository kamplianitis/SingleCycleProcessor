----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:56:12 04/05/2020 
-- Design Name: 
-- Module Name:    plus4adder - Behavioral 
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

entity plus4adder is
	port
		( 
			reginput : in std_logic_vector(31 downto 0);
			result : out std_logic_vector(31 downto 0)
		);
end plus4adder;

architecture Behavioral of plus4adder is
--temp signals

-- i need a signal that is going to depict the 4 number in 32 bits
	signal temp4 : std_logic_vector(31 downto 0);
begin

--initiation of the temp4
temp4 <= "00000000000000000000000000000100";

-- now we only have to make the addition


result <= reginput + temp4;
end Behavioral;

