----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:49:51 07/31/2015 
-- Design Name: 
-- Module Name:    CPU_all3 - Behavioral 
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU_all3 is
	port(	CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			ABUS : OUT STD_LOGIC_VECTOR(15 downto 0);
			DBUS : INOUT STD_LOGIC_VECTOR(15 downto 0);
			nMREQ : OUT STD_LOGIC;
			nRD : OUT STD_LOGIC;
			nWR : OUT STD_LOGIC;
			nBHE : OUT STD_LOGIC;
			nBLE : OUT STD_LOGIC;
			S0,S1,S2,S3,S4,S5 : OUT STD_LOGIC_VECTOR(7 downto 0);
			A,B : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end CPU_all3;

architecture Behavioral of CPU_all3 is

signal T_clock : STD_LOGIC_VECTOR(3 downto 0);
signal Cy,PCupdate,Rupdate,nRDtemp,nBLEtemp,nBHEtemp,nMREQtemp : STD_LOGIC; 
signal PC,PCnew,IR_control,IR_PC,Addr,ABUStemp : STD_LOGIC_VECTOR(15 downto 0);
signal Rreg : STD_LOGIC_VECTOR(2 downto 0);
signal ALUout,Data,Rtemp,Rdata : STD_LOGIC_VECTOR(7 downto 0);

	component CPU_clock is
		Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           T : out  STD_LOGIC_VECTOR (3 downto 0));
	end component;
	
	component CPU_PC is
		port(	RST : IN STD_LOGIC;
			T : IN STD_LOGIC_VECTOR(3 downto 0);
			PCupdate : IN STD_LOGIC;
			PCnew : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_in : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_out : OUT STD_LOGIC_VECTOR(15 downto 0);
			PC : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component CPU_compute is
		port(	RST : IN STD_LOGIC;
		T : IN STD_LOGIC_VECTOR(3 downto 0);
		IR : IN STD_LOGIC_VECTOR(15 downto 0);
		Rupdate : IN STD_LOGIC;
		Rdata : IN STD_LOGIC_VECTOR(7 downto 0);
		Rreg : IN STD_LOGIC_VECTOR(2 downto 0);
		ALUout : OUT STD_LOGIC_VECTOR(7 downto 0);
		Cy : OUT STD_LOGIC;
		Addr : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component CPU_memory is
		port(	T :  IN STD_LOGIC_VECTOR(3 downto 0);
			IR : IN STD_LOGIC_VECTOR(15 downto 0);
			ALUout : IN STD_LOGIC_VECTOR(7 downto 0);
			Data : IN STD_LOGIC_VECTOR(7 downto 0);
			Rtemp : OUT STD_LOGIC_VECTOR(7 downto 0));
	end component;
	
	component CPU_writeback is
		port(	T : IN STD_LOGIC_VECTOR(3 downto 0);
			IR : IN STD_LOGIC_VECTOR(15 downto 0);
			Rtemp : IN STD_LOGIC_VECTOR(7 downto 0);
			Addr : IN STD_LOGIC_VECTOR(15 downto 0);
			PC : IN STD_LOGIC_VECTOR(15 downto 0);
			Rupdate : OUT STD_LOGIC;
			Rdata : OUT STD_LOGIC_VECTOR(7 downto 0);
			Rreg : OUT STD_LOGIC_VECTOR(2 downto 0);
			PCupdate : OUT  STD_LOGIC;
			PCnew : OUT STD_LOGIC_VECTOR(15 downto 0));
	end component;
	
	component CPU_control is
		port(	T : IN STD_LOGIC_VECTOR(3 downto 0);
			PC : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_in : IN STD_LOGIC_VECTOR(15 downto 0);
			Addr : IN STD_LOGIC_VECTOR(15 downto 0);
			ALUout : IN STD_LOGIC_VECTOR(7 downto 0);
			Data : OUT STD_LOGIC_VECTOR(7 downto 0);
			IR_out : OUT STD_LOGIC_VECTOR(15 downto 0);
			ABUS : OUT STD_LOGIC_VECTOR(15 downto 0);
			DBUS : INOUT STD_LOGIC_VECTOR(15 downto 0);
			nMREQ : OUT STD_LOGIC;
			nRD : OUT STD_LOGIC;
			nWR : OUT STD_LOGIC;
			nBHE : OUT STD_LOGIC;
			nBLE : OUT STD_LOGIC);
	end component;
begin	
	U1: CPU_clock PORT MAP(
		CLK => CLK,
		RST => RST,
		T => T_clock);
		
	U2: CPU_PC PORT MAP(
		RST => RST,
		T => T_clock,
		PCupdate => PCupdate,
		PCnew => PCnew,
		IR_in => IR_control,
		IR_out => IR_PC,
		PC => PC);
	
	U3: CPU_compute PORT MAP(
		RST => RST,
		T => T_clock,
		IR => IR_PC,
		Rupdate => Rupdate,
		Rdata => Rdata,
		Rreg => Rreg,
		ALUout => ALUout,
		Cy => Cy,
		Addr => Addr);
	
	U4: CPU_memory PORT MAP(
		T => T_clock,
		IR => IR_PC,
		ALUout => ALUout,
		Data => Data,
		Rtemp => Rtemp);
		
	U5: CPU_writeback PORT MAP(
		T => T_clock,
		IR => IR_PC,
		Rtemp => Rtemp,
		Addr => Addr,
		PC => PC,
		Rupdate => Rupdate,
		Rdata => Rdata,
		Rreg => Rreg,
		PCupdate => PCupdate,
		PCnew => PCnew);
		
	U6: CPU_control PORT MAP(
		T => T_clock,
		PC => PC,
		IR_in => IR_PC,
		Addr => Addr,
		ALUout => ALUout,
		Data => Data,
		IR_out => IR_control,
		ABUS => ABUStemp,
		DBUS => DBUS,
		nMREQ =>nMREQtemp,
		nRD => nRDtemp,
		nWR => nWR,
		nBHE => nBHEtemp,
		nBLE => nBLEtemp);
	
	ABUS <= ABUStemp;
	
	S1 <= IR_PC(15 downto 8);
	S0 <= IR_PC(7 downto 0);
	
	S4 <= DBUS(15 downto 8);
	S3 <= DBUS(7 downto 0);
	
	--S2 <= ABUStemp(15 downto 8);
	S2(7 downto 1) <= "0000000";
	S2(0) <= Cy; 
	S5 <= ABUStemp(7 downto 0);
	
	A(3 downto 0) <= "0000";
	A(4) <= nBLEtemp;
	A(5) <= nBHEtemp;
	A(6) <= nRDtemp;
	A(7) <= nMREQtemp;
	
	B(7 downto 4) <= "0000";
	B(3 downto 0) <= T_clock;
	
	nBLE <=   nBLEtemp;
	nBHE <=   nBHEtemp;
	nRD  <=   nRDtemp;
	nMREQ <=  nMREQtemp;

end Behavioral;

------CLOCK-----------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_clock is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           T : out  STD_LOGIC_VECTOR (3 downto 0));
end CPU_clock;

architecture Behavioral of CPU_clock is

begin
		process(CLK,RST)
		variable	temp : STD_LOGIC;
		variable arry : STD_LOGIC_VECTOR (3 downto 0);
		begin
			if(RST = '0') then
				arry := "1000";
			elsif (CLK = '1' and CLK' event) then
				temp := arry(3);
				arry(3 downto 1) := arry(2 downto 0);
				arry(0) := temp;
			end if;
			T <= arry;
		end process;
end Behavioral;

------Fetch PC--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_PC is
	port(	RST : IN STD_LOGIC;
			T : IN STD_LOGIC_VECTOR(3 downto 0);
			PCupdate : IN STD_LOGIC;
			PCnew : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_in : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_out : OUT STD_LOGIC_VECTOR(15 downto 0);
			PC : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
	
end CPU_PC;

architecture Behavioral of CPU_PC is
signal PCtemp : STD_LOGIC_VECTOR(15 downto 0);
begin
	process (RST,T,PCupdate,PCnew)
	begin 
		if (RST = '0') then
			PCtemp <= "0000000000000000";
		elsif (PCupdate = '1') then
			PCtemp <= PCnew;
		elsif (T(0) = '0' and T(0)' event) then
			PCtemp <= PCtemp + 1; 
		end if;
	end process;
	
	PC <= PCtemp;
	
	process(RST,T,IR_in)
	variable IRtemp : STD_LOGIC_VECTOR(15 downto 0);
	begin
		if (RST  = '0') then
			IRtemp := "0000000000000000";
		elsif (T(0) = '1') then
			IRtemp := IR_in;
		end if;
		
		IR_out <= IRtemp;
	end process;
end Behavioral;

------Compute--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_compute is
port(	RST : IN STD_LOGIC;
		T : IN STD_LOGIC_VECTOR(3 downto 0);
		IR : IN STD_LOGIC_VECTOR(15 downto 0);
		Rupdate : IN STD_LOGIC;
		Rdata : IN STD_LOGIC_VECTOR(7 downto 0);
		Rreg : IN STD_LOGIC_VECTOR(2 downto 0);
		Cy : OUT STD_LOGIC;
		ALUout : OUT STD_LOGIC_VECTOR(7 downto 0);
		Addr : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
end CPU_compute;

architecture Behavioral of CPU_compute is
signal R0,R1,R2,R3,R4,R5,R6,R7 : STD_LOGIC_VECTOR(7 downto 0);
signal A,B : STD_LOGIC_VECTOR(7 downto 0);
begin
	process(RST,T,IR,Rupdate,Rdata,Rreg)
	begin
		if(RST = '0') then
			A <= "00000000";
		elsif((T(1)='1' and T(1)' event)) then
			case IR(10 downto 8) is
				when "000" => A <= R0;
				when "001" => A <= R1;
				when "010" => A <= R2;
				when "011" => A <= R3;
				when "100" => A <= R4;
				when "101" => A <= R5;
				when "110" => A <= R6;
				when "111" => A <= R7;
				when others => NULL;
			end case;
		end if;
	end process;
	
	process(RST,T,IR,Rupdate,Rdata,Rreg)
	begin
		if(RST = '0') then
			B <= "00000000";
		elsif((T(1)='1' and T(1)' event)) then
			case IR(2 downto 0) is
				when "000" => B <= R0;
				when "001" => B <= R1;
				when "010" => B <= R2;
				when "011" => B <= R3;
				when "100" => B <= R4;
				when "101" => B <= R5;
				when "110" => B <= R6;
				when "111" => B <= R7;
				when others => NULL;
			end case;
		end if;
	end process;
	
	process(RST,T,IR,Rupdate,Rdata,Rreg)
	begin
		if(RST = '0') then
			Addr <= "0000000000000000";
		elsif((T(1)='1' and T(1)' event)) then
			Addr(15 downto 8) <= R7;
			Addr(7 downto 0)<= IR(7 downto 0);
		end if;
	end process;
	
	
	process(RST,T,IR,Rupdate,Rdata,Rreg)
	variable ALUtemp : STD_LOGIC_VECTOR(8 downto 0);
	variable Atmp,Btmp : STD_LOGIC_VECTOR(8 downto 0);
	begin
		if(RST = '0') then
			ALUout <= "00000000";
			Cy <= '0';
		elsif((T(1)='0' and T(1)' event)) then
			if(IR(15 downto 11) = "00110") then
				Atmp(7 downto 0) := A;	Btmp(7 downto 0) := B;
				Atmp(8) := '0';	Btmp(8):= '0';
				ALUtemp := Atmp + Btmp;
				Cy <= ALUtemp(8);
				ALUout <= ALUtemp(7 downto 0);
			elsif(IR(15 downto 11) = "00100") then
				Atmp(7 downto 0) := A;	Btmp(7 downto 0) := B;
				Atmp(8) := '0';	Btmp(8):= '0';
				ALUtemp := Atmp - Btmp;
				if(Atmp < Btmp) then
					Cy <= ALUtemp(8);
				else
					Cy <= '0';
				end if;
				ALUout <= ALUtemp(7 downto 0);
			end if;
			
			case IR(15 downto 11) is
				--when "00110" => ALUout <= A + B;	--ADD
				--when "00100" => ALUout <= A - B;	--SUB
				when "01000" => ALUout <= IR(7 downto 0);	--MVI
				when "01010" => ALUout <= B;	--MOV
				when "00010" => ALUout <= A;	--JZ
				when "01100" => ALUout <= A;	--STA
				when others  => NULL;
			end case;
		end if;
	end process;
	
	process (RST,T,IR,Rupdate,Rdata,Rreg)
	begin
		if(RST =  '0') then
			R0 <= "00000000";
			R1 <= "11111111";	--for test
			R2 <= "00000100";	--for test
			R3 <= "00000000";
			R4 <= "00000000";
			R5 <= "00000000";
			R6 <= "00000000";
			R7 <= "00000000";
		elsif (Rupdate = '1') then 
			case Rreg is
				when "000" => R0 <= Rdata;
				when "001" => R1 <= Rdata;
				when "010" => R2 <= Rdata;
				when "011" => R3 <= Rdata;
				when "100" => R4 <= Rdata;
				when "101" => R5 <= Rdata;
				when "110" => R6 <= Rdata;
				when others => R7 <= Rdata;
			end case;
		end if;
	end process;
end Behavioral;
------Memory---------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_memory is
	port(	T :  IN STD_LOGIC_VECTOR(3 downto 0);
			IR : IN STD_LOGIC_VECTOR(15 downto 0);
			ALUout : IN STD_LOGIC_VECTOR(7 downto 0);
			Data : IN STD_LOGIC_VECTOR(7 downto 0);
			Rtemp : OUT STD_LOGIC_VECTOR(7 downto 0)
	);
end CPU_memory;

architecture Behavioral of CPU_memory is

begin
	process(T,IR,ALUout,Data)
	begin
		if(T = "0100") then	
			case IR(15 downto 11) is
				when "00010" => Rtemp <= ALUout;	--JZ
				when "00100" => Rtemp <= ALUout;	--SUB
				when "00110" => Rtemp <= ALUout;	--ADD
				when "01010" => Rtemp <= ALUout;	--MOV
				when "01000" => Rtemp <= ALUout;	--MVI
				when "01110" => Rtemp <= Data;	--LDA
				when others  => Rtemp <= "00000000";
			end case;
		end if;
	end process;
end Behavioral;

------WriteBack------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_writeback is
	port(	T : IN STD_LOGIC_VECTOR(3 downto 0);
			IR : IN STD_LOGIC_VECTOR(15 downto 0);
			Rtemp : IN STD_LOGIC_VECTOR(7 downto 0);
			Addr : IN STD_LOGIC_VECTOR(15 downto 0);
			PC : IN STD_LOGIC_VECTOR(15 downto 0);
			Rupdate : OUT STD_LOGIC;
			Rdata : OUT STD_LOGIC_VECTOR(7 downto 0);
			Rreg : OUT STD_LOGIC_VECTOR(2 downto 0);
			PCupdate : OUT  STD_LOGIC;
			PCnew : OUT STD_LOGIC_VECTOR(15 downto 0)
	);
end CPU_writeback;

architecture Behavioral of CPU_writeback is

begin
	process(T,IR,Rtemp)
	begin
		if(T = "1000") then
			case IR(15 downto 11) is
				when "01110" => Rupdate <= '1'; Rdata <= Rtemp; Rreg <= IR(10 downto 8);	--LDA
				when "00110" => Rupdate <= '1'; Rdata <= Rtemp; Rreg <= IR(10 downto 8);	--ADD
				when "00100" => Rupdate <= '1'; Rdata <= Rtemp; Rreg <= IR(10 downto 8);	--SUB
				when "01010" => Rupdate <= '1'; Rdata <= Rtemp; Rreg <= IR(10 downto 8);	--MOV
				when "01000" => Rupdate <= '1'; Rdata <= Rtemp; Rreg <= IR(10 downto 8);	--MVI
				when others  => Rupdate <= '0'; Rdata <= "00000000"; Rreg <= "000"; 
			end case;
		else
			 Rupdate <= '0'; Rdata <= "00000000"; Rreg <= "000"; 
		end if;
	end process;
	
	process(T,IR,Addr,Rtemp)
	variable temp : STD_LOGIC;
	variable PCnewtemp : STD_LOGIC_VECTOR(15 downto 0);
	begin
		if(T = "1000") then
			if(IR(15 downto 11) = "00000") then
				PCupdate <= '1'; 
				PCnew <= Addr;	--JMP
			elsif(IR(15 downto 11) = "00010") then
				temp := '0';
				PCnewtemp := "0000000000000000";
				if(Rtemp = "00000000") then
					temp := '1'; 
					PCnewtemp := Addr;	--JZ
				end if;
				PCupdate <= temp;
				PCnew <= PCnewtemp;
			else
				PCupdate <= '0';
				PCnew <= "0000000000000000";
			end if;
		else
			PCupdate <= '0';
			PCnew <= "0000000000000000";
		end if;
	end process;
	
end Behavioral;
------Control--------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CPU_control is
	port(	T : IN STD_LOGIC_VECTOR(3 downto 0);
			PC : IN STD_LOGIC_VECTOR(15 downto 0);
			IR_in : IN STD_LOGIC_VECTOR(15 downto 0);
			Addr : IN STD_LOGIC_VECTOR(15 downto 0);
			ALUout : IN STD_LOGIC_VECTOR(7 downto 0);
			Data : OUT STD_LOGIC_VECTOR(7 downto 0);
			IR_out : OUT STD_LOGIC_VECTOR(15 downto 0);
			ABUS : OUT STD_LOGIC_VECTOR(15 downto 0);
			DBUS : INOUT STD_LOGIC_VECTOR(15 downto 0);
			nMREQ : OUT STD_LOGIC;
			nRD : OUT STD_LOGIC;
			nWR : OUT STD_LOGIC;
			nBHE : OUT STD_LOGIC;
			nBLE : OUT STD_LOGIC
	);
end CPU_control;

architecture Behavioral of CPU_control is

begin
	process(T,PC,IR_in,ALUout,Addr)
	begin
		if(T = "0001") then 	--fetch PC
			ABUS <= PC;
			nMREQ <= '0';
			nRD <= '0';
			nWR <= '1';
			nBHE <= '0';
			nBLE <= '0';
			
			DBUS <= "ZZZZZZZZZZZZZZZZ";
			IR_out <= DBUS;
		elsif(T = "0100" and IR_in(15 downto 11) = "01100") then	--STA
			ABUS <= Addr;
			--DBUS <= "ZZZZZZZZZZZZZZZZ";
			DBUS(15 downto 8) <= "00000000";
			DBUS(7 downto 0) <= ALUout;
			nMREQ <= '0';
			nRD <= '1';
			nWR <= '0';
			nBHE <= '0';
			nBLE <= '0';
		elsif(T = "0100" and IR_in(15 downto 11) = "01110") then	--LDA
			ABUS <= Addr;
			nMREQ <= '0';
			nRD <= '0';
			nWR <= '1';
			nBHE <= '1';
			nBLE <= '0';
		
			Data <= DBUS(7 downto 0);
			DBUS <= "ZZZZZZZZZZZZZZZZ";
		elsif (T = "0010") then
			nMREQ <= '1';
			nRD <= '1';
			nWR <= '1';
			nBHE <= '1';
			nBLE <= '1';
			Data <= "00000000";
			DBUS <= "ZZZZZZZZZZZZZZZZ";
			ABUS <= Addr;
			IR_out <= "0000000000000000";
		else
			nMREQ <= '1';
			nRD <= '1';
			nWR <= '1';
			nBHE <= '1';
			nBLE <= '1';
			Data <= "00000000";
			DBUS <= "ZZZZZZZZZZZZZZZZ";
			ABUS <= "0000000000000000";
			IR_out <= "0000000000000000";
		end if;
		
	end process;

end Behavioral;

----------------------------------------------------------------------------------
