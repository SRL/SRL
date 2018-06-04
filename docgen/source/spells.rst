
Spells
=======
The file holds functions and procedures that are related to the spells gametab

var Spells
~~~~~~~~~~~
Variable that stores functions and properties of the Runescape magic/spells gametab.

Spells.Open
~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.Open(): Boolean;

Opens the interface

Spells.IsOpen
~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.IsOpen(maxWait:Int32=0): Boolean;

Checks if the interface is already open.

Spells.GetSpellBox
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.GetSpellBox(Spell: ESpellCast): TBox;

Returns the bounding box covering the given spell.

.. note:: by slacky

Spells.PointToSlot
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.PointToSlot(PT: TPoint): Int32;

Returns the index of the slot under `PT`

Spells.MouseOver
~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.MouseOver(spell:ESpellCast): Boolean;

Moves the mouse over the given spell.
.. note:: by slacky

Spells.CanActivate
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.CanActivate(Spell: ESpellCast): Boolean;

Returns True if you can use the spell..
.. note:: by slacky

Spells.Selected
~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.Selected(Spell: ESpellCast): Boolean;

Returns True if the spell is currently selected
.. note:: by Olly

Spells.Cast
~~~~~~~~~~~
.. code-block:: pascal

  function TRSSpells.Cast(Spell: ESpellCast): Boolean

Casts the spell
.. note:: by Olly
