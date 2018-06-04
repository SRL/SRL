
BankScreen
==========
This file stores all methods that are used in the bankscreen-iterface.
All methods here are called with the bankscreen ``BankScreen`` variable.

.. code-block:: pascal

    Writeln(BankScreen.IsOpen());

BankScreen.IsOpen
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.IsOpen(): Boolean;

returns True if the bankscreen is open

BankScreen.OpenAt
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.OpenAt(P: TPoint): Boolean;

returns True if the bankscreen could be open'd at given location `P`

BankScreen._MagicalBankerFinder
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen._MagicalBankerFinder(BoothTopColor: TCTS2Color; BankerColor: EBankerColor; Offset: TPoint): Boolean;

Calculates and finds where a bank NPC should be based from the bank booth.

BankScreen.Open
~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.Open(Loc: EBankLocation; Tries: Int32 = 3): Boolean;

Opens the bankscreen at the selected bank location.

BankScreen.Close
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.Close(): Boolean;

Closes the bankscreen, returns True on success

BankScreen.ClickButton
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.ClickButton(btn: EBankButton; clickType: Integer = mouse_Left): Boolean;

Toggles the button

BankScreen.IsToggled
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.IsToggled(btn: EBankButton; minMatch:Int32=50): Boolean;

Checks if the given button is red/toggled

Bankscreen.PointToSlot
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.PointToSlot(pt:TPoint): Int32;

Returns the slot-index under the given TPoint.
If it's not over a slot then -1 is returned

BankScreen.ItemIn
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.ItemIn(Slot: UInt32): Boolean;
  function TRSBankScreen.IsSlotUsed(Slot: UInt32): Boolean;

Returns True if there's an item in the given slot.
Alias `IsSlotUsed` exists for naming compatiblity with Inventory.

BankScreen.DepositAll
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.DepositAll(): Boolean;

Depositis your inventory by clicking the deposit inventory button

 Depeosit a single item, or all of it's kind from inventory.

 Deposit all your items, retries two times.

BankScreen.RearrangeMode
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.RearrangeMode(mode:EBankButton): Boolean;

Changes the way items are moved around, valid options are ``bbSwap`` and ``bbInsert``.

BankScreen.WithdrawAs
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.WithdrawAs(mode:EBankButton): Boolean;

Changes the way items are withdrawn. Valid options are ``bbItem`` and ``bbNote``

BankScreen.Search
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.Search(item:String): Boolean;

Search for an item using the search option in the bank.

BankScreen.Withdraw
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSBankScreen.Withdraw(slot, amount:Int32; upText:TStringArray=[]; withdrawMode:EBankButton=bbItem): Boolean;

Withdraws the the amount ``amount`` from the bank slot ``slot``. If it fails to withdraw it will return False

Extra vaild constants for ``amount`` are:

   - ``WITHDRAW_ALL = -1;``
   - ``WITHDRAW_ALL_BUT_ONE = -2;``


.. note:: by slacky

Example:

.. code-block:: pascal

    // withdraw 28 items from slot 1 if uptext matches
    bankscreen.Withdraw(1, 28, ['Iron']);

    // withdraw 500 items as notes from slot 1 if uptext matches
    bankscreen.Withdraw(1, 500, ['Iron'], bbNote);

    // withdraw all items from slot 10 if uptext matches
    bankscreen.Withdraw(10, WITHDRAW_ALL, ['Iron']);

    // withdraw 28 items from slot 1 and will *ignore* uptext
    bankscreen.Withdraw(1, 28);

PinScreen
==========
This file also stores all methods that are used in the pinscreen-iterface.

Technically, I think you can call `PinScreen.EnterPin` to determine if the 
bankscreen interface is open, by doing so it would enter the pin if there is one. 

I think at some point this should probably be handled automatically by bankscreen
looking at the code this will be a bit troublesome now? - slacky

.. code-block:: pascal

    WriteLn(PinScreen.EnterPin()); // returns True if we got to the bank
