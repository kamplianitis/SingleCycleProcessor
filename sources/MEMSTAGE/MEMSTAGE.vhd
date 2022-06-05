----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:54:59 04/26/2020 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
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

entity MEMSTAGE is
	port 
		(
			Clk : in std_logic;
			ByteOp : in  STD_LOGIC;
			ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
			MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
			data_we : in std_logic;
			MEM_DataOut : out std_logic_vector(31 downto 0)
		);
end MEMSTAGE;

architecture Structural of MEMSTAGE is

component mem_stage
    port ( 
				ByteOp : in  STD_LOGIC;
				ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
				MM_RdData : in std_logic_vector (31 downto 0);
				MM_Addr : out  STD_LOGIC_VECTOR (31 downto 0);
				MM_WrData : out  STD_LOGIC_VECTOR (31 downto 0);
				MEM_DataOut : out std_logic_vector(31 downto 0)
			 );
end component; 


component RAM
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
end component;


--temp signals that we use
signal mmadr : std_logic_vector(31 downto 0);
signal MMwrdata: std_logic_vector(31 downto 0);
signal MMRdData : std_logic_vector(31 downto 0);

begin


mem: mem_stage
	port map
			(
				ByteOp => ByteOp,
				ALU_MEM_Addr => ALU_MEM_Addr,
				MEM_DataIn => MEM_DataIn,
				MM_RdData => MMRdData,
				MM_Addr => mmadr,
				MM_WrData => MMwrdata,
				MEM_DataOut => MEM_DataOut
			);
			
rm: RAM 
	port map 
			(
				clk => Clk,
				inst_addr => "00000000000",
				inst_dout => open,
				data_we => data_we,
				data_addr => mmadr(12 downto 2),
				data_din => MMwrdata,
				data_dout => MMRdData
			);
end Structural;

