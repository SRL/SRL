
Logout
=======
The file holds functions and procedures that are in the logout-tab.

type TRSLogoutWS
~~~~~~~~~~~~~~~~
Type that holds the methods for the in-game worldswitcher located on the logout tab

type TRSLogout
~~~~~~~~~~~~~~~
The type that holds functions and properties of the Runescape logout-tab.

var Logout
~~~~~~~~~~
Variable that stores functions and properties of the Runescape logout interface.

Logout.Open
~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogout.Open(): Boolean;

Opens the interface

Logout.IsOpen
~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogout.IsOpen(Tab:ELogoutSubtab=lsTabNone; maxWait:Int32=0): Boolean;

Checks if the interface is already open. Can also be used to check if a specific "subtab" is open.

Logout.ClickLogout
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogout.ClickLogout(attemts:Int32=3; tryTime:Int32=20000): Boolean;

Clicks the logout button, by default retires 3 times over 20 seconds.

Logout.SwitchToWorld
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogout.SwitchToWorld(World: Integer): Boolean;

Jumps to the given world.

Logout.WorldSwitcher.isOpen
~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.isOpen(WaitTime: Integer = 0): Boolean;

Returns if the in-game worldswitcher is open

Logout.WorldSwitcher.Open
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.Open: Boolean;

Opens the in-game worldswitcher

Logout.WorldSwitcher.Close
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.Close: Boolean;

Closes the worldswitcher (returns back to the logout button)

Logout.WorldSwitcher.VisibleWorlds
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.VisibleWorlds(out Worlds: TIntegerArray; out Boxes: TBoxArray): Boolean;

Returns the VisibleWorlds and their bounds

Logout.WorldSwitcher.CurrentWorld
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.CurrentWorld: Integer;

Returns the world we are currently in

Logout.WorldSwitcher.SwitchTo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSLogoutWS.SwitchTo(World: Integer): Boolean;

Hops to the given world
