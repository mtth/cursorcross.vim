Cursorcross.vim
===============

Refreshingly sane ``cursorcolumn`` and ``cursorline`` handling.


Features
--------

* Window specific ``cursorcolumn`` and ``cursorline`` states.
* Implements *dynamic mode* which automatically sets:

  * ``cursorcolumn`` and ``nocursorline`` in insert mode
  * ``nocursorcolumn`` and ``cursorline`` in normal mode

When leaving a window both options are turned off, and are restored when 
revisiting that window. This way a single window has cursor highlighting at any 
given time, which makes it much easier to find the currently active one.


Commands
--------

* ``CursorcrossToggle``, toggles dynamic mode.
* ``CursorcrossRestore``, in case case you are temporarily disabling 
  autocommands and automatic restoration of cursor highlighting fails, you can 
  use this command to reactivate the previous state.


Configuration
-------------

Four options are available:

* ``g:cursorcross_disable = 0``, disable the plugin.
* ``g:cursorcross_dynamic = 1``, turn on dynamic mode when VIM starts.
* ``g:cursorcross_exceptions = []``, list of filetypes where dynamic mode will 
  be disabled.
* ``g:cursorcross_mappings = 1``, create the following mappings:

  * ``-`` to toggle ``cursorline``.
  * ``|`` to toggle ``cursorcolumn``.
  * ``+`` to toggle dynamic mode.
