
Text
=======
Text related methods

type TRSChooseOption
~~~~~~~~~~~~~~~~~~~~
.. code-block:: pascal

  function SRL.FormatNumber(n:Extended; dec:Byte=3; mode:ENumberFormat=formatRS): String; constref;

Adds a single character-suffix to shorten numbers, and turn them into a string.
Two modes are defined, one for RS and one using the SI prefix.
* abbrRS: '', 'K', 'M', 'B', 'T'
* abbrSI: '', 'K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'

The RS prefix is default, since SRL mainly focuses on RS.
