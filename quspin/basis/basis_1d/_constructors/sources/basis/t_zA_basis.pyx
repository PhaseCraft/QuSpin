def make_m_t_zA_basis(int L,int Nup,int zAblock,int kblock,int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis): 
	cdef double k 
	
	cdef unsigned int Ns,s
	cdef NP_INT8_t mzA,r
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	cdef char stp
	

	k = 2.0*_np.pi*kblock*a/L

	cdef int j

	s = 0
	for j in range(Nup):
		s += ( 1ull << j )

	stp = 0
	Ns = 0
	

	while True:
		CheckState_T_ZA(kblock,L,s,a,R)
		r = R[0]
		mzA = R[1]

		if r > 0:
			if mzA != -1:
				if 1 + zAblock*cos(k*mzA) == 0:
					r = -1				

			if r > 0:
				m[Ns] = mzA
				N[Ns] = r			
				basis[Ns] = s
				Ns += 1	

		stp = 1 & ( s >> (L-1) ) 
		for i in range(1,Nup):
			stp &= 1 & ( s >> (L-i-1) )

		if stp or (s == 0):
			break
		
		s = next_state(s)
				

	return Ns


def make_t_zA_basis(int L,int zAblock,int kblock,int a, _np.ndarray[NP_INT8_t,ndim=1] N, _np.ndarray[NP_INT8_t,ndim=1] m, _np.ndarray[NP_UINT32_t,ndim=1] basis): 
	cdef double k 
	cdef unsigned long long s
	cdef int Ns
	cdef NP_INT8_t mzA,r
	cdef _np.ndarray[NP_INT8_t,ndim=1] R = _np.zeros(2,dtype=NP_INT8)
	cdef char stp

	k = 2.0*_np.pi*kblock*a/L
	stp = 0
	Ns = 0

	for s in range(1ull << L):
		CheckState_T_ZA(kblock,L,s,a,R)
		r = R[0]
		mzA = R[1]
		if r > 0:
			if mzA != -1:
				if 1 + zAblock*cos(k*mzA) == 0:
					continue					

			m[Ns] = mzA
			N[Ns] = r			
			basis[Ns] = s
			Ns += 1	


	return Ns
