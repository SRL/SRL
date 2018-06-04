
Math
=======
Math related methods

srl.Modulo
~~~~~~~~~~
.. code-block:: pascal

    function TSRL.Modulo(X, Y: Double): Double;

This function returns the remainder from the division of the first argument by the second.
It will always returns a result with the same sign as its second operand (or zero).

Example:

.. code-block:: pascal

    Writeln(srl.Modulo(a, b));

srl.Modulo; overload
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.Modulo(X, Y: Int32): Int32; overload;

Integer overload for Modulo.

srl.CrossProduct
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.CrossProduct(ry,ry, px,py, qx,qy: Double): Double;
    
Cross-product of rp and rq vectors.

srl.CrossProduct; overload;
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.CrossProduct(r, p, q: TPoint): Int64; overload;
    
Cross-product of rp and rq vectors.

srl.DeltaAngle
~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.DeltaAngle(DegA, DegB: Double; R: Double = 360): Double;

Returns the shortest difference between two given angles.

srl.DistToLine
~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.DistToLineEx(Pt, sA, sB: TPoint; out Nearest: TPoint): Double;
    function TSRL.DistToLine(Pt, sA, sB: TPoint): Double;

Returns the distance to the nearest point on the line `sA`..`sB`

srl.LinesIntersect
~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.LinesIntersect(p1,p2, q1,q2:TPoint; out i: TPoint): Boolean;

srl.PointInRect
~~~~~~~~~~~~~~~
.. code-block:: pascal

    function TSRL.PointInRect(const Pt: TPoint; const A, B, C, D: TPoint): Boolean;

Returns true if the TPoint 'Pt' is in a rect (defined by four points).

Example:

.. code-block:: pascal

    Writeln(srl.PointInRect(Point(100, 100), [0,0], [200,1], [201,201], [0,225]));
