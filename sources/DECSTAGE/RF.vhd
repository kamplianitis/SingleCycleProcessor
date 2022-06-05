----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:42:50 04/20/2020 
-- Design Name: 
-- Module Name:    RF - Behavioral 
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
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.arraypackage.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
	port
		(
			Adr1 : in std_logic_vector(4 downto 0);
			Adr2 : in std_logic_vector(4 downto 0);
			Awr : in std_logic_vector(4 downto 0);
			Dout1: out std_logic_vector(31 downto 0);
			Dout2: out std_logic_vector(31 downto 0);
			Din : in std_logic_vector(31 downto 0);
			WrEn : in std_logic;
			Clk : in std_logic;
			Rst : in std_logic
		);		
end RF;

architecture Structural of RF is

-- we begin to initiate the components we're going to use
component Decoder
	port
		(
			Awr: in std_logic_vector(4 downto 0);
			registerdestination: out std_logic_vector(31 downto 0)
		);
end component;

-- now the register component

component Reg 
	port
		( 
			Clk : in std_logic;
			Rst : in std_logic;
			WE : in std_logic;
			Datain : in std_logic_vector(31 downto 0);
			Dataout: out std_logic_vector(31 downto 0)
		);
end component;

-- and at the end the mux

component Mux 
	port
		(
			S : in std_logic_vector(4 downto 0);
			F : out std_logic_vector(31 downto 0);
			registers : in registrs
		);
end component;

-- the signals that we need
signal tempdc : std_logic_vector(31 downto 0);
signal regresults : registrs;
signal tempwef : std_logic_vector(31 downto 0);
signal tempout1 : std_logic_vector(31 downto 0);
signal tempout2 : std_logic_vector(31 downto 0);


begin


dc : Decoder
	port map 
			(
				Awr => Awr,
				registerdestination => tempdc -- we use a signal so that we can use the result as an input
			);

-- now i need to create the registers. As we are said the R0 has to show 0 every-time.
-- so all we have to do is to create a different portmap and make the input "0" permanently.

R0 : Reg
	port map
			(
				Clk => Clk,
				Datain => "00000000000000000000000000000000",
				WE => '1',
				Dataout => regresults(0),
				Rst=> Rst
			);
			
-- now we do a for generate for all the other registers
registerssum:
	for i in 1 to 31 generate
		tempwef(i) <= WrEn and tempdc(i);
			registers:
			Reg
				port map 
						(
							Clk => Clk,
							Datain => Din,
							Rst=>Rst,
							WE => tempwef(i),
							Dataout => regresults(i)
						);
	end generate;


-- and in the end we have to create the muxes that will declare the final product

mux1: Mux
	port map 
			(
				registers => regresults, 
				S => Adr1,
				F => tempout1
			);

mux2: Mux
	port map 
			(
				registers => regresults, 
				S => Adr2,
				F => tempout2
			);

Dout1 <= tempout1 after 12ns;
Dout2 <= tempout2 after 12ns;

end Structural;

