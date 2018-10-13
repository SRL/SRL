
Chatbox
=======
The chatbox file holds functions and procedures that are used in the
Runescape chat box.

type TRSChatbox
~~~~~~~~~~~~~~~
The type that holds functions and properties of the Runescape chat box interface.

var Chatbox
~~~~~~~~~~~
Variable that stores functions and properties of the Runescape chatbox interface.

const CHATBOX_COLORS
~~~~~~~~~~~~~~~~~~~~
constant that holds all the possible text-colors

Chatbox.GetTextOnLine
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSChatbox.GetTextOnLine(line: Int32; colors:TIntegerArray = CHATBOX_COLORS): String;

Returns the text at the given line ``[0..8]``. 8 is the last line (the input-field)

.. note:: by slacky

Example:
.. code-block:: pascal

    // returns the text at line 6
    chatbox.GetTextOnLine(6);

Chatbox.FindTextOnLines
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.FindTextOnLines(txt: TStringArray; lines: TIntegerArray; colors:TIntegerArray = CHATBOX_COLORS): boolean;

Returns true if the text in 'txt' is found on the 'lines' of the chatbox.  The
lines start with 0 being the bottom chat line.

.. note:: by slacky

Example:

.. code-block:: pascal

    // returns True if "Hello" is found on the first 4 lines
    chatbox.FindTextOnLines(['Hello'], [0..3]);

Chatbox.GetLastMessage
~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TRSChatbox.GetLastMessage(colors:TIntegerArray = CHATBOX_COLORS): String;

Returns the text at the last line in the chatbox

.. note:: by slacky

Chatbox.GetChatArea
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GetChatArea(): TBox;

Returns a TBox which only covers the chat-area, does not include the scrollbar and input-field.

.. note:: by slacky

Chatbox.ClickContinue
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ClickContinue(SpamClick: Boolean = False): Boolean;

Clicks the "Click here to continue"-text in the chatbox.
Returns `True` if the text was found.

.. note:: by slacky

Chatbox.GotLevelUp
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GotLevelUp(): Boolean;

Returns `True` if text containing `Congratulations` was found

Chatbox.HandleLevelUp
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.HandleLevelUp(): Boolean;

Clicks the "Click here to continue" if text containing `Congratulations` was found

.. note:: by Olly

Chatbox.GetOptions
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GetOptions(TextColors: TIntegerArray = [clBlack, clWhite]): array of TChatOption;

Returns all the options found in teh chatbox area

Chatbox.ClickOption
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ClickOption(const Text: TStringArray; TextColors: TIntegerArray = [clBlack, clWhite]): Boolean;
    function TRSChatbox.ClickOption(const Text: TStringArray; WaitTime: Integer; TextColors: TIntegerArray = [clBlack, clWhite]): Boolean; overload;

Clicks the preferred option by text. If the option cant be found it will return with `False`.

Chatbox.PleaseWait
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.PleaseWait(): Boolean;

Waits as long as the "Please wait" text exists.

Chatbox.ChatToOption
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ChatToOption(Option: TStringArray; ClickOption: Boolean; TextColors: TIntegerArray = [clBlack, clWhite]): Boolean;

I have no clue wtf this is. Therefor it's either a stupid or an awesome function!
Seems to be a function that should have been named something like `ContinueToOption` (as in click continue until it no longer can)

Chatbox.GetDisplayName
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GetDisplayName(): String;

Returns your username / display name

Chatbox.ClickTab
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ClickTab(tab: EChatTab; Option: String = ''): Boolean;

A tab would be the filters for the chatbox. So you click one of them..

Chatbox.GetQuery
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GetQuery(answer:Boolean=False): String;

Returns the question-text, like "Enter amount:" when doing "Withdraw X" from a bank.
If `answer` is `True` it returns the value you have filled in.

Chatbox.WaitQuery
~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.WaitQuery(Query: String; WaitTime: Int32): Boolean;

Wait till the query shows up. If it doesn't show up within `WaitTime` it returns `False`.

Chatbox.AnswerQuery
~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.AnswerQuery(Query, Response: String; WaitTime: Int32; PressEnter:Boolean=True): Boolean;

Answer the query, first it will wait for the quary `Query` to show up, then it fills in the given `Response`.

Chatbox.GetButtonQuery
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.GetButtonQuery(): String;

Returns the question-text, like "What would you like to smelt"

Chatbox.WaitButtonQuery
~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.WaitButtonQuery(Query: String; WaitTime: Int32): Boolean;

Wait till the query shows up. If it doesn't show up within `WaitTime` it returns `False`.

Chatbox.ClickButtonId
~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ClickButtonId(Query: String; Id:Int32; UpText:String; WaitTime: Int32): Boolean;

Clicks the button `Id`, checks uptext to verify that the corrrect button was clicked
If the given button id doesn't match the UpText it will sift through the other buttons looking for it.

Chatbox.ClickButtonColor
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatbox.ClickButtonColor(Query: String; Color, Tolerance:Int32; UpText:String; WaitTime: Int32): Boolean;

Clicks the button matching both color and uptext, starting with the one that had the best
initial match, and then sifting down to less good matches.

Chatbox.GetTitle
~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatBox.GetTitle: String;

Returns the title of a chatbox interaction such as the NPC name.

.. note:: by Olly

Chatbox.GetNotification
~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TRSChatBox.GetNotification: String;

Returns the title of a chatbox notification such as the "inventory is too full".
