Cursorcross.vim
===============

Refreshingly sane ``cursorcolumn`` and ``cursorline`` handling.


Features
--------

Provides the mappings:

* ``-`` to toggle ``cursorline``
* ``|`` to toggle ``cursorcolumn``
* ``+`` to toggle *dynamic mode*

When activated, *dynamic mode* automatically toggles:

* ``cursorcolumn`` and ``nocursorline`` in insert mode
* ``nocursorcolumn`` and ``cursorline`` in normal mode

The following commands are also available:

* ``CursorcrossOff``, turns dynamic mode off
* ``CursorcrossOn``, turns dynamic mode on
* ``CursorcrossToggle``, toggles dynamic mode (if it was turned on/off by one 
  of the two previous commands, this will restore it to its previous value). 
  Add a bang to force the options to be immediately changed accordingly.


Configuration
-------------

Four options are available:

* ``g:cursorcross_debug``, surprise [default: 0]
* ``g:cursorcross_disable``, disable the plugin [default: 0]
* ``g:cursorcross_dynamic``, turn on dynamic mode when VIM starts [default: 1]
* ``g:cursorcross_exceptions``, list of filetypes where dynamic mode will be 
  disabled [default: []].
* ``g:cursorcross_mappings``, create mappings [default: 1]
