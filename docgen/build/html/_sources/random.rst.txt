
srl.GaussRand
~~~~~
.. code-block:: pascal

  function TSRL.GaussRand(mean, dev: Double): Double;

Generates a random gaussian/normal number.

srl.TruncatedGauss
~~~~~
.. code-block:: pascal

  function TSRL.TruncatedGauss(Left:Double=0; Right:Double=1): Double;

Generates a random gaussian/normal number which is truncated and mapped within then 
given range ``[left..right]`` weighted towards ``left``

srl.SkewedRand
~~~~~
.. code-block:: pascal

  function TSRL.SkewedRand(Mode, Lo, Hi: Double): Double; static;

Random skewed distribution generation. `Mode` is a number between `Lo` and `Hi` which is 
where the most of the generated numbers will land.

srl.NormalRange
~~~~~
.. code-block:: pascal

  function TSRL.NormalRange(min, max: Int64): Int64;

Generates a random integer in the given range, weighted towards the mean.

srl.NormalRange
~~~~~
.. code-block:: pascal

  function TSRL.NormalRange(min, max: Double): Double;

Generates a random float in the given range, weighted towards the mean.

srl.RandomPoint
~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TSRL.RandomPoint(mean: TPoint; maxRad: Int32): TPoint;

Generates a random TPoint which weights around ``mean``, with a max distance 
from mean defined by ``maxRad``.

srl.RandomPoint (overload)
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TSRL.RandomPoint(bounds:TBox): TPoint; overload;

Generates a random TPoint in the bounds of the given box `bounds`, 
the point weights towards the middle of the box.

srl.RandomPoint (overload)
~~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TSRL.RandomPoint(rect: TRectangle): TPoint; overload;

Generates a random TPoint in the given rectangle `rect`,
The point weights towards the middle of the rectangle.

srl.RandonPointEx
~~~~~
.. code-block:: pascal

  function TSRL.RandonPointEx(From:TPoint; B: TBox; Force:Double=0.35): TPoint; constref;

Generates a random point within the bounds of the given box `B`, the point generated is skewed towards towards the `From`-point.
The last parameter `Force` defines how much the generated point is to be skewed towards or away from `From` - Expects value in the range 0..2

  Force = 0: Result weighs heavily towrads the edge closest to `From`
  Force = 1: Result in the middle of box is most common
  Force = 2: Result weighs heavily towrads the edge furthest away from `From`

Wait (overload)
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  procedure Wait(min, max:Double; weight:EWaitDir=wdMean); overload;

Waits ... Weighted towards the mean of `min` and `max`

WaitEx
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  procedure WaitEx(mean, dev:Double);

Waits ... Regular gauss random

srl.rowp
~~~~~~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function TSRL.rowp(From: TPoint; Rect: TRectangle; Force: Double=-0.9; Smoothness: Double=PI/12): TPoint;
  function TSRL.rowp(From: TPoint; Box: TBox; Force: Double=-0.9; Smoothness: Double=PI/12): TPoint;

rowp, short for `Random Olly Weighted Point`. Generates a random point based on
a rough formula that Olly came up with for weighting points towards "From" point.
Final implementation and math done by slacky.

Force ranges from -1 (close to) to 1 (away from), where 0 is mean, but with a bit of a skewiness...
