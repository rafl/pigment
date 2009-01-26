#include "perl-pigment.h"

MODULE = Pigment::Event  PACKAGE = Pigment::Event

PgmEventType
get_type (PgmEvent *event)
	CODE:
		RETVAL = event->type;
	OUTPUT:
		RETVAL
