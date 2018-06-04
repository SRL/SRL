
WorldSwitcher.GetWorld
~~~~~~~~~~~~~~~~~~~~~~

  function TRSWorldSwitcher.GetWorld(Filter: TRSWorldFilter): Int32; overload;

Selects a random world which isn't a filter world and has no filter properties.

Example:
.. code-block:: pascal

  // Returns a random world that isn't world 302 and isn't a free world.
  World := WorldSwitcher.GetWorld([[WORLD_FREE], [302]]);
