/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "rpc.h"
#include <stdio.h>
#include <stdlib.h>
#include <rpc/pmap_clnt.h>
#include <string.h>
#include <memory.h>
#include <sys/socket.h>
#include <netinet/in.h>

#ifndef SIG_PF
#define SIG_PF void(*)(int)
#endif

static void
xmeasure_prog_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		nX xmeasure_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case xMeasure:
		_xdr_argument = (xdrproc_t) xdr_nX;
		_xdr_result = (xdrproc_t) xdr_float;
		local = (char *(*)(char *, struct svc_req *)) xmeasure_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

static void
xyinnerprod_prog_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		nXY xyinnerprod_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case xyInnerProd:
		_xdr_argument = (xdrproc_t) xdr_nXY;
		_xdr_result = (xdrproc_t) xdr_int;
		local = (char *(*)(char *, struct svc_req *)) xyinnerprod_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

static void
xyavg_prog_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		nXY xyavg_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case xyAvg:
		_xdr_argument = (xdrproc_t) xdr_nXY;
		_xdr_result = (xdrproc_t) xdr_float_array;
		local = (char *(*)(char *, struct svc_req *)) xyavg_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

static void
xyrprod_prog_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		nXYr xyrprod_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case xyRProd:
		_xdr_argument = (xdrproc_t) xdr_nXYr;
		_xdr_result = (xdrproc_t) xdr_float_array;
		local = (char *(*)(char *, struct svc_req *)) xyrprod_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

int
main (int argc, char **argv)
{
	register SVCXPRT *transp;

	pmap_unset (xMeasure_PROG, xMeasure_VERS);
	pmap_unset (xyInnerProd_PROG, xyInnerProd_VERS);
	pmap_unset (xyAvg_PROG, xyAvg_VERS);
	pmap_unset (xyRProd_PROG, xyRProd_VERS);

	transp = svcudp_create(RPC_ANYSOCK);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create udp service.");
		exit(1);
	}
	if (!svc_register(transp, xMeasure_PROG, xMeasure_VERS, xmeasure_prog_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (xMeasure_PROG, xMeasure_VERS, udp).");
		exit(1);
	}
	if (!svc_register(transp, xyInnerProd_PROG, xyInnerProd_VERS, xyinnerprod_prog_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (xyInnerProd_PROG, xyInnerProd_VERS, udp).");
		exit(1);
	}
	if (!svc_register(transp, xyAvg_PROG, xyAvg_VERS, xyavg_prog_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (xyAvg_PROG, xyAvg_VERS, udp).");
		exit(1);
	}
	if (!svc_register(transp, xyRProd_PROG, xyRProd_VERS, xyrprod_prog_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (xyRProd_PROG, xyRProd_VERS, udp).");
		exit(1);
	}

	transp = svctcp_create(RPC_ANYSOCK, 0, 0);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create tcp service.");
		exit(1);
	}
	if (!svc_register(transp, xMeasure_PROG, xMeasure_VERS, xmeasure_prog_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (xMeasure_PROG, xMeasure_VERS, tcp).");
		exit(1);
	}
	if (!svc_register(transp, xyInnerProd_PROG, xyInnerProd_VERS, xyinnerprod_prog_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (xyInnerProd_PROG, xyInnerProd_VERS, tcp).");
		exit(1);
	}
	if (!svc_register(transp, xyAvg_PROG, xyAvg_VERS, xyavg_prog_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (xyAvg_PROG, xyAvg_VERS, tcp).");
		exit(1);
	}
	if (!svc_register(transp, xyRProd_PROG, xyRProd_VERS, xyrprod_prog_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (xyRProd_PROG, xyRProd_VERS, tcp).");
		exit(1);
	}

	svc_run ();
	fprintf (stderr, "%s", "svc_run returned");
	exit (1);
	/* NOTREACHED */
}