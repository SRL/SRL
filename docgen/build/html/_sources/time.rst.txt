
Time
=======
Time related methods

TTimeMarker
~~~~~~~~~~~

.. code-block:: pascal

    type TTimeMarker = record
        time, startTime: LongWord;
        paused: Boolean;
    end;

Timer type which is useful for loops, timing and writing progress reports.

.. note::

    - by Bart de Boer

TTimeMarker.Start
~~~~~~~~~~~~~~~~~

.. code-block pascal

    procedure TTimeMarker.Start();

Starts the timer. Can also be used when paused to continue where it left.

.. note::

    - by Bart de Boer

Example:

.. code-block:: pascal

    myTimer.Start();

TTimeMarker.Reset
~~~~~~~~~~~~~~~~~

.. code-block pascal

    procedure TTimeMarker.Reset();

Stops the timer and resets it to zero.

.. note::

    - by Bart de Boer

Example:

.. code-block:: pascal

    myTimer.Reset();

TTimeMarker.Pause
~~~~~~~~~~~~~~~~~

.. code-block pascal

    procedure TTimeMarker.Pause();

Pauses the timer. It can be continued with start().

.. note::

    - by Bart de Boer

Example:

.. code-block:: pascal

    myTimer.Pause();
    TakeABreak(90000);
    myTimer.Start();

TTimeMarker.GetTime
~~~~~~~~~~~~~~~~~~~

.. code-block pascal

    function TTimeMarker.GetTime(): UInt64;

Gets the time from the timer. Returns zero if the timer was not set.

.. note::

    - by Bart de Boer

Example:

.. code-block:: pascal

    myTimer.start();
    repeat
      DoStuff;
    until(myTimer.GetTime() > 60000);


TTimeMarker.GetTotalTime
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block pascal

    function TTimeMarker.GetTotalTime(): UInt64;

Gets the time from the timer including the time it was paused. Returns zero if
the timer was not set.

.. note::

    - by Bart de Boer

Example:

.. code-block:: pascal

    BreakTime := MyTimer.GetTotalTime() - MyTimer.GetTime();


TCountDown
~~~~~~~~~~~~~~~~~~~
A neat and simple timer type.

Example:

.. code-block:: pascal

  myTimer.Init(3000); //3000ms
  while not myTimer.IsFinished() do
    {do something};
  
  myTimer.Restart(Random(-200,200)); //3000 +/- 200ms
  while not myTimer.IsFinished() do
    {do something};
