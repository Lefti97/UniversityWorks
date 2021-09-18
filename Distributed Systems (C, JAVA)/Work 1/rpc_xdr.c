/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "rpc.h"

bool_t
xdr_nX (XDR *xdrs, nX *objp)
{
	register int32_t *buf;

	 if (!xdr_int (xdrs, &objp->n))
		 return FALSE;
	 if (!xdr_array (xdrs, (char **)&objp->X.X_val, (u_int *) &objp->X.X_len, ~0,
		sizeof (int), (xdrproc_t) xdr_int))
		 return FALSE;
	return TRUE;
}

bool_t
xdr_nXY (XDR *xdrs, nXY *objp)
{
	register int32_t *buf;

	 if (!xdr_int (xdrs, &objp->n))
		 return FALSE;
	 if (!xdr_array (xdrs, (char **)&objp->X.X_val, (u_int *) &objp->X.X_len, ~0,
		sizeof (int), (xdrproc_t) xdr_int))
		 return FALSE;
	 if (!xdr_array (xdrs, (char **)&objp->Y.Y_val, (u_int *) &objp->Y.Y_len, ~0,
		sizeof (int), (xdrproc_t) xdr_int))
		 return FALSE;
	return TRUE;
}

bool_t
xdr_nXYr (XDR *xdrs, nXYr *objp)
{
	register int32_t *buf;

	 if (!xdr_int (xdrs, &objp->n))
		 return FALSE;
	 if (!xdr_array (xdrs, (char **)&objp->X.X_val, (u_int *) &objp->X.X_len, ~0,
		sizeof (int), (xdrproc_t) xdr_int))
		 return FALSE;
	 if (!xdr_array (xdrs, (char **)&objp->Y.Y_val, (u_int *) &objp->Y.Y_len, ~0,
		sizeof (int), (xdrproc_t) xdr_int))
		 return FALSE;
	 if (!xdr_float (xdrs, &objp->r))
		 return FALSE;
	return TRUE;
}

bool_t
xdr_float_array (XDR *xdrs, float_array *objp)
{
	register int32_t *buf;

	 if (!xdr_array (xdrs, (char **)&objp->arr.arr_val, (u_int *) &objp->arr.arr_len, ~0,
		sizeof (float), (xdrproc_t) xdr_float))
		 return FALSE;
	return TRUE;
}
