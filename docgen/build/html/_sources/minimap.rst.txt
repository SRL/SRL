
BankScreen
==========

Minimap.GetMiddle
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetMiddle: TPoint;

Returns the center of the minimap

Minimap.GetPrayerLevel
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetPrayerLevel(): Int32;

Returns your current prayer level

Minimap.GetHPLevel
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetHPLevel: Int32;

Returns your current HP level

Minimap.GetHPPercent
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetHPPercent(): Int32;

Returns your current HP level as a percentage `0..100`

Minimap.GetSpecialAttack
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetSpecialAttack(): Int32;

Returns your special attack.

Minimap.IsPoisoned
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.IsPoisoned: Boolean;

Returns true if you're poisoned by checking the minimap orb.

Minimap.CurePoison
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    procedure TRSMinimap.CurePoison;

Clicks the hitpoints orb if currently poisoned.

Minimap.GetRunEnergy
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetRunEnergy(): Integer;

Returns your current energy level 

Minimap.isPrayerEnabled
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.isPrayerEnabled(const Time: UInt32 = 0): Boolean;

Returns `True` if you have enabled it otherwise `False`.

Minimap.isRunEnabled
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.isRunEnabled(WaitTime: Int32 = 0): Boolean;

Returns `True` if you have enabled it otherwise `False`.

Minimap.TogglePrayer
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.TogglePrayer(const Enable: Boolean): Boolean;

A toggle to enable or disable prayer.

Minimap.ToggleRun
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.ToggleRun(const Enable: Boolean): Boolean;

A toggle to enable or disable running.

Minimap.isPlayerMoving
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.isPlayerMoving(MinShift: Integer = 300): Boolean;

Returns `True` if your character is moving.

Minimap.FindFlag
~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.FindFlag(BMP: Int32; out P: TPoint): Boolean; overload;

Searches for the flag on a bitmap.

Minimap.isFlagPresent
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.isFlagPresent(const WaitTime: UInt32 = 0): Boolean;

Returns True if the flag can be found on the minimap.. otherwise False.

Minimap.WaitFlag
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    procedure TRSMinimap.WaitFlag(const Dist: UInt32 = 0; ExitIfNotMoving: Boolean = True);

Waits while the flag distance is greater than `dist`. Timeout is ~20 seconds which
is reset when flag distance has changed.

Minimap.WaitPlayerMoving
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    procedure TRSMinimap.WaitPlayerMoving(UseFlag: Boolean = True; TimeOut: Integer = 30000; MinShift: Integer = 300);

Waits till your character is no longer moving.

Minimap.WaitFlagEx
~~~~~~~~~~~~~~~~~~

.. code-block:: pascal

    function TRSMinimap.WaitFlagEx(MaxDist: Byte = 5): Boolean;

Extra WaitFlag method that Waits for the flag to disapear but will return if the
position we walked to is where the flag was first clicked.

  - Useful to know if you were able to walk into a room or not (blocked entrance, etc).
  - MaxDist param is default, but is the max distance the flag can move else we result False.

Example:

.. code-block:: pascal

    if (Minimap.WaitFlagEx()) then
      srl.Writeln('We have walked to the position succesfully')
    else
      srl.Writeln('We have finished walking, but the flag moved alot so we didnt hit our target pos');

Minimap.GetCompassAngle
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.GetCompassAngle(AsDegrees:Boolean=True): Extended;

Returns the current compass angle, default as degrees.

Minimap.MouseSetCompassAngle
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSMinimap.MouseSetCompassAngle(Angle, Tolerance: Extended): Boolean;

Some long code that does stuff.
