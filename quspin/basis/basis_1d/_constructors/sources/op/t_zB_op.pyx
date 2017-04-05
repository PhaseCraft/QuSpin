

cdef float f_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, float k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef float nr,nc
	cdef float ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if True:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def f_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, float complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[float,ndim=1] ME
	cdef float k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = f_spinop(basis,opstr,indx,J)

	if True and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= f_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error




cdef double d_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, double k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef double nr,nc
	cdef double ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if True:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def d_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, double complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[double,ndim=1] ME
	cdef double k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = d_spinop(basis,opstr,indx,J)

	if True and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= d_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error




cdef float complex F_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, float k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef float nr,nc
	cdef float complex ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if False:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def F_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, float complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[float complex,ndim=1] ME
	cdef float k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = F_spinop(basis,opstr,indx,J)

	if False and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= F_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error




cdef double complex D_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, double k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef double nr,nc
	cdef double complex ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if False:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def D_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, double complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[double complex,ndim=1] ME
	cdef double k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = D_spinop(basis,opstr,indx,J)

	if False and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= D_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error




cdef long double g_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, long double k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef long double nr,nc
	cdef long double ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if True:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def g_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, long double complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[long double,ndim=1] ME
	cdef long double k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = g_spinop(basis,opstr,indx,J)

	if True and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= g_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error




cdef long double complex G_MatrixElement_ZB(int L,int zBblock, int kblock, int a, int l, long double k, int gB,NP_INT8_t Nr,NP_INT8_t Nc,NP_INT8_t mr,NP_INT8_t mc):
	cdef long double nr,nc
	cdef long double complex ME
	

	if mr >=0:
		nr = (1 + zBblock*cos(k*mr))/Nr
	else:
		nr = 1.0/Nr

	if mc >= 0:
		nc = (1 + zBblock*cos(k*mc))/Nc
	else:
		nc = 1.0/Nc


	ME=sqrt(nc/nr)*(zBblock**gB)

	if False:
		ME *= (-1)**(2*l*a*kblock/L)
	else:
		ME *= (cos(k*l) - 1.0j * sin(k*l))

	return ME



def G_t_zB_op(_np.ndarray[NP_INT8_t,ndim=1] N,_np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis, str opstr, _np.ndarray[NP_INT32_t,ndim=1] indx, long double complex J, int L, int zBblock, int kblock, int a):
	cdef unsigned int s
	cdef int error,ss,i,Ns,l,gB
	cdef _np.ndarray[NP_UINT32_t,ndim = 1] R = _np.zeros(3,NP_UINT32)
	cdef _np.ndarray[NP_INT32_t,ndim=1] row
	cdef _np.ndarray[long double complex,ndim=1] ME
	cdef long double k = (2.0*_np.pi*kblock*a)/L


	Ns = basis.shape[0]
	row,ME,error = G_spinop(basis,opstr,indx,J)

	if False and (2*kblock*a % L) != 0:
		error = -1

	if error != 0:
		return row,ME,error

	for i in range(Ns):
		s = row[i]
		RefState_T_ZB(s,L,a,R)

		s = R[0]
		l = R[1]
		gB = R[2]

		ss = findzstate(basis,Ns,s)
		row[i] = ss
		if ss == -1: continue

		ME[i] *= G_MatrixElement_ZB(L,zBblock,kblock,a,l,k,gB,N[i],N[ss],m[i],m[ss])
			

	return row,ME,error


