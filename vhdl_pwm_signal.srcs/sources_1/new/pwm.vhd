----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2021 17:08:35
-- Design Name: 
-- Module Name: pwm - Verhalten
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pwm is
--  Port ( );
    generic(
        max_val: integer := 100000000;
        val_bits: integer := 28
    );
    
    port(
        clk: in std_logic; --clock input
        pulse: out std_logic
    );
end pwm;

architecture Verhalten of pwm is
    signal counter: std_logic_vector((val_bits-1) downto 0); -- same size as max val and dutycycle
    signal duty_cycle: std_logic_vector((val_bits-1) downto 0); --duty Cycle | duty Cycle 50% = maxval / 2
    signal state: std_logic := '1';
begin

count:  process(clk) --counting
            begin
                if(rising_edge(clk)) then
                    if(counter < (max_val-1)) then
                        counter <= counter + 1;
                    else
                        counter <= (others => '0');
                    end if;
                end if;
            end process;
            
fading: process(clk) --counting
            begin
                if(rising_edge(clk)) then
                    if((duty_cycle < (max_val-1)) and (state = '1')) then
                        duty_cycle <= duty_cycle + 1;
                        state <= '1';
                    else
                        state <= '0';
                        duty_cycle <= duty_cycle - 1;
                        
                        if(duty_cycle < 0) then
                            state <= '1';
                        end if;
                    end if;
                end if;
            end process;
            
pulsing: process(clk)

            begin
                if(rising_edge(clk)) then
                    if(duty_cycle > counter) then
                        pulse <= '1';
                    else
                        pulse <= '0';
                    end if;
                end if;
            end process;
               
end Verhalten;
