
Inventory
=======
The inventory file holds functions and procedures that are related 
to the runescape inventory

type TRSInventory
~~~~~~~~~~~~~~~
The type that holds functions and properties of the Runescape inventory gametab.

var inventory
~~~~~~~~~~~
Variable that stores functions and properties of the Runescape inventory gametab.

Inventory.Open
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.Open(): Boolean;

Opens the interface

Inventory.IsOpen
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.IsOpen(maxWait:Int32=0): Boolean;

Checks if the interface is already open.

Inventory.IsSlotValid
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.IsSlotValid(idx: Int32): Boolean;

Returns true if the given slot is within a valid range.

.. note:: by slacky

Inventory.PointToSlot
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.PointToSlot(pt:TPoint): Int32;

Returns the slot-index under the given TPoint. 
If it's not over a slot then -1 is returned

.. note:: by slacky

Inventory.MouseSlot
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  procedure TRSInventory.MouseSlot(idx:Int32; btn: Integer = mouse_Move);

Moves the moise over the given slot-index.

.. note:: by slacky

Inventory.IsFull
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.IsFull(): Boolean;

Returns True if the inventory can't hold anymore items

.. note:: by slacky

Inventory.GetSlotBox
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.GetSlotBox(idx:Int32): TBox;

Returns the bounding box covering the given slot-index.

.. note:: by slacky

Inventory.IsSlotUsed
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.IsSlotUsed(idx:Int32): Boolean;

Returns true if the given slot is occupied.

.. note:: by slacky

Inventory.GetUsedSlots
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.GetUsedSlots(idx:Int32): TIntegerArray;

Returns all the occupied slot-indices.

.. note:: by slacky

Inventory.Count
~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.Count: Int32;

Returns the number of used slots

Inventory.DropItems
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.DropItems(Slots:TIntegerArray = DROP_PATTERN_REGULAR);

Drops the given items. It's order-sensitive which means unless you want it to 
jump randomly all over the inventory dropping items, you give it a ordered drop-pattern.

.. note:: by slacky

Examples:
.. code-block:: pascal

    // drops all items in a "snake order" / "Z"-order
    Inventory.DropItems(DROP_PATTERN_SNAKE);

.. code-block:: pascal

    Inventory.DropItems([0..3]); // drops the four first items

Inventory.DropItemsExcept
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  procedure TRSInventory.DropItemsExcept(ignoreSlots:TIntegerArray; Slots:TIntegerArray = DROP_PATTERN_REGULAR);

Drops all the given items ``Slots`` except for the items in ``IgnoreSolots``

.. note:: by slacky

Inventory.FindItem
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.FindItem(Mask: TMask; Tolerance:Int32 = 30; ContourTolerance:Int32 = 30; MaxToFind:Byte = 28): TIntegerArray;
  function TRSInventory.FindItem(DTM: Integer; MaxToFind:Byte = 28): TIntegerArray; overload;
  function TRSInventory.FindItem(BMP: Integer; Tolerance:Int32; MaxToFind:Byte): TIntegerArray; overload;

Find the slots of the given item defined by a `TMask`, `DTM`, or `BMP`.

_Note: Last parameter is not defaulted in the last overload `FindItem(BMP..)` for technical reasons._

Example:
.. code-block:: pascal

    itemArr := Inventory.FindItem(myMask);
    if itemArr = [] then
      WriteLn('Not found');

Inventory.Count
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.Count(Mask: TMask; Tolerance, ContourTolerance:Int32=30): Int32; overload;
  function TRSInventory.Count(DTM: Integer): Int32; overload;
  function TRSInventory.Count(BMP: Integer; Tolerance:Int32): Int32; overload;

Counts the number of slots containing this item

Inventory.Contains
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.Contains(Mask: TMask; Tolerance, ContourTolerance:Int32=30): Boolean;
  function TRSInventory.Contains(DTM: Integer): Boolean; overload;
  function TRSInventory.Contains(BMP: Integer; Tolerance:Int32): Boolean; overload;

Returns true if the inventory contains the given item

Inventory.GetActiveSlot
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.GetActiveSlot(): Int8;

Returns the index to the current active slot, returns `-1` if none.

Inventory.Use
~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.Use(Slot: Int32): Boolean;

RS correct alias for Inventory.ActivateSlot.

Inventory.ActivateSlot
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.ActivateSlot(Slot: Int32): Boolean;

Activates (Presses) the given slot, however if `Slot` is `-1` then it will disable the current active slot.

Inventory.WaitCount
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSInventory.WaitCount(Amount: Int32; Time: Int32; Compare: TComparator = __EQ__): Boolean;

Waits for intentory amount to meet expected size. By default it waits till it's equal
to given Amount, but can wait till it's not equal, less than or greater than.
