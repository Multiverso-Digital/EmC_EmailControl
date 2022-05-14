                          S M A R T T R A N S L A T O R
                         ===============================
                                    Version 1.41

SmartTranslator helps you translating a delphi project to other languages. In
the first step, it collects all strings in the pascal code and delphi forms
and stores them in a database. After all strings are translated, which can be
done inside SmartTranslator, it can replace all strings of the original language
with the corresponding strings of another language. Strings that appear in
more than one project have to be translated only one time. Once SmartTranslator
knows all necessary strings, you can transfer a project to another language
within one minunte. In comparasion to other localizing tools, SmartTranslator
stores only the strings of one language in an executable (which produces much
smaller executables) and does not need any changes on your project. There is
also no need to collect strings in stringtable resources.


INSTALLATION
~~~~~~~~~~~~
No installation reqiured, just place the files of the zip archive at a place
you want and start SmartTranslate.exe. SmartTranslator requires BDE 5.0 or
later and works with projects of Delphi 5 or later.


TIPS & ANNOTATIONS
~~~~~~~~~~~~~~~~~~
* Currently SmartTranslator will only find the files of a project, which
  are located in the same folder as the .dpr file.
* Click on the column headers to sort the strings according a specific
  language. This will place emtpy strings (which are missing a translation)
  to the top of the list.
* In the statusbar, you can see the date at which a string was found the last
  time in a source code. Additionally you can see the file name, line number and
  a snippet of the source in which it occured. This can be very helpful when
  translating a string, since the translation may vary dependant on the context.
* If you have strings in your .PAS files, that contain the name of controls,
  events or registry keys, be careful not to translate them. This could
  prevent your program to work as expected.
* It is usually a good idea to use SmartTranslator on a copy of your delphi
  project. When copying a delphi project, don't copy the .DSK file, otherwise
  Delphi shows the files and forms of the original location in the IDE.
* You can use the "Export selected column" function to run a spell checker
  over your strings.



COPYRIGHT & LICENSE
~~~~~~~~~~~~~~~~~~~
SmartTranslator is mailware, which means you can use it without charge and
distribute the complete archive. If you decide to use it, you must send us an
e-mail or a postcard. Please include the version number of your copy, where
you found it and problems or errors if you had some. Source code is available
for $49 or EUR 49.
                                       Copyright ©1999-2003 by Joachim Marder


CONTACT
~~~~~~~
JAM Software
Joachim Marder
Südallee 35
D-54290 Trier

E-Mail  : marder@jam-software.com
WWW-Page: http://www.jam-software.com


CHANGES
~~~~~~~
Version 1.41: Released on 16.07.2003
* SmartTranslate 1.4 was compiled with Delphi 6 and it seems that it doesn't
  work any more with Delphi 4.
* SmartTranslate is now writing plain text DFM files, which Delphi is able to
  read since version 5.
* Some minor bug fixes.

Version 1.4: Released on 13 Feb 2003
* New function "Export selected column" which can e.g. be used to run a spell
  checker over your strings.
* New function "Show All columns" which makes all columns of the databse visible.
  This should only be used by advanced users if they want to do something very
  special.

Version 1.3: Released on
* Previous version were not working properly with inherited forms. This is
  corrected now.
* Ported to and compiled with Dephi 6

Version 1.2: Released on 02 August 2002
* The date when a string was collected the last time is now displayed in the
  status bar
* The context in which the string has been found is now also displayed in the
  status bar
* The Paradox table containing the strings is compressed from time to time
* The window size and state and the column widths are now saved in the registry

Version 1.1: Released on 18 Apr 2002
* Previous version did not handle correctly if a string belonged to more than
  one project.
* Some problems around the project combo box have been fixed.

Version 1.0: 10 Apr 2001
* A german index was missing in the database definition, which could cause some
  errors when working with german projects
  
Version 1.0 beta 5: 07 Mar 2001
* SmartTranslate now always handles single quotes in strings correctly
* Some minor bug fixes

Version 1.0 beta 4: 16 Nov 2000
* SmartTranslator is now able to work with .DFM files which are saved as plain
  ASCII text (like Delphi 5 uses them) instead of Borland's binary format.

Version 1.0 beta 3: 27 Jun 2000
* Some parsing problems were fixed that caused "Invalid Stream Format" errors
* An options dialog has been added in which you can choose a charset for each
  column
* Some minor bug fixes

Version 1.0 beta 2: Released on 31 Aug 1999
* beta 1 was compiled with Delphi 4 which prevented it to work with the BDE of
  Delphi 3, beta 2 is now compiled with Delphi 3.
* Now for each string the Project name is saved.
* Some minor improvements and bug fixes

Version 1.0 beta 1: Released on 14 May 1999
* First public release
