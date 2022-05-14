{ 10-05-1999 10:37:17 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 06-04-1999 2:43:08 AM > [martin on MARTIN] checked out /Test changes }
{ 06-04-1999 1:46:39 AM > [martin on MARTIN] check in: (0.0) Initial Version
   / None }
unit MCHPipeTypes;

{Martin Harvey 22/9/98

Definition of types required for MCHPipe DLL}

interface

const
  PipeDLLName = 'MCHPipe';

type
  TMCHHandle = integer;
  TMCHError = (meOK,
    meBadHandle,
    meClientNotConnected,
    meServerNotConnected,
    meAlreadyConnected,
    meDLLNotLoaded);


implementation

end.

