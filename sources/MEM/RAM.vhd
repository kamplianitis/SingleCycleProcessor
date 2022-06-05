----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:56:49 04/05/2020 
-- Design Name: 
-- Module Name:    RAM - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
	port
		(
			clk : in std_logic;
			inst_addr : in std_logic_vector(10 downto 0);
			inst_dout : out std_logic_vector(31 downto 0);
			data_we : in std_logic;
			data_addr : in std_logic_vector(10 downto 0);
			data_din : in std_logic_vector(31 downto 0);
			data_dout : out std_logic_vector(31 downto 0)
		);
end RAM;



architecture syn of RAM is
	type ram_type is array (2047 downto 0) of std_logic_vector (31 downto 0);
	
	impure function InitRamFromFile (RamFileName : in string) return ram_type is
	FILE ramfile : text is in RamFileName;
	variable RamFileLine : line;
	variable ram : ram_type;
	begin
			for i in 0 to 1023 loop
				readline(ramfile, RamFileLine);
				read (RamFileLine, ram(i));
			end loop;
			
			for i in 1024 to 2047 loop
				ram(i) := x"00000000";
			end loop;
			return ram;
	end function;
	
	signal RAM: ram_type := InitRamFromFile("rom.data");

begin
	process (clk)
		begin
			if clk'event and clk = '1' then
				if data_we = '1' then
					RAM(conv_integer(data_addr)) <= data_din;
				end if;
			end if;
	end process;
data_dout <= RAM(conv_integer(data_addr)) after 12ns;
inst_dout <= RAM(conv_integer(inst_addr)) after 12ns;
end syn;
