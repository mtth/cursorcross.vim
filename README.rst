Cursorcross.vim
===============

Refreshingly sane ``cursorcolumn`` and ``cursorline`` handling.


Configuration
-------------

Four options are available:

* ``g:cursorcross_dynamic = 'clw'``, which features to dynamically handle:

  * :code:`'c'` triggers :code:`cursorcolumn` in insert mode when the cursor 
    is at the beginning of the line.
  * :code:`'l'` activates :code:`cursorline` in normal mode and turns it off 
    when entering insert mode.
  * :code:`'w'` automatically disables :code:`cursorcolumn` and 
    :code:`cursorline` in non-focused windows. When entering a window, both 
    variables are restored to their previous state.

* ``g:cursorcross_exceptions = []``, list of filetypes where dynamic mode will 
  be disabled.
* ``g:cursorcross_disable = 0``, disable the plugin.
* ``g:cursorcross_mappings = 1``, create the following mappings:

  * ``-`` to toggle ``cursorline``.
  * ``|`` to toggle ``cursorcolumn``.

Additionally, the `CursorcrossToggle` command can be used to disable all 
dynamic modes globally.
