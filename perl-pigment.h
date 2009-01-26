#include <gtk2perl.h>
#include <pgm/pgm.h>
#include "pigment-autogen.h"

#define PERL_PIGMENT_ASSERT_ERROR(error) \
	if (error != PGM_ERROR_OK) { \
		croak ("Generic pigment error"); \
	}
