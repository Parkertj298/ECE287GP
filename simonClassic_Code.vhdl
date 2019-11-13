library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

ENTITY simonClassic IS
port (clock, b0 : IN STD_LOGIC; l0, l1,l2,l3 : OUT STD_LOGIC);
END simonClassic;


ARCHITECTURE behavior OF simonClassic IS
signal counter : STD_LOGIC_VECTOR(2 downto 0);

signal randNum : STD_LOGIC_VECTOR(2 downto 0);
signal simonVector : STD_LOGIC_VECTOR (0 to 1);
signal patternDisplayed : STD_LOGIC;
signal userFinishedInput : STD_LOGIC;


signal numOfMoves : INTEGER range 0 to 100;
signal numOfInputs : INTEGER;
signal currentNum : STD_LOGIC_VECTOR(1 downto 0);

signal ledPermissions : STD_LOGIC_VECTOR(3 downto 0) := "0000";

COMPONENT onOff
   port(CLK_50MHz, permission: IN STD_LOGIC; led : OUT STD_LOGIC);
END COMPONENT;

BEGIN --behavior


randCounter : process (clock)
BEGIN -- randCounter: this will be the counter that will generate a random number
if clock'event and clock = '1' then  -- rising clock edge
if counter < "100" then   -- Binary value is 4
counter <= counter + 1;
else
counter <= (others => '0');
end if;
end if;
END process randCounter;


createAndDisplay : process (clock) -- will be adding one value (two bits) to the simonVector after a signal is changed
variable index : integer range 0 to 100;
variable numOfMovesIndex : INTEGER range 0 to 100:= numOfMoves;
SUBTYPE my_loop_range IS natural range 0 to numOfMovesIndex;
BEGIN
if userFinishedInput = '0' then
 patternDisplayed <= '0';
 randNum <= counter;
  simonVector(0) <= randNum(0);
 simonVector(1) <= randNum(1);
 
-- index := numOfMoves + numOfMoves;
-- simonVector(index) <= randNum(0);
-- simonVector(index +1) <= randNum(1);
-- numOfMoves <= numOfMoves + 1;
    ledPermissions <= "0000";
if simonVector = "00" then
   ledPermissions(0) <= '1';
elsif simonVector = "01" then
   ledPermissions(1) <= '1';
elsif simonVector = "10" then
   ledPermissions(2) <= '1';
elsif simonVector = "11" then
   ledPermissions(3) <= '1';
end if;

--  for ii in my_loop_range loop
-- ledPermissions <= (others => '0');
--    currentNum <= simonVector((2*ii) to (2*ii) + 1);
-- if currentNum = "00" then
--    ledPermissions(0) <= '1';
-- elsif currentNum = "01" then
--    ledPermissions(1) <= '1';
-- elsif currentNum = "10" then
--    ledPermissions(2) <= '1';
-- elsif currentNum = "11" then
--    ledPermissions(3) <= '1';
-- end if;
-- END loop;
patternDisplayed <= '1';
END if;
END PROCESS createAndDisplay;


userInput : process (clock)
BEGIN -- userInput
if patternDisplayed = '1' then
if b0 = '0' then
userFinishedInput <= '0';
END if;
else
   userFinishedInput <= '1';
END if;
END PROCESS userInput;

l0Proc: onOff Port map(clock, ledPermissions(0), l0);
l1Proc: onOff Port map(clock, ledPermissions(1), l1);
l2Proc: onOff Port map(clock, ledPermissions(2), l2);
l3Proc: onOff Port map(clock, ledPermissions(3), l3);
END behavior;
