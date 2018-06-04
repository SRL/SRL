
Options
=======
The options file holds functions and procedures that are used for configuring runescape.

type TRSOptions
~~~~~~~~~~~~~~~
The type that holds functions and properties of the Runescape options interface.

var Options
~~~~~~~~~~~
Variable that stores functions and properties of the Runescape options interface.

type EOptionsTab
~~~~~~~~~~~~~~~
A type that covers the internal tabs in TRSOptions: ``EOptionsTab = (optDisplay, optAudio, optChat, optControls)``

Options.Open
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.Open(): Boolean;

Opens the interface

Options.IsOpen
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.IsOpen(maxWait:Int32=0): Boolean;

Checks if the interface is already open.

Options.GetCurrentTab
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.GetCurrentTab(): EOptionsTab;

Returns which tab is currently active.

Options.SetCurrentTab
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.SetCurrentTab(Tab: EOptionsTab; tryTime:Int32=2000): Boolean;

Sets the current tab to the given ``Tab``

Options.GetBrightness
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.GetBrightness(): Int32;

Returns the mainscreen brightness

Options.SetBrightness
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.SetBrightness(level: Int32; tryTime:Int32=2000): Boolean;

Sets the mainscreen brightness

Options.GetZoom
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.GetZoom(): Int32;

Returns the mainscreen zoom

Options.SetZoom
~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.SetZoom(APosition: Byte): Boolean;

Sets the zoom of the mainscreen. 0 = Zoomed out, 100 = Zoomed in.

Options.ToggleAcceptAid
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleAcceptAid(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button to the given state.

Options.ToggleRun
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleRun(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button to the given state.

Options.ToggleChatEffects
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleChatEffects(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button to the given state.

Options.ToggleSplitPrivChat
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleSplitPrivChat(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button to the given state.

Options.ToggleProfanityFilter
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleProfanityFilter(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button to the given state.

Options.ToggleTimeoutNotice
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleTimeoutNotice(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button for "Login/Logout notification timeout" to the given state.

Options.ToggleShiftDrop
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSOptions.ToggleShiftDrop(enable:Boolean; tryTime:Int32=2000): Boolean;

Changes the state of the button for "Shift Drop" to the given state.
