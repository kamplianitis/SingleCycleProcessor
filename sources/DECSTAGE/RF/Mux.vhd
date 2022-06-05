----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:01:59 03/28/2020 
-- Design Name: 
-- Module Name:    Mux - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
library work;
use work.arraypackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux is
	port
	(
		S : in std_logic_vector(4 downto 0);
		F : out std_logic_vector(31 downto 0);
		registers : in registrs
	);
		
	end Mux;

architecture Behavioral of Mux is

signal temp : integer range 0 to 15;

	-- the mux have to decide the vector that is in the S. 
	-- so all i need to do is to find a way to make S an unsigned int 
	-- and give the output the right vector.
	-- so the f will be the registers of the point S.

begin
		F <= registers(to_integer(unsigned(S)));
end Behavioral;
