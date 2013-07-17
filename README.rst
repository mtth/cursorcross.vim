Cursorcross.vim
===============

Adequately sane ``cursorcolumn`` and ``cursorline`` handling.

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
* ``CursorcrossToggle``, toggles dynamic mode (if it was turned on/off by one of the above commands, this will restore it to its previous value)


Configuration
-------------

Four options are available:

* ``g:cursorcross_debug``, surprise [default: 0]
* ``g:cursorcross_disable``, disable the plugin [default: 0]
* ``g:cursorcross_dynamic``, turn on dynamic mode when VIM starts [default: 1]
* ``g:cursorcross_mappings``, create mappings [default: 1]
