----------------------------------------------------------------------------------
-- Engineer: John Bryan Valle
-- 
-- Create Date: 01.01.2021 17:08:35
-- Design Name: 
-- Module Name: pwm - Verhalten
-- Description: 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pwm is
	generic(
		max_val: integer := 1000;
		val_bits: integer := 10
	);
	port(
		clk: in std_logic;
		duty_cycle: in std_logic_vector((val_bits -1) downto 0);
		pulse: out std_logic
	);
end pwm;

architecture Verhalten of pwm is
	signal cnt: std_logic_vector((val_bits -1) downto 0);
begin
    
    process(clk) -- Counting
    begin
        if(clk'event and clk = '1') then
            if (cnt < (max_val-1)) then
                cnt <= cnt + 1;
            else
                cnt <= (others => '0');
            end if;
        end if;
    end process;
    
    process(clk) -- Pulsing
    begin
        if(clk'event and clk = '1') then
            if (duty_cycle > cnt) then
                pulse <= '1';
            else
                pulse <= '0';
            end if;
        end if;
    end process;
end Verhalten;
