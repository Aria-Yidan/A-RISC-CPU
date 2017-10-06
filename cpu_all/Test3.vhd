
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:52:45 07/31/2015
-- Design Name:   CPU_all3
-- Module Name:   C:/Xilinx91i/2015_CPU/CPU_all3/Test3.vhd
-- Project Name:  CPU_all3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU_all3
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends 
-- that these types always be used for the top-level I/O of a design in order 
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY Test3_vhd IS
END Test3_vhd;

ARCHITECTURE behavior OF Test3_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT CPU_all3
	PORT(
		CLK : IN std_logic;
		RST : IN std_logic;    
		DBUS : INOUT std_logic_vector(15 downto 0);      
		ABUS : OUT std_logic_vector(15 downto 0);
		nMREQ : OUT std_logic;
		nRD : OUT std_logic;
		nWR : OUT std_logic;
		nBHE : OUT std_logic;
		nBLE : OUT std_logic
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK :  std_logic := '0';
	SIGNAL RST :  std_logic := '0';

	--BiDirs
	SIGNAL DBUS :  std_logic_vector(15 downto 0);

	--Outputs
	SIGNAL ABUS :  std_logic_vector(15 downto 0);
	SIGNAL nMREQ :  std_logic;
	SIGNAL nRD :  std_logic;
	SIGNAL nWR :  std_logic;
	SIGNAL nBHE :  std_logic;
	SIGNAL nBLE :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: CPU_all3 PORT MAP(
		CLK => CLK,
		RST => RST,
		ABUS => ABUS,
		DBUS => DBUS,
		nMREQ => nMREQ,
		nRD => nRD,
		nWR => nWR,
		nBHE => nBHE,
		nBLE => nBLE
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		--wait for 100 ns;
		
		RST <= '0';
		CLK <= '0';
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0011000100000010";	--ADD R1,R2
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;

		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0111001100001010";	--LDA R3,[R7//00001010]
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0000000010101010";
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0100010001010101";	--MVI R4,01010101
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0101010100000001";	--MOV R5,R1
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0000000001010101";	--JMP 01010101
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0001010101100110";	--JZ R5,01100110
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0001011001110111";	--JZ R6,01110111
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0010001000000001";	--SUB R2,R1
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T1
		RST <= '1';
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "0110000100001111";	--STA R1,[00001111]
		wait for 10 ns;
		
		--T2
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		DBUS <= "ZZZZZZZZZZZZZZZZ";
		wait for 10 ns;
		
		--T3
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;
		
		--T4
		CLK <= '0';
		wait for 10 ns;
		CLK <= '1';
		wait for 10 ns;

		-- Place stimulus here

		wait; -- will wait forever
	END PROCESS;

END;
