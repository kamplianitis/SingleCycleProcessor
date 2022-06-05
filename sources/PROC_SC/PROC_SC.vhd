----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:32:27 04/24/2020 
-- Design Name: 
-- Module Name:    TOPLEVEL - Behavioral 
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

entity PROC_SC is
	port 
		(
			Clk : in std_logic;
			Rst : in std_logic
		);
end PROC_SC;

architecture Structural of PROC_SC is

-- we have the components that we need
-- control component
component Control
port 
		(
			-- inputs 
			Rst : in std_logic;
			Clk : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			ALU_zero : in std_logic;
			-- outputs
			PC_sel : out std_logic;
			PC_LdEn : out std_logic;
			ImmExt : out std_logic_vector(1 downto 0);
			RF_WrEn : out std_logic;
			RF_WrData_sel : out std_logic;
			RF_B_sel : out std_logic;
			ALU_Bin_sel : out std_logic;
			ALU_func: out std_logic_vector(3 downto 0);
			ByteOp : out std_logic;
			Mem_WrEn : out std_logic
		);
end component;

--component datapath
component DATAPATH
	port
		(
			-- the inputs that we need are the basically the inputs of the first stage so the inputs of the if_stage
			Clk : in std_logic;
			Reset : in std_logic;
			PC_sel : in std_logic;
			PC_LdEn : in std_logic;
			Instr : in std_logic_vector(31 downto 0);
			ImmExt : in std_logic_vector(1 downto 0);
			RF_WrEn : in std_logic;
			RF_WrData_sel : in std_logic;
			RF_B_sel : in std_logic;
			ALU_Bin_sel : in std_logic;
			ALU_func: in std_logic_vector(3 downto 0);
			ByteOp : in std_logic;
			Mem_WrEn : in std_logic;
			--MEM_RdData : in std_logic_vector(31 downto 0);
			MM_RdData: in std_logic_vector (31 downto 0);
			Pc_Instr : out std_logic_vector(31 downto 0);
			MM_Addr : out std_logic_vector(31 downto 0);
			ALU_zero: out std_logic;
			MM_WrData: out std_logic_vector(31 downto 0)
		);
end component;


-- component Ram

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

-- temp signals

-- ctrl temp signal
signal pcsel : std_logic;
signal pclden : std_logic;
signal imext : std_logic_vector(1 downto 0);
signal rfwrEn : std_logic;
signal datasel : std_logic;
signal bsel : std_logic;
signal binsel : std_logic;
signal func : std_logic_vector(3 downto 0 );
signal bop : std_logic;
signal wen : std_logic;

-- datapath temp signals
signal inst: std_logic_vector(31 downto 0);
signal mmaddr : std_logic_vector(31 downto 0);
signal aluzero : std_logic; 
signal mmwrData : std_logic_vector(31 downto 0);

-- mem temp signals
signal meminst : std_logic_vector(31 downto 0);
signal ddout : std_logic_vector(31 downto 0);

begin

-- now we begin the synthesis
ctrl : Control
	port map 
			(
				Clk => Clk, -- input
				Rst => Rst, -- input
				Instr => meminst, -- comes from RAM (text stage)
				ALU_zero => aluzero, -- comes from ALU (EX STAGE)
				-- outputs
				PC_sel => pcsel, -- goes to the pc stage to enable the pc or not (Datapath)
				PC_LdEn => pclden, -- activation of the pc register (datapath)
				ImmExt => imext, -- option that will apply to immediate (DATAPATH)
				RF_WrEn => rfwrEn, -- activation of the writing in the register file (DATAPATH )
				RF_WrData_sel => datasel, -- choice from where we have to write (mem of alu) (DATAPATH)
				RF_B_sel => bsel, -- choice of the rd or rt (Datapath)
				ALU_Bin_sel => binsel, -- choice for immed of rf_b (Datapath)
				ALU_func => func, --alu function (DATAPATH)
				ByteOp => bop, -- declaration byte or word(DATAPATH)
				Mem_WrEn => wen -- activation of the the store in ram (DATAPATH and RAM)
			);


dp : DATAPATH
	port map 
			(
				Clk => Clk, -- inputs
				Reset => Rst, -- inputs
				PC_sel => pcsel, -- control signal
				PC_LdEn => pclden, -- control signal
				Instr => meminst, -- comes from the ram (text-stage)
				ImmExt => imext, -- control signal that declares what has to be done with the immed
				RF_WrEn =>rfwrEn, -- control signal that decides if we write to the register
				RF_WrData_sel =>datasel, -- control signal that decides between alu or memory
				RF_B_sel => bsel, -- control signal that decides if we the the rt or rd
				ALU_Bin_sel => binsel, -- control signal that decides if we take the immediate or the second reg from rf
				ALU_func => func, -- control signal that declares the function
				ByteOp => bop, -- control signal that declares if we gonna load-store a word or a byte
				Mem_WrEn => wen, -- control signal of memory write enable 
				
				MM_RdData => ddout, -- comes from ram 
				Pc_Instr => inst, -- pc instruction that comes from datapath(if stage) and goes to ram
				MM_Addr => mmaddr, -- declares the address of the date-stage (from datapath to ram)
				ALU_zero => aluzero, -- zero after the alu declaration (goes to control for the beq,bne options)
				MM_WrData => mmwrData -- info of what we write in the ram 
			);

memory : RAM
	port map 
			(
				clk => Clk,
				inst_addr => inst(12 downto 2), -- gives the thesis of the instruction in ram (it's an input)
				inst_dout => meminst, -- gives the instuction that is in the ram (goes to the decstage of datapath)
				data_we => wen, -- control signal of write enable of memory
				data_addr => mmaddr(12 downto 2), -- the address that we will write in ram (comes from the memstage of datapath)
				data_din => mmwrData, -- input that we have to store in the memory (comes from the memstage of datapath)
				data_dout => ddout -- the info in case we load (goes to datapath)
			);

end Structural;

