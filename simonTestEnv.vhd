library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity TestOfSimon IS
port (l0, l1, l2, l3 : OUT STD_LOGIC; clock : IN STD_LOGIC);
END TestOfSimon;

ARCHITECTURE logic OF TestOfSimon IS
signal counter : STD_LOGIC_VECTOR(25 downto 0);
signal startTimer : STD_LOGIC;
signal rcounter : integer;
signal rNum : integer;
BEGIN
ledOn : process (counter, rcounter)
BEGIN
rNum <= rcounter;
if rNum = 0 and startTimer = '0'then
startTimer <= '1';
l0 <= '1';
end if;

if rNum = 1 and startTimer = '0' then
startTimer <= '1';
l1 <= '1';
end if;

if rNum = 2 and startTimer = '0' then
startTimer <= '1';
l2 <= '1';
end if;

if rNum = 3 and startTimer = '0' then
startTimer <= '1';
l3 <= '1';
end if;

if startTimer = '1' AND counter = "10111110101111000010000000" then
l0 <= '0';
l1 <= '0';
l2 <= '0';
l3 <= '0';
startTimer <= '0';
end if;
END process ledOn;

halfCounter : process (clock)
BEGIN -- randCounter: this will be the counter that will generate a random number
if startTimer = '1' then
if clock'event and clock = '1' then  -- rising clock edge
if counter < "10111110101111000010000000" then   -- Binary value is 4
counter <= counter + 1;
else
counter <= (others => '0');
end if;
end if;
end if;
END process halfCounter;

randCounter : process (clock)
BEGIN -- randCounter: this will be the counter that will generate a random number
if clock'event and clock = '1' then  -- rising clock edge
if rcounter <= 3 then   -- Binary value is 4
rcounter <= rcounter + 1;
else
rcounter <= 0;
end if;
end if;
END process randCounter;
END logic;
